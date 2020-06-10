# QuickGuide | MacOS

## Shortcuts

### General Shortcuts

| Combination | Description |
| --- | --- |
| `cmd + space` | Opens Spotlight Search |
| `ctrl + up/down arrow` | Zooms out/in open windows/desktops |
| `ctrl + command + q` | Lock screen |
| `ctrl + shift + 5` | Screen shot tool |
| `ctrl + shift + 4` | Screen annotation tool |

### Finder Shortcuts

| Combination | Description |
| --- | --- |
| `ctrl + shift + g` | Go to folder path |
| `ctrl + del` | Move to trash |
| `ctrl + shift + del` | Delete permanently |

### Terminal Shortcuts

| Combination | Description |
| --- | --- |
| `ctrl + r` | reverse-i-serarch |

## Commands

### Terminal Commands

| Command | Description |
| --- | --- |
| `brew services list` | list all services |
| `brew services stop nginx` | stop nginx service |
| `lsof -i tcp -nP | grep 80` | list all files using tcp protocol, with network numbers and portnumbers, then greps for 80 |

### Iterm2 Shortcuts

> <https://www.iterm2.com/>

| Command | Description |
| --- | --- |
| `cmd + T` | new tab |
| `cmd + N` | new window |
| `cmd + D` | split pane vertically |
| `cmd + shift + D` | split pane horizontally |
| `opt + cmd + ↑` | select pane above |
| `opt + cmd + ↓` | select pane below |
| `opt + cmd + ←` | select pane left |
| `opt + cmd + →` | select pane right |
| `cmd + return` | toggle full screen view |
| `cmd + shift + opt` | hold and drag and drop windows to merge |

### Magnet Shortcuts

> <https://magnet.crowdcafe.com/>

| Command | Description |
| --- | --- |
| `cmd + D` | split pane vertically |
| `cmd + shift + D` | split pane horizontally |
| `ctl + opt + cmd + →` | move window to next display |
| `ctl + opt + cmd + ←` | move window to prev display |
| `ctl + opt + cmd + ←` | move window to prev display |

### Hacks

Open multiple urls stored in a file in separate browser tabs

```bash
cat urls-one | xargs open -a "Google Chrome"
```

Convert html to plain text

```bash
textutil -convert txt *.html
```
