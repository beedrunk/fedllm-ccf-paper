# 3 个月可执行计划

## 总目标

在 3 个月内完成一篇面向 CCF C 英文期刊的 FedLLM 论文投稿稿，主题聚焦：

资源异构客户端下的自适应 Rank 个性化联邦 LoRA 微调。

目标不是做一个大而全的 FedLLM 框架，而是完成一个问题明确、公式清楚、实验可复现、适合开源的算法改进。

## 推荐论文主线

暂定方法名：AdaFedLoRA-P。

完整含义：

Adaptive Rank-aware Personalized Federated LoRA Fine-tuning。

核心思想：

在联邦大模型微调中，不同客户端资源能力和数据分布不同。统一 LoRA rank 和统一全局聚合容易导致弱设备参与困难、强设备表达能力受限、异构任务之间互相干扰。本文拟设计一个自适应 rank 的个性化联邦 LoRA 方法，将适配器拆成共享部分和个性化部分，并根据客户端资源预算动态分配可训练 rank。

## 研究问题

RQ1：在模拟资源异构和数据 Non-IID 条件下，统一 rank 的 FedLoRA 是否会造成性能和通信效率折中不佳？

RQ2：自适应 rank 分配是否能在接近或优于统一 rank 性能的同时降低通信成本？

RQ3：共享 LoRA 与个性化 LoRA 的拆分是否能改善不同客户端之间的负迁移，尤其是低资源或小数据客户端？

## 方法边界

必须做：
- Frozen 1B 级 LLM。
- LoRA/PEFT 微调。
- 模拟联邦客户端。
- 资源异构：不同客户端 rank、通信预算或本地 epoch。
- 数据 Non-IID：按类别、任务或 Dirichlet 划分。
- 个性化：全局共享适配器 + 本地私有适配器。
- 数学优化目标。
- 通信成本统计。

暂不做：
- 差分隐私。
- 真实多机部署。
- 7B 及以上模型。
- 复杂客户端聚类。
- 人工生成不可核验数据。

## 算法雏形

设共有 K 个客户端。基础大模型参数为 `theta_0`，冻结不训练。每个客户端 k 的 LoRA 更新由共享部分和私有部分组成：

```text
Delta theta_k = Delta theta_g + Delta theta_k^p
```

其中：

- `Delta theta_g` 是服务器聚合得到的共享 LoRA。
- `Delta theta_k^p` 是客户端本地保留的个性化 LoRA。
- 客户端 k 的 rank 为 `r_k`，由资源预算 `b_k` 和训练状态决定。

候选优化目标：

```text
min_{Delta theta_g, {Delta theta_k^p}} 
  sum_{k=1}^{K} p_k L_k(theta_0 + Delta theta_g + Delta theta_k^p)
  + lambda sum_{k=1}^{K} ||Delta theta_k^p||_F^2
  + beta C({r_k})
```

其中：

- `L_k` 是客户端 k 的本地任务损失。
- `p_k` 是客户端权重，可按样本量或均匀设置。
- `lambda` 控制个性化适配器复杂度。
- `C({r_k})` 表示通信或参数预算惩罚。
- `beta` 控制性能与通信成本折中。

候选 rank 分配：

```text
r_k = clip(r_min + floor(alpha * normalized_budget_k + gamma * normalized_gain_k), r_min, r_max)
```

其中：

- `normalized_budget_k` 表示客户端资源预算。
- `normalized_gain_k` 表示近期 loss 下降或梯度贡献。
- `r_min` 和 `r_max` 是 rank 下限和上限。

以上公式是方案草案，需要在文献核验和实验实现时修正。

## 最小可行实验

模型优先级：
1. `TinyLlama-1.1B` 或同级别 1B 模型。
2. 如果显存或速度不够，降到 `Qwen2.5-0.5B` 或同级别小模型。
3. 若后期租用服务器，可补充更大模型、更多客户端或更多随机种子，但不改变主方法和主问题。

数据优先级：
1. 英文教育类公开数据集。
2. 若教育数据难以支撑多客户端划分，使用通用英文分类/QA数据集作为主实验，教育数据作为应用补充。

客户端设置：
- 客户端数量：10 或 20。
- 每轮参与客户端：20% 到 50%。
- Non-IID：Dirichlet 划分或按任务划分。
- 资源异构：设置 low/mid/high 三类客户端 rank。

