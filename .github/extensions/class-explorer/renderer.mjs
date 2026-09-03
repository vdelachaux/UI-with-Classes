import { readFile, readdir } from "node:fs/promises";
import { extname, join } from "node:path";

const PARENTS = {
    widget: "static",
    button: "widget",
    scrollable: "widget",
    input: "scrollable",
    picture: "scrollable",
    listbox: "scrollable",
    hList: "scrollable",
    subform: "scrollable",
    dropDown: "widget",
    comboBox: "dropDown",
    selector: "widget",
    stepper: "widget",
    thermometer: "widget",
    tabControl: "widget",
    webArea: "widget",
};

const CATEGORIES = {
    form: "Foundation",
    static: "Foundation",
    widget: "Foundation",
    button: "Widget",
    scrollable: "Widget",
    input: "Widget",
    picture: "Widget",
    listbox: "Widget",
    hList: "Widget",
    subform: "Widget",
    dropDown: "Widget",
    comboBox: "Widget",
    selector: "Widget",
    stepper: "Widget",
    thermometer: "Widget",
    tabControl: "Widget",
    webArea: "Widget",
    constraints: "Layout",
    coordinates: "Layout",
    dimensions: "Layout",
    rect: "Layout",
    group: "Layout",
    colors: "Appearance",
    window: "Window",
    evt: "Helper",
    _evtCst: "Helper",
    menu: "Helper",
    menuBar: "Helper",
    onBoard: "Helper",
    tips: "Helper",
};

