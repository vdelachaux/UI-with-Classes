# UI Classes — Cheat Sheet

Quick reference for the `UI-with-Classes` component. For the full API see
[Classes-diagram.md](../Classes-diagram.md); per-class details in [Classes/](Classes/).

---

## 1. Minimal skeleton

```4d
// Class _myDialog_Controller
Class constructor
	This.form:=cs.form.new(This)   // the form owns everything
	This.form.init()

Function init()                    // instantiate the widgets you act on
	This.pwd:=This.form.Input("Input")
	This.ok:=This.form.Button("Button")

Function handleEvents($e : cs.evt)
	$e:=$e || cs.evt.new()
	If ($e.form)                   // FORM events
		Case of
			: ($e.load)
				This.form.onLoad()
		End case
	Else                           // WIDGET events
		Case of
			: (This.ok.catch($e; [On Clicked]))
				ACCEPT
			: (This.pwd.catch())
				This.ok.enable(This.pwd.isNotEmpty)
		End case
	End if

Function onLoad()
	cs.menuBar.new().defaultMinimalMenuBar().set()
	This.form.window.title:="Passkey"
	This.form.Group(This.ok; This.cancel).distributeRigthToLeft()
```

Form method (single object method) just calls `<controller>.handleEvents(FORM Event)`.

---

## 2. Class map (who inherits what)

```
cs.form  ─── owns ──▶ static · window · constraints · group · (all widgets)
cs.static  (geometry / appearance / move / resize / align / colors)
   └─ cs.widget  (value / events / focus / drag&drop / shortcut / help tip)
        ├─ cs.button        push/3D/popup buttons, pictures, states
        ├─ cs.scrollable    scrollbars + scroll position
        │    ├─ cs.input       text input, filter, placeholder, selection
        │    ├─ cs.picture     picture I/O, thumbnails, composition
        │    ├─ cs.listbox     list box (array / collection / entitySel / hierarchical)
        │    ├─ cs.hList       hierarchical list (item tree)
        │    └─ cs.subform     embedded subform + its own form
        ├─ cs.dropDown      combo/drop-down list, value validation
        │    └─ cs.comboBox    predictive typing, auto-insertion
        ├─ cs.selector      segmented selector (values ↔ binding)
        ├─ cs.stepper       spinner control
        ├─ cs.thermometer   progress / barber / async indicator
        ├─ cs.tabControl    tab control (choice list or object)
        └─ cs.webArea       web area (navigate, JS, URL filtering)
cs.colors      foreground / background / altBackground helper  (static ..▶ colors)
cs.constraints fluent responsive layout rules
cs.group       group of objects: move / align / distribute
cs.window      the form window: geometry / state / actions
```

Standalone helpers: `cs.menu`, `cs.menuBar`, `cs.evt`.

---

## 3. Instantiate a widget — `This.form.<Factory>(name)`

| Factory | Returns | | Factory | Returns |
|---|---|---|---|---|
| `Button(name)` | cs.button | | `Listbox(name)` | cs.listbox |
| `Input(name)` | cs.input | | `HList(name; itemRef)` | cs.hList |
| `DropDown(name; data)` | cs.dropDown | | `Picture(name; data)` | cs.picture |
| `ComboBox(name; data)` | cs.comboBox | | `Subform(name; …)` | cs.subform |
| `Selector(name; values)` | cs.selector | | `WebArea(name; data)` | cs.webArea |
| `Stepper(name)` | cs.stepper | | `TabControl(name; data; page)` | cs.tabControl |
| `Thermometer(name)` | cs.thermometer | | `Scrollable(name; values)` | cs.scrollable |
| `Static(name)` | cs.static | | `Group(members; …)` | cs.group |

---

## 4. Common capabilities (inherited by every widget)

**Value / state** (`cs.widget`): `value` · `isEmpty` / `isNotEmpty` · `getValue()` / `setValue(v)` · `clear()` · `setDatasource(ds)` · `setEnterable(b)` / `notEnterable()`

**State & visibility** (`cs.static`): `enable(b)` / `disable()` · `show(b)` / `hide()` · `enabled` · `visible`

**Geometry** (`cs.static`): `width` `height` `left` `top` `right` `bottom` · `setWidth/​setHeight/​setRect/​setDimensions` · `getCoordinates()` / `setCoordinates(…)` · `rect` (cs.rect)

**Move** (`cs.static`): `moveLeft/Right/Up/Down(offset)` · `moveHorizontally/Vertically(offset)`

**Resize** (`cs.static`): `resizeHorizontally/Vertically(offset)` · `resize(offset)` · `moveAndResizeHorizontally/Vertically(…)`

**Best size** (`cs.static`): `bestSize(…)` · `bestHeight(width)` · `getBestWidth/getBestHeight(maxWidth)`

**Align** (`cs.static`): `alignLeft/Right/Top/Bottom()` · `alignCenter(vertical)`

