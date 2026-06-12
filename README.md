# Asolytics API — App Store Optimization (ASO) Agent Skill

An agent skill for the [Asolytics Public API](https://app.asolytics.pro/api/public-api/documentation) — the App Store Optimization (ASO) API for App Store and Google Play keyword research, app rankings, keyword metrics, competitor analysis, installs & revenue estimates, and store charts.

Built for AI coding agents (Claude Code, OpenAI Codex, and any agent that loads `skills/<name>/` folders), this skill teaches your agent how to query the Asolytics ASO API safely and efficiently — authentication, endpoint families, token-cost guardrails, and ready-to-run `curl` examples.

**Keywords:** Asolytics API · App Store Optimization API · ASO API · ASO keyword research · app rankings · App Store & Google Play analytics · AI agent skill.

The repository ships one reusable, agent-neutral skill:

- `asolytics-api` for ASO research, keyword analysis, store-chart lookups, competitor workflows, tracking maintenance, and lightweight reporting automation.

## Repository Layout

```text
skills/
  asolytics-api/
    SKILL.md
    agents/openai.yaml
    references/
    scripts/
```

## Install

The skill is a self-contained `skills/<name>/` folder. Copy it into whichever agent's skills directory you use.

**Claude Code / Claude Desktop**

```bash
cp -R skills/asolytics-api "${CLAUDE_CONFIG_DIR:-$HOME/.claude}/skills/"
```

**OpenAI Codex**

```bash
cp -R skills/asolytics-api "${CODEX_HOME:-$HOME/.codex}/skills/"
```

**Any other shared skills repository**

Vendor it by copying `skills/asolytics-api/` into that repo's `skills/` folder.

## Refresh the API Reference

The skill includes a helper that pulls the latest public OpenAPI spec and regenerates the bundled references:

```bash
python3 skills/asolytics-api/scripts/sync_openapi.py
```

It writes:

- `skills/asolytics-api/references/openapi.json`
- `skills/asolytics-api/references/endpoints.md`

## License

MIT — see [LICENSE](LICENSE).

## Suggested Next Steps

1. Copy the skill into any other skill catalog that uses a `skills/<skill-name>/` layout.
2. (Optional) Add a `.claude-plugin/marketplace.json` to make it installable via `claude plugin install`.
