---
title: How to Combine MP4 Files on Windows Using FFmpeg
date: "2025-07-24T00:00:00.0000000"
description: Learn how to merge multiple MP4 video files into one seamless file on Windows using FFmpeg with lossless quality.
featuredImage: /img/combine-mp4-files-ffmpeg-windows.png
---

Merging multiple MP4 files into one can be useful when working with ripped DVDs, split movie parts, or recorded gameplay. On Windows, the simplest and most flexible tool for this task is **FFmpeg** — a powerful open-source utility that can join, convert, and manipulate video files.

This guide walks you through installing FFmpeg, preparing your files, and performing a **lossless merge** (no quality loss).


## 1. Install FFmpeg with Winget

Windows 10/11 includes the `winget` package manager, which makes installing FFmpeg simple:

```powershell
winget install Gyan.FFmpeg
```

After installation, close and reopen your PowerShell or Command Prompt so the new PATH settings take effect. Verify with:

```powershell
ffmpeg -version
```

You should see version details confirming it's ready to use.

## 2. Prepare the Files

### Rename to Remove Spaces

FFmpeg's concat method works best with simple filenames. Rename your MP4s to remove spaces and special characters:

```powershell
Rename-Item "Long File Part 1.mp4" "Long_File_Part_1.mp4"
Rename-Item"Long File Part 2.mp4" "Long_File_Part_2.mp4"
```

(Alternatively, you can quote filenames with spaces, but renaming is easier.)

## 3. Create a File List

Create a text file named `file_list.txt` in the same folder as your videos. Its contents should be:

```text
file 'Long_File_Part_1.mp4'
file 'Long_File_Part_1.mp4'
```

This tells FFmpeg which files to concatenate and in what order.

## 4. Combine the Files

Run the following command:

```powershell
ffmpeg -f concat -safe 0 -i file_list.txt -c copy Long_File_Combined.mp4
```

This creates `Long_File_Combined.mp4` by stitching the two parts together **without re-encoding** (no quality loss).

> **Note:** This process still copies all frames into a new file, so large videos will take a few minutes to write to disk.

## 5. Verify the Result

Play the new combined file in your preferred media player. If playback is seamless, you can delete the original split parts if desired.

You can also delete `file_list.txt` now if you want.

## Troubleshooting

- **Mismatched Codecs or Bitrates:** If FFmpeg errors about incompatible streams, you'll need to re-encode:

 ```powershell
 ffmpeg -i Long_File_Part_1.mp4 -i Long_File_Part_2.mp4 -filter_complex"[0:v][0:a][1:v][1:a] concat=n=2:v=1:a=1 [outv][outa]" -map"[outv]" -map"[outa]" Long_File_Combined.mp4
 ```

- **Subtitles or Extra Streams:** Stripping unnecessary streams (e.g., subtitles) can simplify merging:

 ```powershell
 ffmpeg -i input.mp4 -map 0:v -map 0:a -c copy stripped.mp4
 ```

## Why FFmpeg?

- **Free & Open Source**
- **Easily installed via winget (or other tools)**
- **Lossless Merge** when files are encoded identically
- **Supports Almost Any Format** (MP4, MKV, MOV, etc.)
- **Cross-Platform** (Windows, macOS, Linux)

## Summary

Combining MP4 files on Windows is straightforward with FFmpeg:

1. Install FFmpeg via Winget.
2. Rename files to remove spaces.
3. Create `file_list.txt` with the file order.
4. Run the concat command with `-c copy`.
5. Verify and enjoy your merged video.

This process is fast, avoids quality loss, and works reliably for most video sources.

