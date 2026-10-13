# ⚡ Volt setup guide

This guide takes you from nothing to a working Volt on Windows. Set aside about 10 minutes.

**You need:** a Windows 10 or 11 PC, an internet connection, and a free Groq account.

---

## 1. Install Python

1. Download Python 3.10 or newer from [python.org](https://www.python.org/downloads/).
2. Run the installer. **Tick "Add python.exe to PATH"** before you click Install.
3. Open **Windows PowerShell** (search for it in the Start menu) and check:
   ```powershell
   python --version
   ```
   It should print a version number.

> **Tip:** Python 3.12 or 3.13 is the safest choice. Very new Python versions sometimes don't have builds of every package yet.

## 2. Install Volt's packages

In PowerShell:
```powershell
python -m pip install -U groq pyttsx3 psutil pyperclip edge-tts ddgs sounddevice numpy
```
The camera, face and screen features download what they need the first time you turn them on.

## 3. Get a free Groq API key

1. Make a free account at [console.groq.com](https://console.groq.com).
2. Go to **API Keys → Create API Key** and copy the key (it starts with `gsk_`).
3. Save it on your PC. In PowerShell:
   ```powershell
   setx GROQ_API_KEY gsk_your_key_here
   ```
   Type it with **no quotes**. You should see `SUCCESS: Specified value was saved.`
4. **Close PowerShell and open a new window.** The key only loads in new windows.

> 🔒 **Never post your key** in a chat, a screenshot, or a video. If it leaks, delete it at console.groq.com and make a new one.

## 3b. Download Volt

Download `agent_windows.py` from this repository (**Code → Download ZIP**, or the file itself) and put it in your **Downloads** folder.

## 4. Run Volt

```powershell
python "$HOME\Downloads\agent_windows.py"
```
The first time, Volt asks you to create your profile (a name and a code). You use that code to log in next time.

## 5. Make a `volt` shortcut (optional)

So you can type just `volt` from anywhere, in PowerShell:
```powershell
New-Item -Path $PROFILE -ItemType File -Force
Add-Content -Path $PROFILE -Value 'function volt { python "$HOME\Downloads\agent_windows.py" @args }'
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```
Press `Y` if asked, then **open a new PowerShell window** and type `volt`.

---

## Turning on the extra features

Everything below is optional and off by default. Type these inside Volt.

### 🎙 Voice ("Hey Volt")
```
/hey
```
Then say "Hey Volt, what's the weather?". To make Volt answer only to **your** voice, run `/voiceprint` (or `/voiceprint more` for a better match) and read the lines it shows. Turn the check off with `/voiceprint off`.

### 👁 Camera
```
/camera on
```
Then just ask: "what do you see?". For a live window that greets you and checks in while you work, use `/live`.

### 🙂 Face recognition and face unlock
```
/camera on
/face enroll YourName
/face who
/face unlock on
```
- Enroll with **exactly the same name** as your Volt profile if you want face unlock.
- Look at the camera and slowly turn your head when it asks.
- The first time, Volt downloads two small face models (about 39 MB).
- Your code always still works as a backup.
- Only enroll people who agree. Remove someone with `/face forget <name>`.

### 🖥 Screen vision
```
/screen on
```
Then ask about your screen ("what's this error?"). `/screen watch` makes Volt quietly watch for errors and speak up only if it sees one.

### 📱 Phone access through Discord

1. Go to [discord.com/developers/applications](https://discord.com/developers/applications) → **New Application**, name it, then open **Bot → Reset Token** and copy the token. **Keep it secret.**
2. In Volt: `/phone token <your token>` (type it into Volt, not into chat). Volt prints an invite link.
3. Open the link and add the bot to a private Discord server you own (a server with just you in it is fine).
4. In Discord, turn on **Developer Mode** (Settings → Advanced), right-click your name and **Copy User ID**.
5. In Volt: `/phone user <your id>`. The bot sends you a DM.
6. Reply to the DM to talk to Volt, as long as Volt is running on your PC.

Safe mode is on by default (phone messages can't run commands, touch files, send email or use the camera). Turn it off only if you understand the risk: `/phone safe off`. Using Volt on **two PCs?** Make a second bot for the second PC, or turn one off with `/phone off`, otherwise both answer.

### 📧 Volt's own email

Make a **new mailbox just for Volt**. GMX is the easiest (it works with a normal password).

1. Create the account. For GMX, turn on **Settings → POP3 & IMAP → Allow access to this account**.
2. In Volt: `/email setup gmx` (also supports `gmail`, `yahoo` and `other`). Gmail and Yahoo need an **App Password**, not your normal password.
3. Optional: `/email me you@example.com` so "email me" knows where to send.
4. Try: "check my email".

---

## Troubleshooting

**`'python' is not recognized`**: Python isn't on your PATH. Reinstall it and tick "Add python.exe to PATH".

**`GROQ_API_KEY not set`**: You opened the window before saving the key. Run the `setx` command, then close and open a new window. Check the command starts with `setx` (a typo like `hhgsetx` won't work).

**`'volt' is not recognized`**: The shortcut isn't set up. Use step 5, in **PowerShell** (not Command Prompt).

**`can't open file ...agent_windows.py`**: The file isn't where the command looks. Search for it with
```powershell
Get-ChildItem $HOME -Recurse -Filter "agent_windows*.py" -ErrorAction SilentlyContinue | Select FullName
```
and move it into `Downloads`. Browsers sometimes save to another drive (like `D:\`).

**`model ... does not exist`**: You're running an old copy of Volt. Download the latest file.

**Rate limit hit**: You've used your free Groq allowance for now. Volt switches models automatically and waits when it has to. Turn off `/live` and `/screen` to save tokens.

**Camera or face features don't work**: Check OpenCV with
```powershell
python -c "import cv2; print(cv2.__version__)"
```
If it fails, run `python -m pip install opencv-python`. If pip says "No matching distribution", install Python 3.12 or 3.13.

**Volt ignores my voice or hears nothing**: Run `/voicetest`. If the voice check keeps rejecting you, use `/voiceprint more` to record better samples, or `/voiceprint off`.

---

## Updating Volt

Download the new `agent_windows.py` into Downloads and run `volt`. If you used the shortcut from step 5, it picks up the newest file for you.

## Uninstalling

Delete `agent_windows.py` and the folder `C:\Users\<you>\.volt` (your settings, face data and memory). Remove the Groq key from your account at console.groq.com.
