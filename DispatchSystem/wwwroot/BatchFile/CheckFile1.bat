@echo off
setlocal

:: Set the source file path and the destination file path
set "sourceFilePath=\\10.23.81.51\sap1\WB.txt"  :: For network file
:: set "sourceFilePath=C:\Projects\Test\SourceFile.txt"  :: For local file
set "destinationFilePath=D:\Weighbridgedata\DestinationFile.txt"

:: Check if the source file exists
if exist "%sourceFilePath%" (
    echo Source file found. Reading content...
) else (
    echo Source file not found.
    goto end
)

:: Read the content of the source file and write it to the destination file
type "%sourceFilePath%" > "%destinationFilePath%"

:: Check if the writing was successful
if %errorlevel% equ 0 (
    echo File content successfully written to %destinationFilePath%
) else (
    echo Failed to write content to %destinationFilePath%
)

:end
endlocal
pause
