@echo off

set PYTHON_HOME=%cd%\python
set PYTHONPATH=%cd%\python
set PYTHON_COMMAND=%cd%\python\python.exe
set NASM_PREFIX=%cd%\nasm\

copy /y CONFIGURATION.c edk2\MdeModulePkg\Application\PowerMonkeyApp
cd edk2
call build -m MdeModulePkg/Application/PowerMonkeyApp/PowerMonkey.inf
copy /y Build\MdeModule\RELEASE_VS2019\X64\PowerMonkey.efi ..\EFI\Boot

cd ..
