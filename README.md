# ShopTitans Sentinel

A lightweight Windows batch sentinel that automatically detects, monitors, and relaunches ShopTitans on Steam or Epic Games, enabling uninterrupted sessions so you can leave your game running 24/7—whether you’re sleeping, working, or away from your machine. Designed to operate discreetly in the background without drawing attention.

**Note:** This script is **not** a game bot or automation tool. It only ensures the game stays open and running.

## Features

- **Auto-detects** game installation on Steam (including secondary libraries) or Epic Games.
- **Real-time monitoring** of the `ShopTitans.exe` process.
- **Automatic restart** via Steam or direct executable launch.
- **Uptime tracking** and **restart counter** displayed in console.
- **Customisable** check interval and launch parameters.
- **Production-ready** with concise logging and clear user prompts.

## Requirements

- Windows 10 or later
- Batch (CMD) environment
- ShopTitans installed via Steam or Epic Games

## Installation

1. Clone or download this repository:
   ```powershell
   git clone https://github.com/Ryux411/ShopTitan-Sentinel.git
   ```
2. Place the `shop-monitor.bat` script in any folder you prefer.

## Configuration

- **Script name:** `shop-monitor.bat`
- **Interval:** Modify `CheckInterval` variable inside the script (default: 1 second).
- **AppID:** For Steam launches, replace the placeholder AppID (`1258080`) with the actual ShopTitans AppID in the script.

## Usage

1. In File Explorer, locate the `shop-monitor.bat` file.
2. Right-click on `shop-monitor.bat` and choose **Run as administrator**.
3. Authorise the UAC prompt by clicking **Yes**.
4. A console window will open, showing live status, uptime and restart counts—do not close this window while monitoring.
5. (Optional) To run on Windows startup with admin privileges:
   - Right-click `shop-monitor.bat` → **Create shortcut**.
   - Right-click the shortcut → **Properties** → **Shortcut** → **Advanced** → check **Run as administrator** → **OK**.
   - Move the shortcut to `%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup`.

## Logging

Each status and action is echoed in the console. No external log files are created by default.

## Customisation

- Change the **check interval** by editing the `CheckInterval` variable.
- Add extra actions (e.g., keystrokes) by inserting PowerShell `SendKeys` commands in the restart logic section.

## Contributing

Contributions, issues, and feature requests are welcome. Please open an issue or submit a pull request.

Know anyone else plagued by unexpected shutdowns? Share this script to keep their game running non-stop!

## Licence

MIT © CyberNinja
