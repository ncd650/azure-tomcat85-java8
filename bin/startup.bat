@echo off

setlocal

rem Guess OUR_JAVA_HOME if not defined
set "CURRENT_DIR=%cd%"
if not "%OUR_JAVA_HOME%" == "" goto gotJavaHome
set "OUR_JAVA_HOME=%CURRENT_DIR%\zulu8.25.0.1-jdk8.0.152-win_x64"
if exist "%OUR_JAVA_HOME%\bin\java.exe" goto okJavaHome
cd ..
set "OUR_JAVA_HOME=%cd%"
cd "%CURRENT_DIR%"
:gotJavaHome
if exist "%OUR_JAVA_HOME%\bin\java.exe" goto okJavaHome
echo The OUR_JAVA_HOME environment variable is not defined correctly
echo This environment variable is needed to run this program
goto end
:okJavaHome
rem Set our own JAVA_HOME for our Tomcat
set "JAVA_HOME=%OUR_JAVA_HOME%"

rem Guess CATALINA_HOME if not defined
set "CURRENT_DIR=%cd%"
if not "%CATALINA_HOME%" == "" goto gotCatalinaHome
set "CATALINA_HOME=%CURRENT_DIR%\apache-tomcat-8.5.23"
if exist "%CATALINA_HOME%\bin\catalina.bat" goto okCatalinaHome
cd ..
set "CATALINA_HOME=%cd%"
cd "%CURRENT_DIR%"
:gotCatalinaHome
if exist "%CATALINA_HOME%\bin\catalina.bat" goto okCatalinaHome
echo The CATALINA_HOME environment variable is not defined correctly
echo This environment variable is needed to run this program
goto end
:okCatalinaHome

set "EXECUTABLE=%CATALINA_HOME%\bin\startup.bat"

rem Check that target executable exists
if exist "%EXECUTABLE%" goto okExec
echo Cannot find "%EXECUTABLE%"
echo This file is needed to run this program
goto end
:okExec

rem Get remaining unshifted command line arguments and save them in the
set CMD_LINE_ARGS=
:setArgs
if ""%1""=="""" goto doneSetArgs
set CMD_LINE_ARGS=%CMD_LINE_ARGS% %1
shift
goto setArgs
:doneSetArgs

call "%EXECUTABLE%" start %CMD_LINE_ARGS%

:end
