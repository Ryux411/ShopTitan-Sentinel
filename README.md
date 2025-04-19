# ShopTitans Watchdog

A lightweight Windows batch watchdog that automatically detects, monitors, and relaunches ShopTitans on Steam or Epic Games, enabling uninterrupted sessions so you can leave your game running 24/7—whether you’re sleeping, working, or away from your machine. Designed to operate discreetly in the background without drawing attention.

**Note:** This script is not a game bot or automation tool, though it can be used alongside one. It only ensures the game stays open and running.

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
   ```
   git clone https://github.com/Ryux411/ShopTitans-Watchdog.git
   ```
2. Place the `st-watchdog.bat` script in any folder you prefer.

## Usage

1. In File Explorer, locate the `st-watchdog.bat` file.
2. Right-click on `st-watchdog.bat` and choose **Run as administrator**.
3. Authorise the UAC prompt by clicking **Yes**.
4. A console window will open, showing live status, uptime and restart counts—do not close this window while monitoring.
5. (Optional) To run on Windows startup with admin privileges:
   - Right-click `st-watchdog.bat` → **Create shortcut**.
   - Right-click the shortcut → **Properties** → **Shortcut** → **Advanced** → check **Run as administrator** → **OK**.
   - Move the shortcut to `%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup`.

## Contributing

Contributions, issues, and feature requests are welcome. Please open an issue or submit a pull request.

Know anyone else plagued by unexpected shutdowns? Share this script to keep their game running non-stop!

## Licence

MIT © CyberNinja

