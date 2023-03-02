# QuickGuide | VSCode

## Shortcuts

### Windows

| Command | Description |
| --- | --- |
| ``ctrl + shift + ` `` | Opens new terminal |
| `ctrl + shift + v` | Opens markdown preview tab. Needs the `markdown-preview` package installed |
| `alt + upward arrow` | Moves line up |
| `alt + downward arrow` | Moves line down |

### Mac

#### Editor

| Command | Description |
| --- | --- |
| `ctrl + shift + v` | Opens markdown preview tab. Needs the `markdown-preview` package installed |
| `cmd + \` | Split editor/terminal window |
| `alt + upward arrow` | Moves line up |
| `alt + downward arrow` | Moves line down |
| `opt + cmd + up/down arrows` | Span cursor across multiple lines |
| `opt + cmd + left/right arrows` | Toggle open panes / tabs |

#### Terminal

| Command | Description |
| --- | --- |
| ``ctrl + shift + ` `` | Opens new terminal |
| `ctrl + ~` | Show/hide panel |
| `ctrl + esc` | Maximize/minimize panel |
| `cmd + \` | Split terminal/editor window |

## Command menu options

| `>terminal:rename` | Rename currently active terminal |

## Key Bindings

- <https://code.visualstudio.com/docs/getstarted/keybindings>

Menu > Preferences > Keyboard Shortcuts:

Maximize Terminal / Panel

```json
{
    "key": "ctrl + Esc",
    "command": "workbench.action.toggleMaximizedPanel"
}
```

Focus on Editor

```json
{
    "key": "cmd + k",
    "command": "workbench.action.focusActiveEditorGroup",
}
```

Focus on Terminal

```json
{
    "key": "cmd + j",
    "command": "workbench.action.terminal.focus",
}
```

Color Customizations 

Cmd + Shift + P > Preferences: Open User Settings (JSON) > Add below after adding a comma: 

```json
    "workbench.colorCustomizations": {
        "terminal.findMatchBackground": "#ff0000",
        "terminal.findMatchBorder": "#ff0000",
        "terminal.findMatchHighlightBackground": "#ff0000",
        "terminal.findMatchHighlightBorder": "#ff0000",
        "terminalOverviewRuler.findMatchForeground": "#ff0000",
        "terminal.selectionBackground": "#e26cffcb",
    }

```

## References

- <https://itnext.io/easy-enhancements-for-vs-codes-terminal-6dda2c22ee5c>