**Colors** (`cs.static` / `cs.colors`): `setColors(fg; bg; altBg)` · `restore…Color()` · `removeBackgroundColor()`

**Font** (`cs.static`): `setFont(f)` · `setFontStyle(s)` · `fontSize`

**Focus / interaction** (`cs.widget`): `focus()` · `isFocused()` · `touch()` · `postClick()` · `execute()`

**Events** (`cs.widget`): `catch(e; events)` → Boolean · `addEvent/removeEvent/setEvents(…)`

**Shortcut / help tip** (`cs.widget`): `setShortcut(key; modifier)` · `setHelpTip(t)` / `removeHelpTip()`

**Drag & drop** (`cs.widget`): `setDraggable(…)` / `setNotDraggable()` · `setDroppable(…)` / `setNotDroppable()`

---

## 5. Per-class highlights

| Class | Use it for | Key members |
|---|---|---|
| **form** | Orchestrates the whole form | `init()` · `onLoad()` · `update()` · `focus/focusNext/focusPrevious` · `goToPage/nextPage/previousPage` · `setTimer/refresh/stopTimer` · `callWorker/callChild/callParent` · `beginDrag` · `getScreenshot` · widget factories |
| **static** | Any form object (label, line, box…) | geometry · move · resize · align · colors · font · `duplicate()` · `addToGroup()` |
| **widget** | Base for active objects | value · events · focus · shortcut · drag&drop (see §4) |
| **button** | Buttons (push/3D/popup) | `setStyle` · `setNumStates` · `setPicture/setBackgroundPicture` · `setLinkedPopupMenu/setSeparatePopupMenu` · `highlightShortcut` |
| **scrollable** | Anything scrollable | `setScrollbars(h; v)` · `noScrollbar()` · `getScrollPosition/setScrollPosition` |
| **input** | Text entry | `setPlaceholder` · `asPassword` · `setFilter` · `highlight(start; end)` · `backup/restore` · `swapDecimalSeparator` |
| **dropDown** | Drop-down / combo list | `values` · `value` · `index` · `reset(data)` · `inTheListOfValues(v)` · `checkValue(v)` |
| **comboBox** | Editable combo | `predictiveTyping(t)` · `expand()` · `insert(item)` · `order()` |
| **selector** | Segmented selector | `values` ↔ `binding` · `current` · `select(element)` |
| **stepper** | Spinner | `start()` · `stop()` · `isRunning()` |
| **thermometer** | Progress indicator | `progress/barber/asynchronous` · `start()` · `stop()` · `indicatorType(t)` |
| **tabControl** | Tabs | `goToPage()` · `enableTab/disableTab` · `data` / `dataSource` |
| **picture** | Picture object | `read(file)` · `thumbnail(w; h; mode)` · `horizontal/verticalConcatenation` · `superImposition` · `getAttribute/setAttribute` |
| **listbox** | List box | `setSource/setData` · `isCollection/isEntitySelection/isArray/isHierarchical` · `sort` · `select/selectAll/reveal` · `showColumn/hideColumn` · `setRowForegroundColor` · `collapse/expand` · `popup(menu)` · fluent `setSelectable/setSortable/setMovableLines` |
| **hList** | Hierarchical list | `create()` · `append/insert` · `collapse/expand(All)` · `findPosition/findReference` · `selectByPosition/Reference` |
| **subform** | Embedded subform | `setSubform(detail; list; table)` · `execute(formula)` · `refresh(delay)` · `focus/enable/disable(widget)` · `alignHorizontally` |
| **webArea** | Web area | `open(data)` · `setContent` · `load(file)` · `evaluateJS/executeJS` · `back/forward` · `zoom` · `allow/deny` (URL filter) · `showInspector` |
| **window** | The form window | `title` · `setRect/setDimensions/setCoordinates` · `resize` · `hide/show/close` · `reduce/maximize/minimize` · `bringToFront` · `drag` · `vibrate` |
| **constraints** | Responsive layout | fluent: `.of(target).anchorLeft(n)…apply()` · `centerHorizontally` · `fullWidth/fitWidth` · `marginLeft/Right` · `tile(v)` |
| **group** | A set of objects | `add(member)` · `move…` · `alignLeft/Top/Right` · `center` · `distributeLeftToRight/Vertically/AroundCenter` · `switch` · `show/hide/enable/disable` |
| **colors** | Color triplet helper | `foreground/background/altBackground` · `apply(target)` · `restore/remove…Color()` |

---

## 6. Standalone helpers

| Class | Use it for | Key members |
|---|---|---|
| **cs.evt** | Wrap the current form event | `.form` · `.load` · booleans per event; passed to `handleEvents` / `catch` |
| **cs.menu** | Build menus / pop-ups | `new()` · `append(title; submenu)` · used by `listbox.popup(menu)` |
| **cs.menuBar** | Application menu bar | `new().defaultMinimalMenuBar().set()` |

> Tip: most setters **return the object** (fluent), so you can chain:
> `This.ok.setHelpTip("…").disable()`.
