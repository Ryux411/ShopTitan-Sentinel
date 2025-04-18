# ShopTitan Sentinel

A lightweight Windows batch sentinel that automatically detects, monitors and relaunches ShopTitan on Steam or Epic Games if it stops unexpectedly.

---

## Features

- **Auto‑detects** game installation on Steam (including secondary libraries) or Epic Games.
- **Real‑time monitoring** of the `ShopTitan.exe` process.
- **Automatic restart** via Steam or direct executable launch.
- **Uptime tracking** and **restart counter** displayed in console.
- **Customisable** check interval and launch parameters.
- **Production‑ready** with concise logging and clear user prompts.

## Requirements

- Windows 10 or later
- Batch (CMD) environment
- ShopTitan installed via Steam or Epic Games

## Installation

1. Clone or download this repository:
   ```powershell
   git clone https://github.com/Ryux411/ShopTitan-Sentinel.git
   ```
2. Place the `shop-monitor.bat` script in any folder you prefer.

## Configuration

- **Script name:** `shop-monitor.bat`
- **Interval:** Modify `CheckInterval` variable inside the script (default: 1 second).
- **AppID:** For Steam launches, replace the placeholder AppID (`1258080`) with the actual ShopTitan AppID in the script.

## Usage

1. Open a PowerShell or Command Prompt window.
2. Navigate to the directory containing `shop-monitor.bat`.
3. Run:
   ```powershell
   .\shop-monitor.bat
   ```
4. The console will display real‑time status, uptime and restart actions.

## Logging

Each status and action is echoed in the console for easy tracking. No external log files are created by default.

## Customisation

- Change the **check interval** by editing the `CheckInterval` variable.
- To add additional actions (e.g., keystrokes after launch), insert PowerShell `SendKeys` commands in the restart logic section.

## Contributing

Contributions, issues and feature requests are welcome. Please open an issue or submit a pull request.

## Licence

MIT © CyberNinja

