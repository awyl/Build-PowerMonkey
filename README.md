# Build PowerMonkey

***
**All credit goes to respective developers of the software used.**
***
## <u>DISCLAIMER</u>  
I merely provide you a script to build PowerMoney EFI because it is not the easiest task.  Using these EFI binaries are potentially dangerous and could damage your computer.  I am not responsible for any damages that might cause.  Use at your own risk.

***

A [blog post](https://mreggtart.com/posts/undervolting-windows-11-powermonkey) is written for this repository.

These scripts are created to ease the so many steps to build [PowerMonkey](https://github.com/psyq321/PowerMonkey).  If you do not understand what you are doing, you probably shouldn't be running this.  Read about EFI and boot process.  PowerMonkey github has a good explanation.


## Software Used
- https://github.com/tianocore/edk2 stable202108
- https://github.com/psyq321/PowerMonkey 0.14
- Python 3.10.0
- NASM 2.15.05

## How to use

### Prerequisite
1. Windows 10 build 17063 and newer
2. Visual Studio 2022, with C++ workload installed.

### Step 1
In a command prompt (Use `x64 Native Tools Command Prompt for VS 2022` to get builds working),
```
git clone https://github.com/awyl/Build-PowerMonkey.git
```

### Step 2
```
cd Build-PowerMonkey
setup.bat
```

### Step 3

Edit `CONFIGURATION.c`.  Set your undervolt value.  
Open the file in a text editor, it should be very self-explanatory.

### Step 4
```
build.bat
```

### Step 5
Copy the content of `EFI` folder to the folder of same name in your EFI partition.  You can also copy the folder to an FAT32 formatted usb stick.

### Step 6

Reboot your computer and go into BIOS.
- Turn off `Secure Boot`
- Change the boot file to `EFI\Boot\shellx64.efi`.

