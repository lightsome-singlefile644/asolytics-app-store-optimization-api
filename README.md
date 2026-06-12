# Asolytics API — App Store Optimization (ASO) Agent Skill

An agent skill for the **[Asolytics](https://asolytics.pro/) Public API** — the App Store Optimization (ASO) API for App Store and Google Play keyword research, app rankings, keyword metrics, competitor analysis, installs & revenue estimates, and store charts.

This skill teaches an AI coding agent (Claude Code, OpenAI Codex, or any agent that loads `skills/` folders) how to use the Asolytics ASO API correctly — authentication, available endpoints, token-cost awareness, and ready-to-run examples — so you can just ask in plain language: *"pull the latest popularity for these keywords"* and the agent does it.

🔗 **Asolytics:** https://asolytics.pro/ · **API docs:** https://app.asolytics.pro/api/public-api/documentation

> **Keywords:** Asolytics API · App Store Optimization API · ASO API · ASO keyword research · app rankings · App Store & Google Play analytics · AI agent skill.

## What you can get from the API

ASO research and reporting data for any app on the App Store and Google Play:

| Area | What you get |
| --- | --- |
| **Keyword research** | Latest keyword metrics (popularity, results, etc.), popularity history over time, and ranking history for your keywords. |
| **Live search** | The real top-50 search results for any keyword, country, and store — right now. |
| **Recommended keywords** | Keyword ideas Asolytics suggests for an app, with accept/decline workflow. |
| **App intelligence** | Current store listing text (title, subtitle, description), screenshots & media, version history, and which countries an app is live in. |
| **Estimates** | Monthly **estimated installs** and **revenue** history per app, per country. |
| **Rankings & charts** | An app's category/keyword ranking history, plus full **top-500 store charts** by country, category, and device. |
| **Competitors** | List competitors for an app, and mark / unmark competitors. |
| **Keyword tracking** | List, add, and remove tracked keywords; organize them into folders. |
| **Account** | Your projects and your remaining API **token balance** (the API is metered). |

Full endpoint-by-endpoint reference: [`skills/asolytics-api/references/endpoints.md`](skills/asolytics-api/references/endpoints.md).

## Before you start

You need a free Asolytics account and your personal API token:

1. **Register a free account** (or log in): **https://app.asolytics.pro/login**
2. **Open your profile and copy the API token:** **https://app.asolytics.pro/profile**
3. **Keep the token secret** — don't paste it into chats or commit it to git. The skill will ask you for it when needed (or you can set it once as the `ASOLYTICS_PUBLIC_API_TOKEN` environment variable).

You'll also need **an AI agent that supports skills** — e.g. [Claude Code](https://claude.com/claude-code) or [OpenAI Codex](https://developers.openai.com/codex/). A "skill" is just a folder the agent reads to learn how to do something.

## Install

A skill is a folder named `asolytics-api/` that lives inside your agent's `skills/` directory. Installing = putting that folder in the right place.

### Option A — Just ask your agent (easiest)

If you use Claude Code, Codex, or a similar agent, paste this prompt to it and let it do the work:

> **Install the Asolytics ASO skill for me.** Clone `https://github.com/Asolytics-Pro/asolytics-app-store-optimization-api` and copy its `skills/asolytics-api` folder into my agent's skills directory (`~/.claude/skills/` for Claude Code, `~/.codex/skills/` for Codex). Create the directory if it doesn't exist, then confirm it's installed.

The agent will run the right commands for your setup. No terminal knowledge required.

### Option B — Copy it yourself (terminal)

First get the files: click the green **Code → Download ZIP** on GitHub and unzip it, **or** run:

```bash
git clone https://github.com/Asolytics-Pro/asolytics-app-store-optimization-api.git
cd asolytics-app-store-optimization-api
```

Then copy the skill folder for your agent:

```bash
# Claude Code / Claude Desktop
mkdir -p ~/.claude/skills && cp -R skills/asolytics-api ~/.claude/skills/

# OpenAI Codex
mkdir -p ~/.codex/skills && cp -R skills/asolytics-api ~/.codex/skills/
```

For any other agent, copy the `skills/asolytics-api/` folder into that agent's skills directory (most agents use the same `skills/<name>/` layout).

### After installing

Restart your agent if it was already running, then ask it something like:
> *"Use the asolytics-api skill to show the top-50 live search results for 'photo editor' in the US App Store."*

The first time, the agent will ask for your API token — paste it (or set it as the `ASOLYTICS_PUBLIC_API_TOKEN` environment variable so you only do it once).

## Updating the skill

The skill is versioned. When a newer version is published here on GitHub, the skill itself will **notice and offer to update** the next time you use it — just say yes. Under the hood it runs `scripts/update.sh`, which backs up your current copy and installs the latest files.

You can also update manually any time:

```bash
bash ~/.claude/skills/asolytics-api/scripts/update.sh   # or ~/.codex/skills/...
```

## Keeping the API reference fresh

The Asolytics API is in alpha and can change. To refresh the bundled API snapshot (endpoint list & schemas) at any time:

```bash
python3 skills/asolytics-api/scripts/sync_openapi.py
```

It re-downloads the latest spec and regenerates `references/openapi.json` and `references/endpoints.md`.

## License

MIT — see [LICENSE](LICENSE).
