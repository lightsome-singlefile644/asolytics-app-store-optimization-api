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

1. **An Asolytics account.** Sign up at [asolytics.pro](https://asolytics.pro/).
2. **A Public API token.** Get it from your Asolytics account and find the docs at [the API documentation page](https://app.asolytics.pro/api/public-api/documentation). You'll pass this token to every request — the skill explains how. Keep it secret (don't paste it into chats or commit it to git).
3. **An AI agent that supports skills** — e.g. [Claude Code](https://claude.com/claude-code) or [OpenAI Codex](https://developers.openai.com/codex/). A "skill" is just a folder the agent reads to learn how to do something.

## Install

A skill is a folder named `asolytics-api/` that lives inside your agent's `skills/` directory. Installing = copying that folder into the right place. Pick your agent below and paste the command into your terminal.

> First, download this repo (click the green **Code → Download ZIP** button on GitHub and unzip it, or run `git clone https://github.com/Asolytics-Pro/asolytics-app-store-optimization-api.git`), then `cd` into the folder before running a command below.

### Claude Code / Claude Desktop

```bash
mkdir -p ~/.claude/skills
cp -R skills/asolytics-api ~/.claude/skills/
```

### OpenAI Codex

```bash
mkdir -p ~/.codex/skills
cp -R skills/asolytics-api ~/.codex/skills/
```

### Any other agent

Copy the `skills/asolytics-api/` folder into that agent's skills directory (most agents use the same `skills/<name>/` layout).

**That's it.** Restart your agent if it was already running, then ask it something like:
> *"Use the asolytics-api skill to show the top-50 live search results for 'photo editor' in the US App Store."*

The first time, the agent will ask for your API token — paste it (or set it as the `ASOLYTICS_PUBLIC_API_TOKEN` environment variable so you only do it once).

## Keeping the reference up to date

The Asolytics API is in alpha and can change. To refresh the bundled API snapshot at any time:

```bash
python3 skills/asolytics-api/scripts/sync_openapi.py
```

It re-downloads the latest spec and regenerates `references/openapi.json` and `references/endpoints.md`.

## License

MIT — see [LICENSE](LICENSE).
