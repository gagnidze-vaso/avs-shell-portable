# Portable AviSynth Shell

**AvsShell** is a context menu shell for Windows that brings AviSynth directly to your Explorer.

## Features
- Adds an **"AVS-scripts → 60fps"** context menu entry for `.mp4` and `.mkv` files.
- Runs an AviSynth script (`scripts\60fps.avs`) on the selected video via `ffmpeg`.
- Writes the processed copy next to the original file.

## Installation
1. Extract the archive.
2. Run `install.bat` (it creates symlinks in `C:\Windows` for `ffmpeg.exe` and `AviSynth.dll`).
3. Right-click any MP4/MKV file → **"AVS-scripts" → "60fps"**.

## Which version to download?
- **Lite** (`..._Lite.zip`) — if `ffmpeg.exe` is already available on your system.
- **Full** (`..._Full.zip`) — includes `ffmpeg.exe` inside the archive.

> [!NOTE]
> `AviSynth.dll` is bundled in both versions and is linked into `C:\Windows` during installation.

## Requirements
- `ffmpeg.exe` must be reachable (e.g. `C:\Windows\ffmpeg.exe`).
- `AviSynth.dll` must be reachable (e.g. `C:\Windows\AviSynth.dll`).
- AviSynth plugins `ffms2.dll`, `svpflow1.dll`, `svpflow2.dll` must be present in `plugins\`.