function descriptionFrom(markdown) {
    return markdown
        .split(/\r?\n/)
        .slice(1)
        .map((line) => line.trim())
        .find((line) => line && !/^(#|<|!\[|\*)/.test(line))
        ?.replace(/\[([^\]]+)\]\([^)]+\)/g, "$1")
        .replace(/[`*_]/g, "") ?? "UI with Classes API reference.";
}

export async function createClassCatalog(workspacePath) {
    const documentationPath = join(workspacePath, "Documentation", "Classes");
    const sourcePath = join(workspacePath, "Project", "Sources", "Classes");
    const names = (await readdir(documentationPath))
        .filter((name) => extname(name) === ".md")
        .map((name) => name.slice(0, -3))
        .sort((left, right) => left.localeCompare(right));

    const records = new Map();
    await Promise.all(
        names.map(async (name) => {
            const markdown = await readFile(join(documentationPath, `${name}.md`), "utf8");
            let source = "";
            try {
                source = await readFile(join(sourcePath, `${name}.4dm`), "utf8");
            } catch {
                // Documentation-only entries are still useful in the explorer.
            }
            records.set(name, {
                name,
                displayName: `cs.${name}`,
                category: CATEGORIES[name] ?? "Other",
                parent: PARENTS[name] ?? null,
                description: descriptionFrom(markdown),
                markdown,
                source,
            });
        }),
    );

    for (const record of records.values()) {
        record.children = names.filter((name) => PARENTS[name] === record.name);
    }

    const list = () =>
        [...records.values()].map(({ markdown, source, ...record }) => record);
    const summary = (name) => {
        const record = records.get(name);
        return record
            ? {
                  className: record.name,
                  displayName: record.displayName,
                  category: record.category,
                  parent: record.parent,
                  children: record.children,
                  description: record.description,
              }
            : null;
    };

    return {
        get: (name) => records.get(name),
        has: (name) => records.has(name),
        list,
        summary,
    };
}

function sendJson(response, status, value) {
    response.writeHead(status, {
        "Content-Type": "application/json; charset=utf-8",
        "Cache-Control": "no-store",
    });
    response.end(JSON.stringify(value));
}

async function readJson(request) {
    const chunks = [];
    for await (const chunk of request) {
        chunks.push(chunk);
    }
    return JSON.parse(Buffer.concat(chunks).toString("utf8") || "{}");
}

export async function handleRequest({
    request,
    response,
    catalog,
    clients,
    state,
    selectClass,
    html,
}) {
    const url = new URL(request.url ?? "/", "http://127.0.0.1");

    try {
        if (request.method === "GET" && url.pathname === "/") {
            response.writeHead(200, {
                "Content-Type": "text/html; charset=utf-8",
                "Content-Security-Policy":
                    "default-src 'self'; style-src 'unsafe-inline'; script-src 'unsafe-inline'",
            });
            response.end(html);
            return;
        }

        if (request.method === "GET" && url.pathname === "/events") {
            response.writeHead(200, {
                "Content-Type": "text/event-stream",
                "Cache-Control": "no-cache",
                Connection: "keep-alive",
            });
            response.write(`data: ${JSON.stringify({ className: state.selected })}\n\n`);
            clients.add(response);
            request.on("close", () => clients.delete(response));
            return;
        }

        if (request.method === "GET" && url.pathname === "/api/classes") {
            sendJson(response, 200, {
                selected: state.selected,
                classes: catalog.list(),
            });
            return;
        }

        if (request.method === "GET" && url.pathname.startsWith("/api/classes/")) {
            const className = decodeURIComponent(url.pathname.slice("/api/classes/".length));
            const record = catalog.get(className);
            if (!record) {
                sendJson(response, 404, { error: `Unknown UI class: ${className}` });
                return;
            }
            sendJson(response, 200, record);
            return;
        }

        if (request.method === "POST" && url.pathname === "/api/select") {
            const input = await readJson(request);
            sendJson(response, 200, selectClass(input.className));
            return;
        }

        sendJson(response, 404, { error: "Not found" });
    } catch (error) {
        sendJson(response, 400, {
            error: error instanceof Error ? error.message : String(error),
        });
    }
}

export function renderHtml(instanceId) {
    return `<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>UI Class Explorer</title>
  <style>
    * { box-sizing: border-box; }
    html, body { height: 100%; }
    body {
      margin: 0;
      overflow: hidden;
      background: var(--background-color-default, #fff);
      color: var(--text-color-default, #1f2328);
      font-family: var(--font-sans, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif);
      font-size: var(--text-body-medium, 14px);
      line-height: var(--leading-body-medium, 20px);
    }
    button, input { font: inherit; }
    .app { display: grid; grid-template-columns: 270px minmax(0, 1fr); height: 100%; }
    .sidebar {
      display: flex; flex-direction: column; min-width: 0;
      border-right: 1px solid var(--border-color-default, #d0d7de);
      background: color-mix(in srgb, var(--background-color-default, #fff) 94%, var(--text-color-default, #1f2328));
    }
    .brand { padding: 20px 18px 14px; }
    .eyebrow {
      margin: 0 0 3px; color: var(--text-color-muted, #656d76);
      font-size: 11px; font-weight: var(--font-weight-semibold, 600);
      letter-spacing: .09em; text-transform: uppercase;
    }
    .brand h1 {
      margin: 0; font-size: var(--text-title-medium, 20px);
      line-height: var(--leading-title-medium, 26px);
    }
    .search-wrap { padding: 0 12px 12px; }
    .search {
      width: 100%; border: 1px solid var(--border-color-default, #d0d7de);
      border-radius: 7px; padding: 7px 10px;
      background: var(--background-color-default, #fff);
      color: var(--text-color-default, #1f2328); outline: none;
    }
    .search:focus { border-color: var(--color-focus-outline, #0969da); box-shadow: 0 0 0 2px color-mix(in srgb, var(--color-focus-outline, #0969da) 25%, transparent); }
    .nav { flex: 1; overflow: auto; padding: 0 8px 18px; }
    .category { margin-top: 10px; }
    .category-title {
      padding: 5px 10px; color: var(--text-color-muted, #656d76);
      font-size: 11px; font-weight: var(--font-weight-semibold, 600);
      letter-spacing: .06em; text-transform: uppercase;
    }
    .class-button {
      display: flex; width: 100%; align-items: center; gap: 8px;
      border: 0; border-radius: 6px; padding: 7px 10px;
      background: transparent; color: inherit; text-align: left; cursor: pointer;
    }
    .class-button:hover { background: color-mix(in srgb, var(--true-color-blue-muted, #ddf4ff) 55%, transparent); }
    .class-button.active {
      background: var(--true-color-blue-muted, #ddf4ff);
      color: var(--true-color-blue, #0969da); font-weight: var(--font-weight-semibold, 600);
    }
    .class-button code { overflow: hidden; text-overflow: ellipsis; }
    .depth {
      width: 8px; height: 8px; border: 1px solid currentColor;
      border-radius: 50%; flex: none; opacity: .7;
    }
    .main { min-width: 0; height: 100%; overflow: auto; }
    .content { width: min(920px, 100%); margin: 0 auto; padding: 42px 42px 80px; }
    .hero { padding-bottom: 24px; border-bottom: 1px solid var(--border-color-default, #d0d7de); }
    .hero-row { display: flex; align-items: start; justify-content: space-between; gap: 20px; }
    .hero h2 {
      margin: 2px 0 8px; font-family: var(--font-mono, monospace);
      font-size: var(--text-title-large, 26px); line-height: var(--leading-title-large, 32px);
    }
    .summary { max-width: 700px; margin: 0; color: var(--text-color-muted, #656d76); }
    .badge {
      flex: none; border: 1px solid var(--border-color-default, #d0d7de);
      border-radius: 999px; padding: 3px 9px; color: var(--text-color-muted, #656d76);
      font-size: 12px;
    }
    .relations { display: flex; flex-wrap: wrap; gap: 8px; margin-top: 17px; align-items: center; }
    .relation-label { color: var(--text-color-muted, #656d76); font-size: 12px; }
    .relation {
      border: 1px solid var(--border-color-default, #d0d7de); border-radius: 999px;
      padding: 3px 9px; background: transparent; color: inherit; cursor: pointer;
    }
    .relation:hover { border-color: var(--color-focus-outline, #0969da); color: var(--true-color-blue, #0969da); }
    .tabs { display: flex; gap: 18px; margin: 24px 0 4px; border-bottom: 1px solid var(--border-color-default, #d0d7de); }
    .tab {
      border: 0; border-bottom: 2px solid transparent; padding: 8px 1px 9px;
      background: transparent; color: var(--text-color-muted, #656d76); cursor: pointer;
    }
    .tab.active { border-bottom-color: var(--true-color-blue, #0969da); color: inherit; font-weight: var(--font-weight-semibold, 600); }
    .doc { padding-top: 18px; }
    .doc h1 { display: none; }
    .doc h2 { margin: 30px 0 12px; font-size: 20px; }
    .doc h3 { margin: 24px 0 8px; font-size: 16px; }
    .doc p { margin: 10px 0; }
    .doc a { color: var(--true-color-blue, #0969da); text-decoration: none; }
    .doc code, .class-button code {
      font-family: var(--font-mono, "SFMono-Regular", Consolas, monospace);
      font-size: var(--text-code-inline, 12px);
    }
    .doc :not(pre) > code {
      border: 1px solid var(--border-color-default, #d0d7de); border-radius: 4px;
      padding: 1px 4px; background: color-mix(in srgb, var(--background-color-default, #fff) 88%, var(--text-color-default, #1f2328));
    }
    pre {
      overflow: auto; border: 1px solid var(--border-color-default, #d0d7de);
      border-radius: 8px; padding: 14px;
      background: color-mix(in srgb, var(--background-color-default, #fff) 92%, var(--text-color-default, #1f2328));
    }
    table { width: 100%; border-collapse: collapse; margin: 12px 0 22px; font-size: 13px; }
    th, td { border: 1px solid var(--border-color-default, #d0d7de); padding: 7px 9px; text-align: left; vertical-align: top; }
    th { background: color-mix(in srgb, var(--background-color-default, #fff) 90%, var(--text-color-default, #1f2328)); }
    blockquote { margin: 14px 0; padding: 2px 14px; border-left: 3px solid var(--true-color-blue, #0969da); color: var(--text-color-muted, #656d76); }
    .source-meta { margin: 18px 0 8px; color: var(--text-color-muted, #656d76); font-size: 12px; }
    .empty { padding: 60px 20px; text-align: center; color: var(--text-color-muted, #656d76); }
    .loading { opacity: .55; }
    @media (max-width: 720px) {
      .app { grid-template-columns: 210px minmax(0, 1fr); }
      .content { padding: 28px 24px 60px; }
      .hero-row { display: block; }
      .badge { display: inline-block; margin-top: 12px; }
    }
  </style>
</head>
<body>
  <div class="app">
    <aside class="sidebar">
      <header class="brand">
        <p class="eyebrow">UI with Classes</p>
        <h1>Class Explorer</h1>
      </header>
      <div class="search-wrap"><input class="search" id="search" type="search" placeholder="Filter classes..." autocomplete="off"></div>
      <nav class="nav" id="nav"></nav>
    </aside>
    <main class="main" id="main">
      <article class="content loading" id="content"><div class="empty">Loading class catalog...</div></article>
    </main>
  </div>
  <script>
    const instanceId = ${JSON.stringify(instanceId)};
    const nav = document.querySelector("#nav");
    const content = document.querySelector("#content");
    const search = document.querySelector("#search");
    const main = document.querySelector("#main");
    let classes = [];
    let selected = "";
    let activeTab = "docs";

    const escapeHtml = (value) => String(value ?? "")
      .replaceAll("&", "&amp;").replaceAll("<", "&lt;")
      .replaceAll(">", "&gt;").replaceAll('"', "&quot;");

    function inline(value) {
      return escapeHtml(value)
        .replace(/!\\[[^\\]]*\\]\\([^)]+\\)/g, "")
        .replace(/\\[([^\\]]+)\\]\\([^)]+\\)/g, "$1")
        .replace(/\\*\\*([^*]+)\\*\\*/g, "<strong>$1</strong>")
        .replace(/\x60([^\x60]+)\x60/g, "<code>$1</code>");
    }

    function markdown(value) {
      const lines = value.replaceAll("\\r", "").split("\\n");
      let html = "";
      let paragraph = [];
      let list = [];
      let code = [];
      let inCode = false;
      const flushParagraph = () => {
        if (paragraph.length) html += "<p>" + inline(paragraph.join(" ")) + "</p>";
        paragraph = [];
      };
      const flushList = () => {
        if (list.length) html += "<ul>" + list.map((item) => "<li>" + inline(item) + "</li>").join("") + "</ul>";
        list = [];
      };
      const flushCode = () => {
        html += "<pre><code>" + escapeHtml(code.join("\\n")) + "</code></pre>";
        code = [];
      };

      for (let index = 0; index < lines.length; index++) {
        const line = lines[index];
        if (line.startsWith("\`\`\`")) {
          flushParagraph(); flushList();
          if (inCode) flushCode();
          inCode = !inCode;
          continue;
        }
        if (inCode) { code.push(line); continue; }
        if (/^\\s*\\|/.test(line) && /^\\s*\\|?\\s*:?-+/.test(lines[index + 1] ?? "")) {
          flushParagraph(); flushList();
          const rows = [];
          while (index < lines.length && /^\\s*\\|/.test(lines[index])) rows.push(lines[index++]);
          index--;
          const cells = (row) => row.replace(/^\\s*\\||\\|\\s*$/g, "").split("|").map((cell) => cell.trim());
          const headers = cells(rows[0]);
          html += "<table><thead><tr>" + headers.map((cell) => "<th>" + inline(cell) + "</th>").join("") + "</tr></thead><tbody>";
          for (const row of rows.slice(2)) html += "<tr>" + cells(row).map((cell) => "<td>" + inline(cell) + "</td>").join("") + "</tr>";
          html += "</tbody></table>";
          continue;
        }
        const heading = line.match(/^(#{1,3})\\s+(.*)$/);
        if (heading) {
          flushParagraph(); flushList();
          const level = heading[1].length;
          html += "<h" + level + ">" + inline(heading[2].replace(/<[^>]+>/g, "")) + "</h" + level + ">";
          continue;
        }
        const item = line.match(/^\\s*[*-]\\s+(.*)$/);
        if (item) { flushParagraph(); list.push(item[1]); continue; }
        if (line.startsWith(">")) {
          flushParagraph(); flushList();
          html += "<blockquote>" + inline(line.replace(/^>\\s?/, "")) + "</blockquote>";
          continue;
        }
        if (!line.trim() || /^\\s*<(img|br|hr)/i.test(line)) {
          flushParagraph(); flushList(); continue;
        }
        paragraph.push(line.trim());
      }
      flushParagraph(); flushList();
      if (inCode) flushCode();
      return html;
    }

    const groupOrder = ["Foundation", "Widget", "Layout", "Appearance", "Window", "Helper", "Other"];

    function renderNav() {
      const query = search.value.trim().toLowerCase();
      const filtered = classes.filter((item) =>
        item.name.toLowerCase().includes(query) || item.description.toLowerCase().includes(query)
      );
      nav.innerHTML = groupOrder.map((category) => {
        const items = filtered.filter((item) => item.category === category);
        if (!items.length) return "";
        return '<section class="category"><div class="category-title">' + category + "</div>" +
          items.map((item) =>
            '<button class="class-button ' + (item.name === selected ? "active" : "") +
            '" data-class="' + escapeHtml(item.name) + '"><span class="depth"></span><code>' +
            escapeHtml(item.displayName) + "</code></button>"
          ).join("") + "</section>";
      }).join("") || '<div class="empty">No matching classes</div>';
      nav.querySelectorAll("[data-class]").forEach((button) =>
        button.addEventListener("click", () => choose(button.dataset.class))
      );
    }

    function relation(label, names) {
      if (!names?.length) return "";
      return '<span class="relation-label">' + label + "</span>" +
        names.map((name) => '<button class="relation" data-relation="' + escapeHtml(name) +
          '"><code>cs.' + escapeHtml(name) + "</code></button>").join("");
    }

    async function show(className, updateServer = false) {
      const response = await fetch("/api/classes/" + encodeURIComponent(className));
      if (!response.ok) return;
      const item = await response.json();
      selected = item.name;
      renderNav();
      const relations = relation("Inherits", item.parent ? [item.parent] : []) +
        relation("Extended by", item.children);
      content.innerHTML =
        '<header class="hero"><div class="hero-row"><div><p class="eyebrow">4D class</p><h2>' +
        escapeHtml(item.displayName) + '</h2><p class="summary">' + escapeHtml(item.description) +
        '</p></div><span class="badge">' + escapeHtml(item.category) + '</span></div>' +
        (relations ? '<div class="relations">' + relations + '</div>' : "") + '</header>' +
        '<div class="tabs"><button class="tab ' + (activeTab === "docs" ? "active" : "") +
        '" data-tab="docs">Documentation</button><button class="tab ' +
        (activeTab === "source" ? "active" : "") + '" data-tab="source">4D source</button></div>' +
        '<section class="doc" id="panel"></section>';
      content.classList.remove("loading");
      renderPanel(item);
      content.querySelectorAll("[data-relation]").forEach((button) =>
        button.addEventListener("click", () => choose(button.dataset.relation))
      );
      content.querySelectorAll("[data-tab]").forEach((button) =>
        button.addEventListener("click", () => {
          activeTab = button.dataset.tab;
          show(selected);
        })
      );
      if (updateServer) {
        await fetch("/api/select", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ className }),
        });
      }
    }

    function renderPanel(item) {
      const panel = document.querySelector("#panel");
      if (activeTab === "source") {
        panel.innerHTML = item.source
          ? '<p class="source-meta">Project/Sources/Classes/' + escapeHtml(item.name) +
            '.4dm</p><pre><code>' + escapeHtml(item.source) + "</code></pre>"
          : '<div class="empty">No matching 4D source file.</div>';
      } else {
        panel.innerHTML = markdown(item.markdown);
      }
    }

    async function choose(className) {
      main.scrollTop = 0;
      await show(className, true);
    }

    search.addEventListener("input", renderNav);
    new EventSource("/events").onmessage = (event) => {
      const payload = JSON.parse(event.data);
      if (payload.className && payload.className !== selected) show(payload.className);
    };

    fetch("/api/classes").then((response) => response.json()).then((payload) => {
      classes = payload.classes;
      renderNav();
      show(payload.selected);
    });
  </script>
</body>
</html>`;
}
