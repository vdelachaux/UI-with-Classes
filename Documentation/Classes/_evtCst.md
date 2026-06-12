# _evtCst

The `_evtCst` class is an internal singleton that centralizes event constants used by `cs.evt`.

## Purpose

This class stores:

* `_descriptions`: event code -> human-readable event name
* `_formEvents`: event code -> JSON event key

`cs.evt` now resolves event names/codes through this singleton, instead of embedding these arrays directly in `evt`.

## Access

Use singleton access:

```4d
cs._evtCst.me
```

## Notes

* This class is internal and primarily intended for framework-level use.
* Application code should generally use `cs.evt` high-level APIs.
