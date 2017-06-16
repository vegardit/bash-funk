@echo off
::
:: Copyright (c) 2015-2017 Vegard IT GmbH, http://vegardit.com
::
:: Licensed under the Apache License, Version 2.0 (the "License");
:: you may not use this file except in compliance with the License.
:: You may obtain a copy of the License at
::
::      http://www.apache.org/licenses/LICENSE-2.0
::
:: Unless required by applicable law or agreed to in writing, software
:: distributed under the License is distributed on an "AS IS" BASIS,
:: WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
:: See the License for the specific language governing permissions and
:: limitations under the License.
::
:: @author Sebastian Thomschke, Vegard IT GmbH

:: This self-contained Windows batch file creates a portable bash-funk (https://github.com/vegardit/bash-funk/)
:: installation based on Cygwin (https://cygwin.com/mirrors.html). It also automatically installs the
:: command-line package manager apt-cyg (https://github.com/transcode-open/apt-cyg).
::
:: You can customize the following variables to your needs before running the batch file:

:: change the URL to the closest mirror https://cygwin.com/mirrors.html
set CYGWIN_MIRROR=http://ftp.inf.tu-dresden.de/software/windows/cygwin32

:: select the packages to be installed automatically via apt-cyg
set CYGWIN_PACKAGES=bash-completion,bc,curl,expect,git,git-svn,gnupg,inetutils,mc,nc,openssh,openssl,perl,python,subversion,unzip,vim,zip

:: choose a user name under Cygwin
set CYGWIN_USERNAME=root

:: set proxy if required (unfortunately Cygwin setup.exe does not have commandline options to specify proxy user credentials)
set PROXY_HOST=surf.proxy.agis.allianz
set PROXY_PORT=8080

echo.
echo ###########################################################
echo # Installing [bash-funk portable]...
echo ###########################################################
echo.

:: create VB script that can download files
set DOWNLOADER=%~dp0downloader.vbs
echo Creating [%DOWNLOADER%] script...
if "%PROXY_HOST%" == "" (
    set DOWNLOADER_PROXY=.
) else (
    set DOWNLOADER_PROXY= req.SetProxy 2, "%PROXY_HOST%:%PROXY_PORT%", ""
)

(
    echo url = Wscript.Arguments(0^)
    echo target = Wscript.Arguments(1^)
    echo WScript.Echo "Downloading '" ^& url ^& "' to '" ^& target ^& "'..."
    echo Set req = CreateObject("WinHttp.WinHttpRequest.5.1"^)
    echo%DOWNLOADER_PROXY%
    echo req.Open "GET", url, False
    echo req.Send
    echo If req.Status ^<^> 200 Then
    echo    WScript.Echo "FAILED to download: HTTP Status " ^& req.Status
    echo    WScript.Quit 1
    echo End If
    echo Set buff = CreateObject("ADODB.Stream"^)
    echo buff.Open
    echo buff.Type = 1
    echo buff.Write req.ResponseBody
    echo buff.Position = 0
    echo buff.SaveToFile target
    echo buff.Close
    echo.
) >"%DOWNLOADER%" || goto :fail

set CYGWIN_ROOT=%~dp0cygwin

if not exist "%CYGWIN_ROOT%" (
    md "%CYGWIN_ROOT%"
)

:: download Cygwin 32 or 64 setup exe

if "%PROCESSOR_ARCHITEW6432%" == "AMD64" (
    set CYGWIN_SETUP=setup-x86_64.exe 
) else (
    if "%PROCESSOR_ARCHITECTURE%" == "x86" ( 
        set CYGWIN_SETUP=setup-x86.exe ) 
    else ( 
        set CYGWIN_SETUP=setup-x86_64.exe 
    )
)

if exist "%CYGWIN_ROOT%\%CYGWIN_SETUP%" (
    del "%CYGWIN_ROOT%\%CYGWIN_SETUP%" || goto :fail
)
cscript //Nologo %DOWNLOADER% http://cygwin.org/%CYGWIN_SETUP% "%CYGWIN_ROOT%\%CYGWIN_SETUP%" || goto :fail
del "%DOWNLOADER%"

:: Cygwin command line options: https://cygwin.com/faq/faq.html#faq.setup.cli
if "%PROXY_HOST%" == "" (
    set CYGWIN_PROXY=
) else (
    set CYGWIN_PROXY=--proxy "%PROXY_HOST%:%PROXY_PORT%"
)

echo Running Cygwin setup...
"%CYGWIN_ROOT%\%CYGWIN_SETUP%" --no-admin ^
 --arch x86_64 ^
 --site http://ftp.inf.tu-dresden.de/software/windows/cygwin32 %CYGWIN_PROXY% ^
 --root "%CYGWIN_ROOT%" ^
 --local-package-dir "%CYGWIN_ROOT%-pkg-cache" ^
 --no-shortcuts ^
 --no-desktop ^
 --delete-orphans ^
 --upgrade-also ^
 --no-replaceonreboot ^
 --quiet-mode ^
 --packages dos2unix,wget,%CYGWIN_PACKAGES% || goto :fail

:configure

set Cygwin_bat=%CYGWIN_ROOT%\Cygwin.bat
if exist "%Cygwin_bat%" (
    echo Disabling [%Cygwin_bat%]...
    if exist "%Cygwin_bat%.disabled" (
        del "%Cygwin_bat%.disabled" || goto :fail
    )
    rename %Cygwin_bat% Cygwin.bat.disabled || goto :fail
)

set Init_sh=%CYGWIN_ROOT%\bash-funk-portable-init.sh
echo Creating [%Init_sh%]...
(
    echo #!/usr/bin/env bash
    echo.
    echo #
    echo # Map Current Windows User to root user
    echo #
    echo.
    echo # Check if current Windows user is in /etc/passwd
    echo USER_SID="$(mkpasswd -c | cut -d':' -f 5)"
    echo if ! grep -F "$USER_SID" /etc/passwd ^&^>/dev/null; then
    echo     echo "Mapping Windows user '$USER_SID' to cygwin '$USERNAME' in /etc/passwd..."
    echo     GID="$(mkpasswd -c | cut -d':' -f 4)"
    echo     echo $USERNAME:unused:1001:$GID:$USER_SID:$HOME:/bin/bash ^>^> /etc/passwd
    echo fi
    echo.
    echo #
    echo # Installing apt-cyg package manager if required
    echo #
    echo if ! [[ -x /usr/local/bin/apt-cyg ]]; then
    if not "%PROXY_HOST%" == "" (
        echo     # temporary proxy settings during initial installation
        echo     export http_proxy=http://%%PROXY_HOST%%:%%PROXY_PORT%%
        echo     export https_proxy=http://%%PROXY_HOST%%:%%PROXY_PORT%%
    )
    echo     echo "Installing apt-cyg..."
    echo     wget -O /usr/local/bin/apt-cyg https://raw.githubusercontent.com/transcode-open/apt-cyg/master/apt-cyg
    echo     chmod +x /usr/local/bin/apt-cyg
    echo fi
    echo.
    echo #
    echo # disable cygwin's special ACL treatment which prevents apt-cyg from working
    echo #
    echo sed -i -e "s/cygdrive binary,posix/cygdrive binary,noacl,posix/" /etc/fstab
    echo mount -a
    echo.
    echo #
    echo # Installing bash-funk if required
    echo #
    echo if [[ ! -e /opt/bash-funk/bash-funk.sh ]]; then
    if not "%PROXY_HOST%" == "" (
        echo   # temporary proxy settings during initial installation
        echo   export http_proxy=http://%%PROXY_HOST%%:%%PROXY_PORT%%
        echo   export https_proxy=http://%%PROXY_HOST%%:%%PROXY_PORT%%
    )
    echo   echo Installing [bash-funk]...
    echo   if hash git ^&^>/dev/null; then
    echo     git clone https://github.com/vegardit/bash-funk --branch master --single-branch /opt/bash-funk
    echo   elif hash svn ^&^>/dev/null; then
    echo     svn checkout https://github.com/vegardit/bash-funk/trunk /opt/bash-funk
    echo   else
    echo     mkdir /opt/bash-funk ^&^& \
    echo     cd /opt/bash-funk ^&^& \
    echo     wget -qO- --show-progress https://github.com/vegardit/bash-funk/tarball/master ^| tar -xzv --strip-components 1
    echo   fi
    echo fi
) >"%Init_sh%" || goto :fail
"%CYGWIN_ROOT%\bin\dos2unix" "%Init_sh%" || goto :fail

set Start_cmd=%~dp0bash-funk.cmd
echo Creating [%Start_cmd%]...
(
    echo @echo off
    echo set CWD="%%cd%%"
    echo set CYGWIN_DRIVE=%%~d0
    echo set CYGWIN_ROOT=%%~dp0cygwin
    echo.
    echo set PATH=%%PATH%%;%%CYGWIN_ROOT%%\bin
    echo set ALLUSERSPROFILE=%%CYGWIN_ROOT%%.ProgramData
    echo set ProgramData=%%ALLUSERSPROFILE%%
    echo set CYGWIN=nodosfilewarning
    echo.
    echo set USERNAME=%CYGWIN_USERNAME%
    echo set HOME=/home/%%USERNAME%%
    echo set SHELL=/bin/bash
    echo set HOMEDRIVE=%%CYGWIN_DRIVE%%
    echo set HOMEPATH=%%CYGWIN_ROOT%%\home\%%USERNAME%%
    echo set GROUP=None
    echo set GRP=
    echo.
    echo %%CYGWIN_DRIVE%%
    echo chdir "%%CYGWIN_ROOT%%\bin"
    echo bash "%%CYGWIN_ROOT%%\bash-funk-portable-init.sh"
    echo.
    echo if "%%1" == "" (
    echo   mintty --option TERM=xterm-256color --size 160,50 --icon %CYGWIN_ROOT%\Cygwin-Terminal.ico -
    echo ^) else (
    echo   if "%%1" == "no-mintty" (
    echo     bash --login -i
    echo   ^) else (
    echo     bash --login -c %%*
    echo   ^)
    echo ^)
    echo.
    echo cd "%%cwd%%"
) >"%Start_cmd%" || goto :fail

:: launching bash once to initialize user home dir
call %Start_cmd% whoami

set BashFunkLoader_sh=%CYGWIN_ROOT%\home\%CYGWIN_USERNAME%\.bashfunk_loader
echo Creating [%BashFunkLoader_sh%]...
(
    echo #!/usr/bin/env bash
    echo if [[ ! -e /opt/bash-funk/bash-funk.sh ]]; then
    echo   echo Installing [bash-funk]...
    echo   if hash git ^&^>/dev/null; then
    echo     git clone https://github.com/vegardit/bash-funk --branch master --single-branch /opt/bash-funk
    echo   elif hash svn ^&^>/dev/null; then
    echo     svn checkout https://github.com/vegardit/bash-funk/trunk /opt/bash-funk
    echo   else
    echo     mkdir /opt/bash-funk ^&^& \
    echo     cd /opt/bash-funk ^&^& \
    echo     wget -qO- --show-progress https://github.com/vegardit/bash-funk/tarball/master ^| tar -xzv --strip-components 1
    echo   fi
    echo fi
    echo source /opt/bash-funk/bash-funk.sh
) >"%BashFunkLoader_sh%" || goto :fail
"%CYGWIN_ROOT%\bin\dos2unix" "%BashFunkLoader_sh%" || goto :fail

set Bashrc_sh=%CYGWIN_ROOT%\home\%CYGWIN_USERNAME%\.bashrc
echo Adding bash-funk to [/home/%CYGWIN_USERNAME%/.bashrc]...
find "bashfunk_loader" "%Bashrc_sh%" >NUL || (
    (
        echo.
        echo source ~/.bashfunk_loader
    ) >>"%Bashrc_sh%" || goto :fail
    "%CYGWIN_ROOT%\bin\dos2unix" "%Bashrc_sh%" || goto :fail
)
echo.
echo ###########################################################
echo # Installing [bash-funk portable] succeeded.
echo ###########################################################
echo.
echo Use [%Start_cmd%] to launch bash-funk portable.
echo.
pause
goto :eof

:fail
    if exist "%DOWNLOADER%" (
        del "%DOWNLOADER%"
    )
    echo.
    echo ###########################################################
    echo #Installing [bash-funk portable] FAILED!
    echo ###########################################################
    echo.
    pause
    exit /b 1
