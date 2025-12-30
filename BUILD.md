# 🛠️ Build Instructions

This project is written in **AutoIt v3**. To convert the source code (`.au3`) into a standalone Windows executable (`.exe`), please follow the steps below.

## 📋 Prerequisites

* **AutoIt v3:** Required to compile the code.
    * [Download from Official Website](https://www.autoitscript.com/site/autoit/downloads/) (AutoIt Full Installation)
* **(Recommended) SciTE4AutoIt3:** An advanced editor and wrapper for AutoIt. It automatically handles the compiler directives (Version, Icon, etc.) found at the top of the script.

## 🚀 Step-by-Step Compilation

### 1. Preparation
Clone or download the project to your local machine. Ensure your file structure looks like this:

```text
MiniClipboardPaster/
├── MiniClipboardPaster.au3  (Source Code)
├── app.ico                  (Application Icon - Required*)
└── ...
```
### 2. Compilation

Once AutoIt is installed, you can compile the script using one of the following methods:

**Method A: Context Menu (Quick)**
1.  Right-click on the `MiniClipboardPaster.au3` file.
2.  Select **Compile Script (x86)** or **Compile Script (x64)**.
    * *Tip: x86 (32-bit) is generally recommended for maximum compatibility.*
3.  The `MiniClipboardPaster.exe` file will be created in the same folder shortly.

**Method B: SciTE Editor (Advanced)**
1.  Open `MiniClipboardPaster.au3` with SciTE.
2.  Go to **Tools > Build** in the menu or press `F7` on your keyboard.
3.  Wait for the "Exit code: 0" message in the bottom console panel.

## 🏃 Running from Source

You can run and test the application without compiling it:
1.  Right-click on `MiniClipboardPaster.au3`.
2.  Select **Run Script**.

---

## 🔧 Troubleshooting

* **"Icon not found" Error:** Ensure that `app.ico` exists in the script directory.
* **"Undefined function" Error:** Make sure your AutoIt version is up to date (v3.3.14+ is recommended).