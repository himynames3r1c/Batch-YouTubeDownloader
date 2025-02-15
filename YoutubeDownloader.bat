@echo off
setlocal enabledelayedexpansion

:: Set paths for yt-dlp and ffmpeg
set "YT_DLP_PATH=C:\yt-dlp\yt-dlp.exe"
set "FFMPEG_PATH=C:\ffmpeg\bin\ffmpeg.exe"

:: Check if yt-dlp exists
if not exist "%YT_DLP_PATH%" (
    echo ERROR: yt-dlp.exe not found! Please check your installation.
    pause
    exit /b
)

:: Check if ffmpeg exists
if not exist "%FFMPEG_PATH%" (
    echo ERROR: ffmpeg.exe not found! Please check your installation.
    pause
    exit /b
)

:: Create download folders
set "DOWNLOAD_DIR=%CD%\YouTubeDownloads"
set "MP3_DIR=%CD%\MP3Downloads"

if not exist "%DOWNLOAD_DIR%" mkdir "%DOWNLOAD_DIR%"
if not exist "%MP3_DIR%" mkdir "%MP3_DIR%"

:: Prompt user for YouTube URL
set /p VIDEO_URL="Enter YouTube Video URL: "

:: Define output file format
set "OUTPUT_FILE=%DOWNLOAD_DIR%\%%(title)s.%%(ext)s"
set "MP3_OUTPUT_FILE=%MP3_DIR%\%%(title)s.mp3"

:: Download video (best quality)
echo Downloading video...
"%YT_DLP_PATH%" -f "bestaudio/best" -o "%OUTPUT_FILE%" "%VIDEO_URL%"

if %errorlevel% neq 0 (
    echo Failed to download video.
    pause
    exit /b
)

:: Convert to MP3
echo Converting to MP3...
for %%f in ("%DOWNLOAD_DIR%\*.*") do (
    "%FFMPEG_PATH%" -i "%%f" -vn -ab 192k -ar 44100 -y "%MP3_DIR%\%%~nf.mp3"
)

echo Conversion complete! MP3 saved in %MP3_DIR%
pause
