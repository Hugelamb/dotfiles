<div align="center">
    <img src="Icon.png" width="200" alt="Hyprland Clamshell Logo">
    <h1>Hyprland Advanced Clamshell Mode</h1>

[![Hyprland](https://img.shields.io/badge/Hyprland-Config-00a4e4?logo=archlinux&style=flat-square)](https://github.com/hyprwm/Hyprland)
[![Bash](https://img.shields.io/badge/Language-Bash-4EAA25?logo=gnu-bash&style=flat-square)](https://www.gnu.org/software/bash/)
[![License](https://img.shields.io/badge/License-MIT-blue?style=flat-square)](LICENSE)

</div>

An advanced and robust Bash script to manage **Clamshell Mode** (Lid closed with external monitor) on [Hyprland](https://github.com/hyprwm/Hyprland).

Unlike simple scripts, this solution handles **Hyprland reloads** gracefully and includes safety checks to prevent turning off the screen if no external monitor is found.

## ✨ Features

* **Safety First:** Prevents the internal screen from disabling if no external monitor is connected.
* **Reload Persistent:** Syncs the state correctly when reloading Hyprland config (`check` mode).
* **Visual Feedback:** Sends system notifications using `notify-send`.
* **Lightweight:** Pure Bash, no complex dependencies.
* **Status Bar Integration** exposes a function that returns current state of lid for other user applications/integrations. Could be used to for example, update a waybar's listed workspaces on a given monitor by moving them whenever the lid is closed. 
## 🚀 Installation

1.  Clone this repository or download `lidstatus.sh`.
2.  Make the script executable:
    ```bash
    chmod +x path/to/lidstatus.sh
    ```
3.  **Edit the script:** Change the `BUILTIN_DISPLAY` variable to match your monitor name (check it with `hyprctl monitors`). This is achieved by commenting out lines 12 & 13, and replacing uncommenting line 14, before adding your monitor name to the variable assignment to match the following: 
```
BUILTIN_DISPLAY="yourMonitorName"
```
If unsure as to what the default assignment is actually outputting, uncomment line 15 and run the script in your terminal using ./lidstatus.sh while in the same directory as the lidstatus.sh script

## ⚙️ Configuration (hyprland.conf)

Add these lines to your `hyprland.conf` or `autostart.conf`:

### 1. Event Bindings
These trigger the script when you actually open or close the lid.
```ini
bindl = , switch:on:Lid Switch, exec, /path/to/lidstatus.sh close
bindl = , switch:off:Lid Switch, exec, /path/to/lidstatus.sh open

```

### 2. Startup/Reload Check

**Crucial:** This ensures the correct state is applied when you log in or reload the config.

```ini
exec = /path/to/lidstatus.sh check

```

## 📋 Requirements

* Hyprland
* `libnotify` (for notifications)
* `grep` / `bash`

## 📄 License

MIT License
