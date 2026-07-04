# Liuyao Charting Skill

Standalone Liuyao skill for deterministic charting, grounded interpretation prompts, and multiple agent runtimes.

This repository packages the charting-focused part of the public OrbitAgent Liuyao implementation as a reusable skill. Charting does not require cloning OrbitAgent, starting services, connecting to MongoDB or Redis, or calling an LLM. Optional interpretation workflow prompts and few-shots are bundled for agents that need to write grounded narrative readings.

## Related Repositories

- Source project: [erwinmsmith/OrbitAgent](https://github.com/erwinmsmith/OrbitAgent)
- Standalone skill repo: [erwinmsmith/liuyao-charting-skill](https://github.com/erwinmsmith/liuyao-charting-skill)
- Mirrored OrbitAgent skill path: [skills/liuyao-charting](https://github.com/erwinmsmith/OrbitAgent/tree/main/skills/liuyao-charting)

## What It Does

- Accepts explicit six yao values, static yin/yang bits, 3-coin throws, random coins, three-number casting, Gregorian time-style casting, and one-character casting.
- Produces structured JSON with original and changed hexagrams, moving lines, palace and shi/ying, NaJia, six relatives, six gods, xunkong, strength tags, twelve stages, fushen, transformations, branch relations, and basic yongshen candidates.
- Bundles the 64-gua data needed by the charting script.
- Bundles interpretation workflow guidance, a reusable system prompt, a structured report template, and few-shot response patterns.
- Supports multiple agent systems through bundled profiles for Codex, Claude Code, OpenClaw, Hermes, and generic shell-capable agents.

## Repository Layout

```text
liuyao-charting-skill/
├── README.md
├── README_zh.md
├── LICENSE
├── scripts/
│   ├── sync_from_target.sh
│   └── sync_to_target.sh
├── references/
│   └── original-sources.md
└── liuyao-charting/
    ├── SKILL.md
    ├── prompts/
    │   ├── system-prompt.md
    │   ├── report-template.md
    │   └── few-shots.md
    ├── references/
    │   ├── workflow.md
    │   ├── interpretation-workflow.md
    │   └── agent-support.md
    ├── agents/
    │   ├── codex.md
    │   ├── claudecode.md
    │   ├── openclaw.md
    │   ├── hermes.md
    │   └── generic.md
    └── scripts/
        ├── liuyao_chart.py
        └── data/
            └── 64gua.json
```

## Quick Use

From this repository:

```bash
python3 liuyao-charting/scripts/liuyao_chart.py \
  --yao 7,7,9,7,8,6 \
  --day-stem 甲 \
  --day-branch 子 \
  --month-branch 午 \
  --question "Will this project launch smoothly?"
```

Validate the skill:

```bash
python3 /path/to/skill-creator/scripts/quick_validate.py ./liuyao-charting
```

If an agent needs source comparison or regeneration, clone only the public [OrbitAgent](https://github.com/erwinmsmith/OrbitAgent) source project:

```bash
git clone https://github.com/erwinmsmith/OrbitAgent.git
```

## Multi-Agent Support

This skill is runtime-neutral. Any agent that can read files and run a local Python command can use the same charting interface:

```bash
python3 liuyao-charting/scripts/liuyao_chart.py <casting-input> [time-pillars]
```

Bundled profiles:

| Agent system | Profile | Notes |
|---|---|---|
| Codex | [codex.md](liuyao-charting/agents/codex.md) | Native Codex skill usage via `SKILL.md`. |
| Claude Code | [claudecode.md](liuyao-charting/agents/claudecode.md) | Instructions that can be referenced from `CLAUDE.md`. |
| OpenClaw | [openclaw.md](liuyao-charting/agents/openclaw.md) | Tool/profile style instructions for shell-capable OpenClaw agents. |
| Hermes | [hermes.md](liuyao-charting/agents/hermes.md) | Prompt/tool boundary instructions for Hermes-style agents. |
| Generic agents | [generic.md](liuyao-charting/agents/generic.md) | Works for any runtime that can execute shell commands and parse JSON. |

All profiles use the same stable interface: run `python3 liuyao-charting/scripts/liuyao_chart.py` and treat the JSON output as the source of truth.

For interpretation, agents should read:

- [interpretation-workflow.md](liuyao-charting/references/interpretation-workflow.md)
- [system-prompt.md](liuyao-charting/prompts/system-prompt.md)
- [report-template.md](liuyao-charting/prompts/report-template.md)
- [few-shots.md](liuyao-charting/prompts/few-shots.md)

## Install As A Codex Skill

Copy or symlink the skill folder into your Codex skills directory:

```bash
cp -R ./liuyao-charting "${CODEX_HOME:-$HOME/.codex}/skills/"
```

## Source Project

This standalone skill was extracted from the public OrbitAgent Liuyao deterministic charting layer.

- Source project: [erwinmsmith/OrbitAgent](https://github.com/erwinmsmith/OrbitAgent)
- Embedded skill path in OrbitAgent: [skills/liuyao-charting](https://github.com/erwinmsmith/OrbitAgent/tree/main/skills/liuyao-charting)
- Detailed provenance: [references/original-sources.md](references/original-sources.md)

The standalone Python script is a port of the deterministic TypeScript charting rules. The prompt resources are portable summaries of OrbitAgent's analysis/report workflow. This package intentionally excludes OrbitAgent runtime systems such as live agent orchestration, RAG indices, LLM adapters, persistence, API routes, auth, MongoDB, and Redis.

## Sync With OrbitAgent

Pull the embedded copy from a local OrbitAgent checkout:

```bash
ORBIT_AGENT_REPO=/path/to/OrbitAgent ./scripts/sync_from_target.sh
```

Push this standalone copy back into a local OrbitAgent checkout:

```bash
ORBIT_AGENT_REPO=/path/to/OrbitAgent ./scripts/sync_to_target.sh
```

Both scripts replace only the `liuyao-charting/` skill folder on the destination side.
