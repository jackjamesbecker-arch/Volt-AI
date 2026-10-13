# ⚡ Volt for Mac

A Jarvis-style AI agent in your Mac terminal, powered by [Groq](https://console.groq.com). Free to run.

Mac extras: Touch ID login, iMessage, Calendar and Reminders, Contacts, Apple Music, battery protocols, window / mouse / keyboard control, screenshots, screen reading. Newer in this version: real weather, live sports scores, your own mailbox, webcam vision and face recognition, and automatic rate-limit handling.

## Install

```bash
git clone <this repo> && cd <this repo>
bash setup.sh        # installs packages and links the `volt` command
volt
```

On first launch Volt asks for your name, a login code, your city (for weather), and a free Groq API key (it can save the key for you). Nothing personal is stored in the code. Your profile lives in `~/.volt/` on your Mac, and the login code is stored hashed.

## Everyday use

Just talk to it: "what's the weather?", "who won the Cardinals game last night?", "check my email", "what am I holding?", "text Sam I'm on my way".

| Command | What it does |
|---|---|
| `/user` | List profiles. `/user add <name>`, `/user code`, `/user remove <name>` |
| `/location <city>` | Set where you are (weather) |
| `/email setup` | Give Volt its own mailbox (Gmail, GMX, Yahoo or custom). `/email me you@x.com` |
| `/camera on` | Allow webcam vision. Then ask "what do you see?" |
| `/face enroll <name>` | Teach it a face (only for people who agree). `/face who`, `/face unlock on` |
| `/apex` `/wake` `/sleep` `/charge` | Protocols |
| `/fast` `/smart` | Switch model |
| `/voice` `/speak` | Voice input / spoken replies |

## Privacy

- Camera and screen images go to Groq to be described and are never saved. Both are off or on request only.
- Faces are stored as numbers (not photos) in `~/.volt/faces/` on your Mac.
- Use a separate mailbox for Volt, not your personal one. Email text is treated as untrusted, and Volt blocks risky actions (shell, writing files, opening links) for the rest of that message after it reads mail.
- macOS will ask for Camera, Microphone, Automation and Screen Recording permission for your Terminal app the first time a feature needs it.

## Not on Mac yet

The always-listening hands-free voice, voiceprint, Discord phone bot, and live camera window exist in Volt for Windows only.

## Updating

Download the new `agent.py` to Downloads, then run `bash update.sh` (it copies the newest `agent*.py` into place).

MIT licensed.
