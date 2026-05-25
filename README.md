# FedLLM CCF Paper Project

本项目用于从 0 推进一篇联邦学习大语言模型方向的 CCF 期刊论文，目标是长期维护到投稿。

## 核心原则

1. 不编造文献：任何论文相关说法必须有可追溯来源。
2. 不编造数据：任何数据集、样本量、划分、预处理都必须记录来源和脚本。
3. 不编造实验结果：任何数值结论只能来自可复现实验日志。
4. 不提前写死结论：研究假设、实验观察、论文结论分开记录。
5. 先做可证伪方案，再写论文叙事。

## 目录

```text
docs/              项目规则、路线图、研究问题
literature/        文献检索、阅读笔记、证据台账
proposal/          研究方案、创新点、风险分析
experiments/       实验注册、运行日志、结果索引
manuscript/        论文大纲和正文草稿
journal/           CCF 期刊选择和投稿要求核验
review/            投稿前自查、导师反馈、审稿意见处理
scripts/           项目质量检查脚本
data/              数据说明，不提交原始大数据
results/           实验结果索引，不提交不可追溯结果
```

## 每周工作流

1. 更新 `docs/roadmap.md` 的当前阶段状态。
2. 文献只先进入 `literature/search-log.md`，确认真实存在后再写阅读笔记。
3. 每个可用于论文的事实写入 `literature/evidence-ledger.csv`。
4. 每个实验先登记到 `experiments/experiment-registry.csv`，再运行。
5. 实验完成后记录到 `experiments/run-log.md`，结果文件放到 `results/` 并写明生成命令。
6. 只有通过证据台账和实验日志支撑的内容，才允许进入 `manuscript/draft.md`。

## Agent 交接

后续任何 AI agent 或协作者接手前，必须先阅读：

- `AGENTS.md`
- `PROJECT_STATE.md`
- `docs/archival-policy.md`

## 当前建议研究方向

暂定方向：面向异构客户端的隐私感知个性化联邦大语言模型参数高效微调。

该方向现在只是工作假设，不是论文结论。是否保留，需要经过文献核验、问题复现、基线实验和消融实验验证。