基线：
- Local LoRA。
- Centralized LoRA。
- FedAvg-LoRA。
- Uniform-rank personalized LoRA。
- Proposed adaptive-rank personalized FedLoRA。

指标：
- 任务性能：Accuracy/F1 或 ROUGE，根据数据集确定。
- 个性化性能：客户端本地测试集平均值和尾部客户端表现。
- 通信成本：每轮上传参数量和总上传参数量。
- 训练成本：单轮时间、总时间、显存占用。
- 稳定性：至少 3 个随机种子，若算力不够，需要明确说明限制。

## 12 周计划

### 第 1 周：文献和环境

目标：
- 核验 FedLoRA、PEFT、资源异构 FL、个性化 FL 的核心文献。
- 确认 GPU、CUDA、PyTorch、Transformers、PEFT 环境。
- 跑通单客户端 LoRA 微调。

产出：
- 10 篇核心文献笔记。
- `nvidia-smi` 和环境记录。
- 一个可运行的单机 LoRA baseline。

### 第 2 周：基线框架

目标：
- 搭建模拟联邦训练循环。
- 实现 Local LoRA、Centralized LoRA、FedAvg-LoRA。
- 固定一个小数据集跑通端到端流程。

产出：
- 可复现 baseline 代码。
- 第一版实验配置模板。
- 失败和耗时记录。

### 第 3 周：Non-IID 和资源异构

目标：
- 实现客户端数据划分。
- 实现 low/mid/high 资源客户端设置。
- 统计统一 rank 下性能和通信成本。

产出：
- RQ1 的初步结果。
- 是否继续当前方向的第一次决策。

### 第 4 周：方法最小版

目标：
- 实现共享 LoRA + 私有 LoRA。
- 实现固定异构 rank。
- 与 FedAvg-LoRA 对比。

产出：
- 方法最小版结果。
- 第一版方法公式。

### 第 5 周：自适应 rank

目标：
- 实现基于资源预算的 rank 分配。
- 实现基于训练收益的简单动态调整。
- 比较固定 rank 和自适应 rank。

产出：
- RQ2 初步结果。
- rank 分配消融。

### 第 6 周：个性化消融

目标：
- 比较只有全局、只有本地、全局+本地。
- 观察尾部客户端和平均性能。

产出：
- RQ3 初步结果。
- 方法是否成立的第二次决策。

### 第 7 周：数据集扩展

目标：
- 加入第二个数据集或教育场景数据。
- 保持实验规模可控。

产出：
- 跨数据集结果。
- 数据许可证和来源记录。

### 第 8 周：完整主实验

目标：
- 跑完整基线。
- 统一记录随机种子、超参数和硬件环境。
- 根据本地机器和租用服务器情况决定最终实验规模。

产出：
- 主结果表。
- 通信成本表。

### 第 9 周：补充实验

目标：
- 消融 `lambda`、rank 上限、客户端比例、Non-IID 强度。
- 选择最有说服力的 2 到 3 个补充实验。

产出：
- 消融图表。
- 参数敏感性分析。

### 第 10 周：论文初稿

目标：
- 完成 Introduction、Related Work、Method、Experiment 初稿。
- 所有引用和结果都回连证据台账。

产出：
- 可读完整初稿。

### 第 11 周：修改和开源整理

目标：
- 整理论文图表。
- 清理代码结构、README、配置文件。
- 导师反馈第一轮修改。

产出：
- 开源版本代码。
- 论文第二版。

### 第 12 周：投稿准备

目标：
- 核验 CCF C 英文期刊。
- 匹配模板。
- 完成投稿前自查。

产出：
- 投稿稿。
- cover letter 草稿。
- 数据和代码可用性声明。

## 换题条件

第 3 周后，如果统一 rank 和资源异构之间没有明显矛盾，则转向：

备选 A：Non-IID 下的个性化 FedLoRA。

第 6 周后，如果共享+私有 LoRA 没有稳定收益，则转向：

备选 B：FedLoRA 通信压缩和异构上传预算。

第 8 周后，如果两个数据集结果不一致，则转向：

备选 C：系统性评测论文，分析 FedLoRA 在资源异构和数据异构下的失效模式。

## 每周最低交付

每周至少更新：
- `literature/evidence-ledger.csv`
- `experiments/experiment-registry.csv`
- `experiments/run-log.md`
- `docs/roadmap.md`

每周必须回答：
- 本周新增了哪些真实证据？
- 哪些假设被支持？
- 哪些假设被削弱？
- 下周是否继续当前路线？
