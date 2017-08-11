@ECHO OFF
:: This batch file is an example of how to call MATLAB from the command line.
:: Developed to run Matlab scripts in a Jenkins environment.
:: It executes the .m file with the same name as the .bat file.

:: Set variable to let MATLAB know this is 
:: run as a batch file and exit when finished.
set BATCH=1

:: Allow the MATLAB version to be determined from env variables
if "%MATLAB_VER%"=="" (
    set MATLAB_VER=R2016b
)

:: If a top level script is not passed in as the first argument use
:: this script's path to determine script directory & run command.
IF "%~1" == "" (
    goto :set0
) ELSE (
    goto :set1
)

:set0
:: Set the SCRIPT_DIR & RUN_CMD based on this script.
set SCRIPT_DIR=%~dp0
set RUN_CMD=%~n0
goto :workspace

:set1
:: Set the SCRIPT_DIR & RUN_CMD based on first argument.
set SCRIPT_DIR=%~dp1
set RUN_CMD=%~n1
goto :workspace

:: If WORKSPACE is not defined (not run through Jenkins)
:: Set it to the script's directory.
:workspace
if "%WORKSPACE%"=="" (
    set WORKSPACE=%SCRIPT_DIR%
)

:: Set the logfile.
set LOG_FILE=%WORKSPACE%\%RUN_CMD%.log

:: Run Matlab.
ECHO ############## Starting Matlab: %RUN_CMD% ##############
set CMD="C:\Program Files\MATLAB\%MATLAB_VER%\bin\matlab.exe" -nosplash -minimize -wait -logfile "%LOG_FILE%" -r "cd('%SCRIPT_DIR%');try;run('%RUN_CMD%');catch Error;disp(getReport(Error));exit(1);end;exit(0);"
echo %CMD%
%CMD%

if %ERRORLEVEL%==0 (
    ECHO.############## Matlab Finished: %RUN_CMD% ##############
) else (
    ECHO.############## Matlab Failed: %RUN_CMD% ##############
)
exit /B %ERRORLEVEL%
