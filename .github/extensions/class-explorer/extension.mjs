import { createServer } from "node:http";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { CanvasError, createCanvas, joinSession } from "@github/copilot-sdk/extension";
import {
    createClassCatalog,
    handleRequest,
    renderHtml,
} from "./renderer.mjs";

const servers = new Map();
const repositoryRoot = resolve(dirname(fileURLToPath(import.meta.url)), "../../..");

async function startServer(instanceId, initialClass) {
    const catalog = await createClassCatalog(repositoryRoot);
    const clients = new Set();
    const state = {
        selected: catalog.has(initialClass) ? initialClass : "form",
    };

    const selectClass = (className) => {
        if (!catalog.has(className)) {
            throw new CanvasError("class_not_found", `Unknown UI class: ${className}`);
        }

        state.selected = className;
        const payload = `data: ${JSON.stringify({ className })}\n\n`;
        for (const client of clients) {
            client.write(payload);
        }
        return catalog.summary(className);
    };

    const server = createServer((request, response) => {
        handleRequest({
            request,
            response,
            catalog,
            clients,
            state,
            selectClass,
            html: renderHtml(instanceId),
        });
    });

    await new Promise((resolve) => server.listen(0, "127.0.0.1", resolve));
    const address = server.address();
    const port = typeof address === "object" && address ? address.port : 0;
    return {
        server,
        selectClass,
        url: `http://127.0.0.1:${port}/`,
    };
}

const session = await joinSession({
    canvases: [
        createCanvas({
            id: "class-explorer",
            displayName: "UI Class Explorer",
            description: "Browse the UI with Classes hierarchy, APIs, documentation, and 4D source.",
            inputSchema: {
                type: "object",
                additionalProperties: false,
                properties: {
                    className: {
                        type: "string",
                        description: "Class to select when opening the explorer.",
                    },
                },
            },
            actions: [
                {
                    name: "select_class",
                    description: "Select a class and show its documentation in the open explorer.",
                    inputSchema: {
                        type: "object",
                        additionalProperties: false,
                        required: ["className"],
                        properties: {
                            className: {
                                type: "string",
                                minLength: 1,
                            },
                        },
                    },
                    handler: (ctx) => {
                        const entry = servers.get(ctx.instanceId);
                        if (!entry) {
                            throw new CanvasError("canvas_not_open", "The class explorer is not open.");
                        }
                        return entry.selectClass(ctx.input.className);
                    },
                },
            ],
            open: async (ctx) => {
                let entry = servers.get(ctx.instanceId);
                if (!entry) {
                    entry = await startServer(ctx.instanceId, ctx.input?.className);
                    servers.set(ctx.instanceId, entry);
                }
                return {
                    title: "UI Class Explorer",
                    status: "Repository documentation",
                    url: entry.url,
                };
            },
            onClose: async (ctx) => {
                const entry = servers.get(ctx.instanceId);
                if (entry) {
                    servers.delete(ctx.instanceId);
                    await new Promise((resolve) => entry.server.close(resolve));
                }
            },
        }),
    ],
});
