# AGENTS.md

本文件是给后续所有 AI agent、协作者和未来自己的项目操作手册。任何长期任务开始前，先阅读本文件。

## 项目目标

本项目目标是在 3 个月内推进一篇 CCF C 英文期刊论文投稿，方向为：

资源异构客户端下的自适应 Rank 个性化联邦 LoRA 微调。

暂定方法名：`AdaFedLoRA-P`。

## 工作目录

所有项目文件必须放在：

```text
D:\paper
```

不要再使用旧路径：

```text
C:\Users\drunk\Documents\paper
```

## 最高优先级规则

1. 不编造文献。
2. 不编造数据。
3. 不编造实验结果。
4. 不把未经核验的候选想法写成论文结论。
5. 不直接手填实验图表结果。
6. 不删除用户或前序 agent 的工作，除非用户明确要求。
7. 所有关键变更必须能通过 git 历史、项目状态文件或实验日志追溯。

## 每次开始工作前

必须检查：

```powershell
git status --short --branch
powershell -ExecutionPolicy Bypass -File scripts/check-project.ps1
```

必须阅读：

- `PROJECT_STATE.md`
- `docs/roadmap.md`
- `docs/executable-plan-3months.md`
- `docs/no-fabrication-protocol.md`

如果涉及实验，还必须阅读：

- `experiments/experiment-registry.csv`
- `experiments/run-log.md`

如果涉及论文写作，还必须阅读：

- `literature/evidence-ledger.csv`
- `manuscript/outline.md`
- `manuscript/draft.md`

## 文件职责

- `PROJECT_STATE.md`：当前项目状态和下一步。
- `docs/roadmap.md`：长期阶段路线图。
- `docs/executable-plan-3months.md`：12 周执行计划。
- `docs/no-fabrication-protocol.md`：防编造协议。
- `literature/evidence-ledger.csv`：证据台账。
- `experiments/experiment-registry.csv`：实验注册。
- `experiments/run-log.md`：实验运行记录。
- `results/`：可追溯结果索引。
- `manuscript/`：论文草稿。

## Git 规则

- 每完成一个稳定阶段，创建一次 commit。
- 重要里程碑创建 tag。
- 不在未提交状态下进行大规模重构。
- 不提交大型模型、checkpoint、原始数据或缓存。
- 初期 GitHub 仓库应设置为 private。

推荐分支：

```text
main
codex/literature-review
codex/baseline-framework
codex/experiments
codex/manuscript
```

## 论文写作规则

任何正文主张必须能追溯到：

- 文献证据：`literature/evidence-ledger.csv`
- 实验记录：`experiments/run-log.md`
- 结果文件：`results/`

禁止使用：

- 不存在的论文。
- 只凭标题猜测的相关工作。
- 没有实验日志支撑的性能提升。
- 没有 CCF 官方目录核验的期刊类别。

## 实验规则

每个实验必须先登记到：

```text
experiments/experiment-registry.csv
```

运行后必须记录到：

```text
experiments/run-log.md
```

每个结果必须说明：

- 实验编号。
- 代码版本。
- 命令。
- 模型。
- 数据。
- 随机种子。
- 硬件环境。
- 输出路径。

## 当前研究主线

主线：

资源异构客户端下的自适应 Rank 个性化联邦 LoRA 微调。

核心模块：

1. 共享 LoRA + 私有 LoRA。
2. 资源自适应 rank 分配。
3. 性能、个性化和通信成本联合评估。

暂不作为主贡献：

- 差分隐私。
- 真实多机部署。
- 复杂客户端聚类。
- 7B 以上模型主实验。

## 方向建议

主实验优先使用通用英文 NLP 数据集，因为它们更稳定、更容易复现、更适合快速形成完整实验链路。

教育数据可以作为补充实验，用于增强应用背景，但不强制作为主实验。

## 交接要求

每次阶段结束时更新：

- `PROJECT_STATE.md`
- `docs/roadmap.md`
- 相关台账或日志

如果任务中断，必须在 `PROJECT_STATE.md` 写明：

- 已完成什么。
- 正在做什么。
- 下一步命令或文件。
- 当前风险。

