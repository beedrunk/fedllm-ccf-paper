# 路线图

## 阶段 0：项目搭建

状态：已完成

目标：
- 建立目录和证据规则。
- 明确不编造文献、数据、实验结果的执行机制。
- 形成候选研究问题。
- 固化用户约束，形成 3 个月执行计划。

交付物：
- `README.md`
- `docs/no-fabrication-protocol.md`
- `proposal/research-plan.md`
- `literature/evidence-ledger.csv`
- `experiments/experiment-registry.csv`
- `docs/project-constraints.md`
- `docs/executable-plan-3months.md`

## 阶段 1：系统文献核验和环境核验

状态：下一步

目标：
- 建立真实文献库。
- 梳理 FedLLM、PEFT/LoRA、个性化联邦学习、隐私保护、系统异构五条线。
- 明确现有工作已经解决什么、没有解决什么。
- 核验本地 GPU、CUDA、PyTorch、Transformers、PEFT 环境。
- 跑通单客户端 LoRA 微调。

准入标准：
- 每篇文献必须记录 DOI、arXiv、ACL Anthology、IEEE、ACM、Springer、Elsevier 或出版社页面之一。
- 不使用二手博客作为核心依据。
- 对每篇核心文献记录任务、方法、假设、实验设置、局限。

## 阶段 2：问题定义和可证伪假设

状态：未开始

目标：
- 把研究问题写成可测量形式。
- 明确哪些指标能证明方法有效，哪些结果会推翻方案。

交付物：
- `proposal/research-plan.md` 第二版
- `proposal/risk-register.md`

## 阶段 3：最小可行实验

状态：未开始

目标：
- 先复现简单基线，再加入新模块。
- 验证是否存在值得写论文的问题。

最低要求：
- 至少一个公开模型。
- 至少两个公开数据集或任务。
- 至少三个基线。
- 至少一个 Non-IID 设置。
- 完整记录训练配置、随机种子、硬件环境。

## 阶段 4：完整实验和消融

状态：未开始

目标：
- 完整比较主方法、基线、消融和敏感性分析。
- 补充通信开销、训练成本、隐私风险或个性化收益分析。

## 阶段 5：论文写作

状态：未开始

目标：
- 只将已核验文献和已复现实验写入正文。
- 完成中文或英文初稿。
- 根据目标 CCF 期刊格式调整。

## 阶段 6：投稿准备

状态：未开始

目标：
- 核验目标期刊仍在 CCF 推荐目录中。
- 检查投稿范围、版面、模板、匿名要求、伦理要求和数据可用性声明。
- 完成导师审阅和投稿前自查。
