# ShopTitans Watchdog

A lightweight Windows batch watchdog that automatically detects, monitors, and relaunches ShopTitans on Steam or Epic Games, enabling uninterrupted sessions so you can leave your game running 24/7—whether you’re sleeping, working, or away from your machine. Designed to operate discreetly in the background without drawing attention.

**Note:** This script is not a game bot or automation tool, though it can be used alongside one. It only ensures the game stays open and running.

## Features

- **Auto-detects** game installation on Steam (including secondary libraries) or Epic Games.
- **Real-time monitoring** of the `ShopTitans.exe` process.
- **Automatic restart** via Steam or Epic Games Launcher.
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
2. Choose the correct script based on your platform:
   - For Steam: `ShopTitans_Steam_Watchdog.bat`
   - For Epic Games: `ShopTitans_Epic_Watchdog.bat`
3. Place the script in any folder you prefer.

## Usage

1. In File Explorer, locate the script for your platform:
   - **Steam:** `ShopTitans_Steam_Watchdog.bat`
   - **Epic Games:** `ShopTitans_Epic_Watchdog.bat`
2. Right-click the batch file and choose **Run as administrator**.
3. Authorise the UAC prompt by clicking **Yes**.
4. A console window will open, showing live status, uptime, and restart counts—do not close this window while monitoring.
5. (Optional) To run on Windows startup with admin privileges:
   - Right-click the script → **Create shortcut**.
   - Right-click the shortcut → **Properties** → **Shortcut** → **Advanced** → check **Run as administrator** → **OK**.
   - Move the shortcut to `%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup`.

## Contributing

Contributions, issues, and feature requests are welcome. Please open an issue or submit a pull request.

Know anyone else plagued by unexpected shutdowns? Share this script to keep their game running non-stop!

## Licence

MIT © CyberNinja

---

**Changes made:**
- Updated script filenames: `ShopTitans_Steam_Watchdog.bat`, `ShopTitans_Epic_Watchdog.bat`
- Updated usage section to match Steam and Epic split
- Corrected "direct executable" to "Epic Games Launcher" launching
- Clean, fast, no unnecessary filler

