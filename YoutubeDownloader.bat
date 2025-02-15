@echo off
setlocal enabledelayedexpansion

:: Check if yt-dlp is installed
where yt-dlp >nul 2>nul
if %errorlevel% neq 0 (
    echo yt-dlp is not installed or not in PATH.
    echo Download it from https://github.com/yt-dlp/yt-dlp
    pause
    exit /b
)

:: Create a folder for downloads
set "DOWNLOAD_DIR=%CD%\YouTubeDownloads"
if not exist "%DOWNLOAD_DIR%" mkdir "%DOWNLOAD_DIR%"

:: Prompt user for YouTube URL
set /p VIDEO_URL="Enter YouTube Video URL: "

:: Define output file format
set "OUTPUT_FILE=%DOWNLOAD_DIR%\%%(title)s.%%(ext)s"

:: Download video
echo Downloading video...
C:\YT-Dlp\yt-dlp.exe -f "bestvideo+bestaudio/best" -o "%OUTPUT_FILE%" "%VIDEO_URL%"

if %errorlevel% neq 0 (
    echo Failed to download video.
    pause
    exit /b
)

echo Download complete! Saved to %DOWNLOAD_DIR%
pause
