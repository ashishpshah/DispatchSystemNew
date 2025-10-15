@echo off
setlocal enabledelayedexpansion

:: Get the directory where the batch file is located
set "current_dir=%~dp0"

:: Define the directory where log files will be stored
set "log_dir=%current_dir%Logs"

:: Create the Logs directory if it doesn't exist
if not exist "%log_dir%" (
    mkdir "%log_dir%"
)

:: Get the current date in YYYYMMDD format
for /f "tokens=2 delims==" %%a in ('wmic os get localdatetime /value') do set "dt=%%a"
set "current_date=!dt:~0,4!!dt:~4,2!!dt:~6,2!"

:: Define the output log file with current date
set "log_file=%log_dir%\Logs_%current_date%.txt"

:: Check if the log file exists, if not, create it
if not exist "%log_file%" (
    echo Log file does not exist. Creating %log_file%...
    type nul > "%log_file%"
)

:: Define the URL
set "base_url=https://localhost:44356/Home/SyncData_LocalToCloud"

:: Define the list of table names as a string array
set "listTableName=FG_GATE_IN_OUT,FG_WEIGHMENT_DETAIL,MDA_HEADER,MDA_DETAIL,MDA_LOADING,MDA_REQUISITION_DATA,MDA_SEQUENCE,MDA_INVOICE_QR,MDA_ADD_QTY_REQUEST"

:: Loop through the table names and construct the URLs
for %%t in (%listTableName%) do (
    echo Sending GET request for %%t...
    :: Construct the URL with parameters
    set "url=%base_url%?tableName=%%t"

    :: Use curl to send a GET request and save the response to a variable
	for /f "tokens=*" %%i in ('curl -s -w "%%{http_code}" !url!') do (
		set "response=!response!%%i"
	)
	
	set "status_code=!response:~-3!"
	
	set "response_body=!response:~0,-3!"

    :: Get the current timestamp
    for /f "tokens=2 delims==" %%a in ('wmic os get localdatetime /value') do set "dt=%%a"
    set "timestamp=!dt:~0,4!-!dt:~4,2!-!dt:~6,2! !dt:~8,2!:!dt:~10,2!:!dt:~12,2!"

    :: Write log message with all information in one line
    echo !timestamp! !url! !status_code! !response_body! >> "%log_file%"
	echo.
	echo.

    :: Clear response variables for next iteration
    set "response="
    set "http_status="
    set "isSuccess="
    set "message="
)

endlocal
