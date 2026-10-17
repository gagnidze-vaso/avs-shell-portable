@echo off

powershell -Command ^
$utf8NoBOM = New-Object System.Text.UTF8Encoding $False; ^
$content = (Get-Content '%2') -replace 'file_path=.*', 'file_path=\"%1\"'; ^
[System.IO.File]::WriteAllLines('%2',$content,$utf8NoBOM)

ffmpeg -i %2 -c:v libx264 -preset slow -crf 18 -c:a aac -b:a 192k "%~n1.60fps%~x1"
DEL %1.ffindex