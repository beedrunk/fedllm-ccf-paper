# 研究方案草案

## 暂定题目

资源异构客户端下的自适应 Rank 个性化联邦大语言模型参数高效微调方法

英文暂定题目：

Adaptive Rank-aware Personalized Federated LoRA Fine-tuning for Large Language Models under Resource Heterogeneity

## 研究定位

本方案关注 FedLLM 场景下的参数高效微调。当前假设是：在资源异构和数据 Non-IID 同时存在时，单一全局 LoRA 和统一 rank 设置难以兼顾性能、个性化和通信效率，因此需要自适应 rank 和个性化适配机制。

注意：以上是研究假设，不是已证实结论。必须通过文献核验和实验验证。

## 方法雏形

方法暂名：AdaFedLoRA-P。

AdaFedLoRA-P 表示 Adaptive Rank-aware Personalized Federated LoRA Fine-tuning。

## 模块设计

模块 1：共享-私有双层适配器

```text
Frozen LLM backbone
  + Global shared LoRA
  + Local private LoRA
```

待验证假设：
- Global adapter 学习跨客户端共享能力。
- Private adapter 保留客户端特有模式。

模块 2：资源感知 rank 分配

不同客户端根据算力、显存和通信预算选择不同 rank 或上传预算。

候选策略：
- 固定预算分层：弱客户端低 rank，强客户端高 rank。
- 动态预算分配：根据 loss 下降和历史贡献调整。
- 子空间对齐：将异构 rank 更新映射到可聚合空间。

风险：
- 异构 rank 聚合可能实现复杂。
- rank 分配收益可能不稳定。
- 强基线可能已经足够有效。

模块 3：Non-IID 个性化训练

将共享 LoRA 通过联邦聚合更新，私有 LoRA 只保留在客户端本地，用于缓解数据 Non-IID 导致的负迁移。

候选策略：
- 只聚合共享 LoRA。
- 私有 LoRA 加正则约束，避免过拟合。
- 比较全局、私有、共享+私有三种结构。

模块 4：通信成本建模

记录不同 rank 和客户端参与率下的上传参数量、总通信量和训练时间，使方法贡献不只体现在任务指标上。

模块 5：轻量稳健聚合

在共享 LoRA 聚合时引入更新裁剪和异常更新降权，降低 Non-IID 或不稳定客户端对共享适配器的干扰。

候选策略：
- 更新范数裁剪。
- 基于 cosine similarity 的更新降权。
- 基于资源可靠性和训练收益的聚合权重。

模块 6：轻量理论分析

补充聚合偏差和资源分配目标的形式化描述，避免论文只停留在系统评测层面。

理论分析最小要求：
- 定义朴素 LoRA 聚合与理想权重更新之间的聚合偏差。
- 定义客户端 rank 与通信/训练预算之间的约束。
- 解释共享/私有 LoRA 和稳健聚合如何服务于上述目标。

## 预期创新点

以下创新点必须在文献核验后才能写入论文：

1. 从资源异构和数据 Non-IID 耦合角度建模 FedLLM 参数高效微调。
2. 设计共享-私有 LoRA 结构，兼顾跨客户端知识共享和客户端个性化。
3. 设计资源自适应 rank 或通信预算分配机制，允许异构设备共同参与训练。
4. 引入轻量稳健聚合，降低异构更新对共享 LoRA 的干扰。
5. 建立性能、个性化、稳健性和通信成本统一评估框架。

## 最小可行版本

优先实现：
- Frozen backbone + LoRA。
- FedAvg-LoRA 基线。
- Local LoRA 基线。
- 共享-私有 adapter。
- 更新裁剪或相似度降权的稳健聚合最小版本。
- 一个 Non-IID 划分。
- 一个英文任务先跑通，再扩展到教育相关公开数据。

暂缓实现：
- 完整差分隐私会计。
- 大规模客户端模拟。
- 多模型对比。
- 复杂客户端聚类或软路由。
