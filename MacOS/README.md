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

### Safari

| Combination | Description |
| --- | --- |
| ``command + ` `` | switch open windows |
| `command + shift + arrow keys` | switch open tabs |
| `ctrl + tab` | switch to next tabs |
| `ctrl + shift + tab` | switch to previous tabs |
| `command + t` | open new tab |
| `command + q` | close current tab |
| `command + q` | quit safari |
| `command + h` | hide safari |
| `command + l` | go to address bar |

## Commands

### Terminal Commands

| Command | Description |
| --- | --- |
| `brew services list` | list all services |
| `brew services stop nginx` | stop nginx service |
| `lsof -i tcp -nP | grep 80` | list all files using tcp protocol, with network numbers and portnumbers, then greps for 80 |
| `lsof -i -P -n | grep -i "listen"` | list listening ports |
| `lsof -i -P -n -i :80 -i :443 | grep "LISTEN"` | list listening ports on port 80 and 443 |
| `sysctl -a | grep [c,g]pu_thermal_level` | list cpu and gpu temperature |
| `sudo powermetrics | grep -i "CPU die temperature"` | list cpu die temperature |


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

Change permissions recursively targeted on either files or directories

```bash
# view octal permissions
stat -f '%Sp %OLp %N' /path/to/file-or-dir

# view permisisons on only files
find /path/to/file -type f -exec stat -f '%Sp %OLp %N' {} +

# view permisisons on only directories
find /path/to/file -type d -exec stat -f '%Sp %OLp %N' {} +

# change permissions on only files
find /path/to/dir -type f -exec chmod 644 {} +

# change permisisons on only directories
find /path/to/dir -type d -exec chmod 755 {} +

```

Date

```bash
# convert 
date -jf "%H:%M:%S" "08:11:02" +"%H-%M-%S"
```