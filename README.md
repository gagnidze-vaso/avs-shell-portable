# Portable AviSynth Shell

**AvsShell** is a context menu shell for Windows that brings AviSynth directly to your Explorer.

## Why this exists

AviSynth scripts are usually plugged into **PotPlayer** so that video gets frame-interpolated on the fly during playback. That's great — until you want to *send* the interpolated video to someone who doesn't have PotPlayer (or any other player with a built-in interpolation script). This shell does the opposite of that workflow: instead of interpolating during playback, it **produces a separate interpolated copy of the file**, so you can share it with anyone — for example, people who watch videos on their phone.

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
