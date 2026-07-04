# Liuyao Charting Skill

Standalone Codex skill for deterministic Liuyao charting.

This repository packages the charting-only part of the public OrbitAgent Liuyao implementation as a reusable skill. It does not require cloning OrbitAgent, starting services, connecting to MongoDB or Redis, or calling an LLM.

## Related Repositories

- Source project: `https://github.com/erwinmsmith/OrbitAgent`
- This standalone skill repo: `https://github.com/erwinmsmith/liuyao-charting-skill`

## What It Does

- Accepts explicit six yao values, static yin/yang bits, 3-coin throws, random coins, three-number casting, Gregorian time-style casting, and one-character casting.
- Produces structured JSON with original and changed hexagrams, moving lines, palace and shi/ying, NaJia, six relatives, six gods, xunkong, strength tags, twelve stages, fushen, transformations, branch relations, and basic yongshen candidates.
- Bundles the 64-gua data needed by the charting script.
- Includes agent profiles for Codex, Claude Code, OpenClaw, Hermes, and generic shell-capable agents.

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
    ├── references/
    │   └── workflow.md
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

If an agent needs source comparison or regeneration, clone only the public source project:

```bash
git clone https://github.com/erwinmsmith/OrbitAgent.git
```

## Multi-Agent Profiles

Profiles are bundled in `liuyao-charting/agents/`:

- `codex.md`
- `claudecode.md`
- `openclaw.md`
- `hermes.md`
- `generic.md`

All profiles use the same stable interface: run `python3 liuyao-charting/scripts/liuyao_chart.py` and treat the JSON output as the source of truth.

## Install As A Codex Skill

Copy or symlink the skill folder into your Codex skills directory:

```bash
cp -R ./liuyao-charting "${CODEX_HOME:-$HOME/.codex}/skills/"
```

## Source Project

This standalone skill was extracted from the public OrbitAgent Liuyao deterministic charting layer.

- Source project: `https://github.com/erwinmsmith/OrbitAgent`
- Embedded skill path in OrbitAgent: `skills/liuyao-charting`
- Detailed provenance: `references/original-sources.md`

The standalone Python script is a port of the deterministic TypeScript charting rules. It intentionally excludes OrbitAgent runtime systems such as agents, RAG, LLM adapters, persistence, API routes, auth, MongoDB, and Redis.

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
