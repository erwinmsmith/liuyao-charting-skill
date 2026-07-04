# 六爻排盘 Skill

这是一个可独立发布的 Codex skill，用于确定性六爻排盘。

它把 Orbit / OrbitAgent 里“排盘、装卦、纳甲、六亲、六神、旬空、旺衰、伏神、用神候选”等确定性部分抽出来，做成一个不依赖原仓库、不启动服务、不调用 LLM 的独立 skill。

## 能做什么

- 支持六个爻值、静态阴阳 bits、三枚硬币、随机硬币、三数起卦、时间起卦、字占。
- 输出结构化 JSON，包括本卦、变卦、动爻、宫位、世应、纳甲、六亲、六神、旬空、日月关系、旺衰标签、十二长生、伏神/飞神、化象、支关系、用神候选。
- skill 内自带 64 卦数据，不需要再 clone OrbitAgent。

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
    ├── references/
    │   └── workflow.md
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

## 安装到 Codex

复制或软链接 `liuyao-charting/` 到 Codex skills 目录：

```bash
cp -R ./liuyao-charting "${CODEX_HOME:-$HOME/.codex}/skills/"
```

## 原仓库信息

这个独立 skill 来自 Orbit 主项目和 OrbitAgent 的六爻确定性排盘层。

- 主项目：`https://github.com/erwinmsmith/Orbit`
- 源服务：`https://github.com/erwinmsmith/OrbitAgent`
- 主项目内嵌 skill 路径：`skills/liuyao-charting`
- 详细来源说明：`references/original-sources.md`

独立 Python 脚本是从 TypeScript 排盘规则迁移/改写而来。它故意不包含 OrbitAgent 的 agent、RAG、LLM adapter、持久化、API route、鉴权、MongoDB、Redis 等运行时系统。

## 与主项目同步

从本地 Orbit checkout 拉取内嵌 skill：

```bash
ORBIT_REPO=/path/to/Orbit ./scripts/sync_from_target.sh
```

把当前独立仓库里的 skill 推回本地 Orbit checkout：

```bash
ORBIT_REPO=/path/to/Orbit ./scripts/sync_to_target.sh
```

两个脚本只会替换目标侧的 `liuyao-charting/` skill 文件夹。

