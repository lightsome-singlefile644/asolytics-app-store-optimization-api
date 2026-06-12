---
name: asolytics-api
description: Use the Asolytics Public API for ASO research and automation. Trigger this skill when the agent needs to query app metadata, availability, versions, installs, revenue, rankings, keyword metrics, live search results, recommended keywords, tracked keywords, tracking folders, competitors, projects, balance, or store charts from Asolytics. Also use it when a user wants curl examples, lightweight integrations, or repeatable reporting workflows against the Asolytics API.
---

# Asolytics Public API

## Overview

Use this skill to work against the Asolytics Public API safely and efficiently.
Prefer the bundled references over re-discovering the API from scratch, and refresh the spec before relying on exact request or response shapes if the docs may have changed.

## Workflow

1. Read [references/api-overview.md](references/api-overview.md) first for auth, base URL, and endpoint families.
2. Read [references/endpoints.md](references/endpoints.md) when you need endpoint-level parameters or request body fields.
3. Read [references/openapi.json](references/openapi.json) only when exact schema details or edge cases matter.
4. Prefer small, cheap requests first because the API is alpha and some endpoints consume tokens.
5. Use `GET /public-api/v1/balance` when token awareness matters before running a wide query.

## Auth

Send the personal public API token in the `X-PUBLIC-API-TOKEN` header.
Prefer an environment variable such as `ASOLYTICS_PUBLIC_API_TOKEN` instead of pasting secrets into files or commits.
If the token is missing, ask the user for it or ask them to export it locally before running write or paid requests.

```bash
curl -sS \
  -H "X-PUBLIC-API-TOKEN: $ASOLYTICS_PUBLIC_API_TOKEN" \
  "https://app.asolytics.pro/public-api/v1/balance"
```

## Common Patterns

### Catalog Bootstrap

Resolve lookup data before building other requests:

1. Countries
2. Locales
3. Devices
4. Categories
5. Clusters
6. Projects

This avoids guessing valid `store`, `country_code`, `device`, `category_key`, `cluster_key`, and `project_id` values.

### App Intelligence

Use the Applications endpoints for:

- current listing metadata
- screenshots and media
- store availability
- version history
- installs and revenue history
- ranking history

Start with the narrowest possible app set because some metadata endpoints bill per returned pair.

### Keyword Workflows

Use the Keywords and Recommended Keywords endpoints for:

- ranking history
- popularity history
- latest keyword metrics
- live search top 50
- recommended keyword review
- async rank tracking jobs with optional webhook callbacks

When the user wants automation, prefer plain HTTP calls and return the exact request payload you used.

### Tracking Maintenance

Use Tracking Keywords and Tracking Folders for:

- listing tracked keywords
- adding tracked keywords
- deleting tracked keywords by `keyword_ids`
- creating folders
- renaming folders
- adding or removing keywords inside folders

Fetch first, mutate second. For delete operations, resolve ids and current contents before issuing the write request.

### Competitors and Charts

Use Competitors and Store Charts for:

- listing current competitors
- marking or unmarking a competitor
- retrieving top-500 charts by store, country, cluster, category, and device

## Guardrails

- Treat the API as unstable unless the current OpenAPI spec confirms the shape you expect.
- Do not hardcode secrets in source files, shell history snippets, or Git commits.
- Call out token-related costs when a request fans out across many apps, locales, or keywords.
- Prefer read-only endpoints before any state-changing request.
- Echo the exact endpoint, query parameters, and JSON body in your answer when the user asks for integration help.

## Resources

- `references/api-overview.md`: fast orientation and usage guidance.
- `references/endpoints.md`: generated endpoint inventory grouped by tag.
- `references/openapi.json`: raw public OpenAPI snapshot.
- `scripts/sync_openapi.py`: refresh the OpenAPI snapshot and regenerate `endpoints.md`.
