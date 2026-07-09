# CMJ Heavy-Duty Masterclass

The complete semi truck maintenance reference for CMJ fleet operations.

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/github?repo=adamdispatching-stack/fleet)

- 21 chapters covering every major system on a Class 8 tractor
- Plain English explanations + full technical depth
- 14 interactive troubleshooting trees
- 73 J1939 fault codes with field-truth causes
- 92-question knowledge quiz with mechanic ranks
- 17 vector diagrams, PM schedules, glossary

**Single self-contained HTML file** — no build step, no database, no external dependencies.

## Run locally

Open `index.html` in any browser, or:

```
npm start
```

## Deploy to Railway

1. Click the **Deploy on Railway** button above (or go to [railway.com/new](https://railway.com/new) → **Deploy from GitHub repo** → pick `fleet`).
2. Railway auto-detects Node and runs `npm start` — no configuration needed.
3. In the service: **Settings → Networking → Generate Domain** to get your public URL.

## Deploy to GitHub Pages (free alternative)

Repo **Settings → Pages → Deploy from branch → main / root**. The app is served at
`https://adamdispatching-stack.github.io/fleet/` — works because `index.html` is fully self-contained.
