set EDK_TOOLS_BIN=%cd%\edk2\BaseTools\Bin\Win32


@echo off
REM Download Edk2

git clone https://github.com/tianocore/edk2.git
cd edk2
git checkout edk2-stable202108
git submodule update --init
cd ..

REM Download PowerMonkey
git clone https://github.com/psyq321/PowerMonkey.git
copy PowerMonkey\PowerMonkeyApp\CONFIGURATION.c .
move PowerMonkey\PowerMonkeyApp edk2\MdeModulePkg\Application
powershell -command "(gc edk2/MdeModulePkg/MdeModulePkg.dsc).replace('/HelloWorld.inf', \"/HelloWorld.inf`r`n  MdeModulePkg/Application/PowerMonkeyApp/PowerMonkey.inf`r`n\") | Set-Content edk2/MdeModulePkg/MdeModulePkg.dsc"
echo ACTIVE_PLATFORM       = MdeModulePkg/MdeModulePkg.dsc > edk2/Conf/target.txt
echo TARGET                = RELEASE >> edk2/Conf/target.txt
echo TARGET_ARCH           = X64 >> edk2/Conf/target.txt
echo TOOL_CHAIN_CONF       = Conf/tools_def.txt >> edk2/Conf/target.txt
echo TOOL_CHAIN_TAG        = VS2019 >> edk2/Conf/target.txt
echo BUILD_RULE_CONF = Conf/build_rule.txt >> edk2/Conf/target.txt


REM Download Python
curl https://www.python.org/ftp/python/3.10.0/python-3.10.0-embed-amd64.zip --output python.zip
mkdir python
tar -xf python.zip -C python
echo Lib/site-packages> python\python310._pth
echo python310.zip>> python\python310._pth
echo .>> python\python310._pth
echo import site>> python\python310._pth
cd python
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
cd ..

REM Download NASM
curl https://www.nasm.us/pub/nasm/releasebuilds/2.15.05/win64/nasm-2.15.05-win64.zip --output nasm.zip
mkdir nasm
tar -xf nasm.zip --strip-components=1 -C %cd%\nasm

REM Download shell.efi
mkdir EFI
cd EFI
mkdir Boot
cd Boot
curl -L https://github.com/tianocore/edk2/raw/UDK2018/ShellBinPkg/UefiShell/X64/Shell.efi --output shellx64.efi
copy ..\..\startup.nsh .
cd ..
cd ..

REM Build EDK2 tools
set PYTHON_HOME=%cd%\python
set PYTHONPATH=%cd%\python
set PYTHON_COMMAND=%cd%\python\python.exe
set PATH=%cd%\python;%PATH%
set NASM_PREFIX=%cd%\nasm\
cd edk2
python -m pip install -r pip-requirements.txt
edksetup.bat Rebuild
cd ..
