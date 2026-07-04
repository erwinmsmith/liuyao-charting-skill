# 六爻排盘 Skill

这是一个可独立发布的六爻 skill，用于确定性排盘、可溯源解卦提示词，并支持多种 agent 系统。

它把公开 OrbitAgent 仓库里“排盘、装卦、纳甲、六亲、六神、旬空、旺衰、伏神、用神候选”等排盘核心抽出来，做成一个不依赖原仓库、不启动服务的独立 skill。排盘脚本本身不调用 LLM；如果 agent 需要写叙事解读，可使用内置的解卦 workflow、prompt 和 few-shot。

## 关联仓库

- 源项目：[erwinmsmith/OrbitAgent](https://github.com/erwinmsmith/OrbitAgent)
- 当前独立 skill 仓库：[erwinmsmith/liuyao-charting-skill](https://github.com/erwinmsmith/liuyao-charting-skill)
- OrbitAgent 内嵌镜像路径：[skills/liuyao-charting](https://github.com/erwinmsmith/OrbitAgent/tree/main/skills/liuyao-charting)

## 能做什么

- 支持六个爻值、静态阴阳 bits、三枚硬币、随机硬币、三数起卦、时间起卦、字占。
- 输出结构化 JSON，包括本卦、变卦、动爻、宫位、世应、纳甲、六亲、六神、旬空、日月关系、旺衰标签、十二长生、伏神/飞神、化象、支关系、用神候选。
- skill 内自带 64 卦数据，不需要再 clone OrbitAgent。
- 内置解卦流程说明、系统提示词、报告模板和 few-shot 响应模式。
- 通过内置 profile 支持 Codex、Claude Code、OpenClaw、Hermes 和通用 shell agent。

## 目录结构

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

## 快速使用

在本仓库执行：

```bash
python3 liuyao-charting/scripts/liuyao_chart.py \
  --yao 7,7,9,7,8,6 \
  --day-stem 甲 \
  --day-branch 子 \
  --month-branch 午 \
  --question "这个项目上线顺不顺利"
```

校验 skill：

```bash
python3 /path/to/skill-creator/scripts/quick_validate.py ./liuyao-charting
```

如果 agent 需要对照源代码或重新迁移，只从公开 [OrbitAgent](https://github.com/erwinmsmith/OrbitAgent) 源仓库 clone：

```bash
git clone https://github.com/erwinmsmith/OrbitAgent.git
```

## 多 Agent 支持

这个 skill 不绑定具体运行时。任何能读取文件、运行本地 Python 命令并解析 JSON 的 agent 都可以使用同一个排盘接口：

```bash
python3 liuyao-charting/scripts/liuyao_chart.py <casting-input> [time-pillars]
```

内置 profile：

| Agent 系统 | Profile | 说明 |
|---|---|---|
| Codex | [codex.md](liuyao-charting/agents/codex.md) | 通过 `SKILL.md` 原生使用。 |
| Claude Code | [claudecode.md](liuyao-charting/agents/claudecode.md) | 可从 `CLAUDE.md` 引用的使用说明。 |
| OpenClaw | [openclaw.md](liuyao-charting/agents/openclaw.md) | 适合 shell-capable OpenClaw agent 的 tool/profile 写法。 |
| Hermes | [hermes.md](liuyao-charting/agents/hermes.md) | 适合 Hermes 风格 agent 的 prompt/tool 边界说明。 |
| 通用 agent | [generic.md](liuyao-charting/agents/generic.md) | 适用于任何能执行 shell 命令并解析 JSON 的运行时。 |

所有 profile 使用同一个稳定接口：运行 `python3 liuyao-charting/scripts/liuyao_chart.py`，并把 JSON 输出当作唯一事实来源。

需要解卦时，agent 应读取：

- [interpretation-workflow.md](liuyao-charting/references/interpretation-workflow.md)
- [system-prompt.md](liuyao-charting/prompts/system-prompt.md)
- [report-template.md](liuyao-charting/prompts/report-template.md)
- [few-shots.md](liuyao-charting/prompts/few-shots.md)

## 安装到 Codex

复制或软链接 `liuyao-charting/` 到 Codex skills 目录：

```bash
cp -R ./liuyao-charting "${CODEX_HOME:-$HOME/.codex}/skills/"
```

## 原仓库信息

这个独立 skill 来自公开 OrbitAgent 仓库的六爻确定性排盘层。

- 源项目：[erwinmsmith/OrbitAgent](https://github.com/erwinmsmith/OrbitAgent)
- OrbitAgent 内嵌 skill 路径：[skills/liuyao-charting](https://github.com/erwinmsmith/OrbitAgent/tree/main/skills/liuyao-charting)
- 详细来源说明：[references/original-sources.md](references/original-sources.md)

独立 Python 脚本是从 TypeScript 排盘规则迁移/改写而来。prompt 资源是对 OrbitAgent 分析/报告流程的可移植整理。这个包故意不包含 OrbitAgent 的实时 agent 编排、RAG 索引、LLM adapter、持久化、API route、鉴权、MongoDB、Redis 等运行时系统。

## 与 OrbitAgent 同步

从本地 OrbitAgent checkout 拉取内嵌 skill：

```bash
ORBIT_AGENT_REPO=/path/to/OrbitAgent ./scripts/sync_from_target.sh
```

把当前独立仓库里的 skill 推回本地 OrbitAgent checkout：

```bash
ORBIT_AGENT_REPO=/path/to/OrbitAgent ./scripts/sync_to_target.sh
```

两个脚本只会替换目标侧的 `liuyao-charting/` skill 文件夹。
