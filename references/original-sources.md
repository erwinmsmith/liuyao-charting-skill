# Original Sources

This repository is a standalone packaging of the Liuyao deterministic charting layer extracted from the public OrbitAgent repository.

## Source Repositories

- Repository: `https://github.com/erwinmsmith/OrbitAgent`
- Local path at extraction time: `/Users/erwin/Downloads/codespace/Orbit/OrbitAgent`
- Commit at extraction time: `6e9d2093a3e5d8ce15a9b56f6e0d3fa027b40191`
- Embedded skill path: `skills/liuyao-charting`
- First OrbitAgent commit containing the mirrored skill: `cb0bf1f`
- Note at extraction time: local checkout had an unrelated modified `package-lock.json`

## Migrated Runtime Boundary

Included:

- Deterministic casting inputs.
- 64-gua data.
- Hexagram lookup.
- Palace, shi/ying, NaJia, six relatives, six gods.
- Xunkong, day/month branch relations, strength labels.
- Twelve stages.
- Fushen and transformations.
- Rule-based yongshen candidate selection.
- Portable interpretation workflow, prompt skeletons, report template, and few-shot response patterns derived from OrbitAgent's Liuyao analysis/report pipeline.

Excluded:

- OrbitAgent app server.
- Live OrbitAgent agent orchestration and workflows.
- LLM providers, RAG indices, and model calls.
- MongoDB, Redis, auth, API routes, user/session state, billing, and UI code.
- Exact Gregorian-to-ganzhi calendar conversion from `lunar-typescript`; this standalone skill accepts manually supplied pillars instead.

## Source File Map

The Python script `liuyao-charting/scripts/liuyao_chart.py` was ported from these TypeScript source areas:

- `OrbitAgent/src/liuyao/casting/methods.ts`
- `OrbitAgent/src/liuyao/skills/chartAssembler.ts`
- `OrbitAgent/src/liuyao/skills/castSkill.ts`
- `OrbitAgent/src/liuyao/skills/hexagramSkill.ts`
- `OrbitAgent/src/liuyao/skills/palaceSkill.ts`
- `OrbitAgent/src/liuyao/skills/najiaSkill.ts`
- `OrbitAgent/src/liuyao/skills/sixRelativeSkill.ts`
- `OrbitAgent/src/liuyao/skills/sixGodSkill.ts`
- `OrbitAgent/src/liuyao/skills/voidSkill.ts`
- `OrbitAgent/src/liuyao/skills/strengthSkill.ts`
- `OrbitAgent/src/liuyao/skills/twelveStageSkill.ts`
- `OrbitAgent/src/liuyao/skills/fushenSkill.ts`
- `OrbitAgent/src/liuyao/skills/transformationSkill.ts`
- `OrbitAgent/src/liuyao/skills/branchRelationSkill.ts`
- `OrbitAgent/src/liuyao/skills/yongshenSkill.ts`
- `OrbitAgent/src/liuyao/agent/questionClassifier.ts`
- `OrbitAgent/src/liuyao/agent/analysisAgent.ts`
- `OrbitAgent/src/liuyao/agent/reportTemplate.ts`
- `OrbitAgent/src/liuyao/agent/chartBrief.ts`
- `OrbitAgent/prompts/system/liuyao-agent.yaml`
- `OrbitAgent/src/liuyao/constants/*.ts`

The bundled 64-gua data file was copied from:

- `OrbitAgent/docs/base_knowledge/64卦数据.json`

## Licensing Note

At extraction time, `OrbitAgent/package.json` declared `"license": "MIT"`. No repository-level `LICENSE` file was present in the local Orbit or OrbitAgent checkout. This standalone repository includes an MIT license for the extracted/ported skill package.
