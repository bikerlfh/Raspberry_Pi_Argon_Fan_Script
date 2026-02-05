# Argon ONE FAN Script

## Table of Contents

- [About](#about)
- [How to install Argon ONE Pi Power Button & Fan Control](#how-to-install-argon-one-pi-power-button--fan-control)
  - [Prerequisites](#prerequisites)
  - [Installing](#installing)
- [Usage Instructions](#usage-instructions)
  - [Argon ONE Pi Power Button Functions](#argon-one-pi-power-button-functions)
  - [Argon ONE Pi Fan Speed](#argon-one-pi-fan-speed)
- [Uninstalling Argon ONE Pi Script](#uninstalling-argon-one-pi-script)
- [LineageOS (Android) Installation](#lineageos-android-installation)
  - [Prerequisites](#prerequisites-1)
  - [Installing on LineageOS](#installing-on-lineageos)
  - [LineageOS Fan Speed Configuration](#lineageos-fan-speed-configuration)
  - [Manual Installation](#manual-installation)
  - [Starting the Fan Control Manually](#starting-the-fan-control-manually)
  - [Uninstalling on LineageOS](#uninstalling-on-lineageos)
- [Built With](#built-with)
- [Acknowledgments](#acknowledgments)
- [Alternatives](#alternatives)

---

## About

This repository serves as an unofficial archive of the [Argon 40](https://www.argon40.com) fan control and power button scripts for [Argon ONE Raspberry Pi cases](https://www.argon40.com/collections/raspberry-pi-cases). The purpose is to preserve a copy of these scripts in case they become unavailable from the official source.

Additionally, this project includes a custom fan control script for **LineageOS (Android)**, tested on the LineageOS TV version for Raspberry Pi.

> **Disclaimer:** This project is not affiliated with, endorsed by, or associated with [Argon 40](https://www.argon40.com) in any way. It is maintained independently as an end-user resource.

### Official Argon 40 Resources

| Resource | Link |
|----------|------|
| Website | [argon40.com](https://www.argon40.com) |
| GitHub | [github.com/Argon40Tech](https://github.com/Argon40Tech) |
| Official Script | [download.argon40.com/argon1.sh](https://download.argon40.com/argon1.sh) |

## How to install Argon ONE Pi Power Button & Fan Control

### Prerequisites

* [Raspberry Pi](https://www.raspberrypi.org/products/ "Raspberry Pi")
* [Raspberry Pi OS (previously called Raspbian)](https://www.raspberrypi.org/downloads/ "Raspberry Pi OS") installed on microSD card
* [Argon ONE Cases for Raspberry Pi](https://www.argon40.com/collections/raspberry-pi-cases "Argon ONE Cases for Raspberry Pi")

### Installing

1. Connect to the internet.
2. Open "Terminal" in Raspbian.
3. Type the text below in the "Terminal" to initiate installation of Argon ONE Pi script.

   ```
   curl https://download.argon40.com/argon1.sh | bash
   ```

4. Reboot.

## Usage Instructions

### Argon ONE Pi Power Button Functions

ARGON ONE PI STATE | ACTION | FUNCTION
:------------------: | :----: | :------:
OFF | Short Press | Turn ON
ON | Long Press (>= 3 s) | Soft Shutdown and Power Cut
ON | Short Press (< 3 s) | Nothing
ON | Double Tap | Reboot
ON | Long Press (>= 5 s) | Forced Shutdown

### Argon ONE Pi Fan Speed
Upon installation of the Argon ONE Pi script by default, the settings of the Argon ONE Pi  cooling system are as follows:

CPU TEMP | FAN POWER
:------: | :-------:
55 C | 30%
60 C | 55%
65 C | 100%

However, you may change or configure the FAN to your desired settings by clicking the Argon ONE Pi  Config icon on your Desktop.

Or via "Terminal" by typing and following the specified format:

```
argonone-config
```

## Uninstalling Argon ONE Pi Script

To uninstall the Argon ONE Pi script you may do so by clicking the Argon One Pi Uninstall icon on your Desktop.

You may also remove the script via "Terminal" by typing.
```
argonone-uninstall
```

Always reboot after changing any configuration or uninstallation for the revised settings to take effect.

---

## LineageOS (Android) Installation

If you are running LineageOS (Android) on your Raspberry Pi with an Argon ONE case, you can enable fan control using a separate script.

### Prerequisites

* Raspberry Pi with LineageOS installed
* Argon ONE Case
* Root access (su)
* i2c-tools available on the system

### Installing on LineageOS

1. Connect to your device using one of the following methods:

   **Option A: Via SSH**

   1. On your LineageOS device, go to **Settings > Raspberry Pi settings > SSH** and enable it
   2. Note the IP address of your device (found in **Settings > Network & internet**)
   3. From your computer, connect via SSH:
      ```
      ssh <user>@<device-ip>
      ```

   **Option B: Via ADB**

   Connect a USB cable to your device and run:
   ```
   adb shell
   ```

   **Option C: Terminal emulator app**

   Open a terminal emulator app directly on the device.

2. Get root access:
   ```
   su
   ```
3. Download and run the interactive installation script:
   ```
   curl -O https://raw.githubusercontent.com/bikerlfh/Argon40-ArgonOne-Fan-Script/main/lineageos/install-lineageos.sh
   sh install-lineageos.sh
   ```

4. Follow the prompts to configure your fan settings:
   - **Temperature thresholds**: Set the temperatures (in Celsius) at which fan speed changes
   - **Fan speeds**: Set the fan speed percentage (0-100%) for each temperature range
   - **Check interval**: How often (in seconds) the script checks the CPU temperature

5. Review the configuration summary and confirm installation

6. Reboot your device

### LineageOS Fan Speed Configuration

During installation, you can customize the fan curve. The default settings are:

CPU TEMP | FAN POWER
:------: | :-------:
< 55°C | 0% (Off)
55-60°C | 25% (Low)
60-65°C | 50% (Medium)
> 65°C | 100% (Full)

The check interval defaults to 120 seconds.

### Manual Installation

If you prefer to install manually without the interactive script, you can append [`lineageos/argon-lineageos.sh`](lineageos/argon-lineageos.sh) to `/vendor/etc/init.d/03ssh`:

```
su
mount -o remount,rw /vendor
mkdir -p /vendor/etc/init.d
curl -O https://raw.githubusercontent.com/bikerlfh/Argon40-ArgonOne-Fan-Script/main/lineageos/argon-lineageos.sh
cat argon-lineageos.sh >> /vendor/etc/init.d/03ssh
chmod 755 /vendor/etc/init.d/03ssh
mount -o remount,ro /vendor
reboot
```

### Starting the Fan Control Manually

After installation, the fan control starts automatically on boot. To start it manually without rebooting:

```
su
sh /vendor/etc/init.d/03ssh &
```
