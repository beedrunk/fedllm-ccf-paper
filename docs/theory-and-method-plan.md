# 理论与方法补强计划

## 目标

避免论文只像系统评测，至少形成一个清晰的“方法学 + 学习系统目标”框架。

本文不追求强理论证明，但需要补充三个层面的形式化分析：

1. 聚合偏差。
2. 资源分配目标。
3. 稳健聚合权重。

## 1. 聚合偏差形式化

LoRA 更新可写为：

$$
\Delta W_k = B_k A_k
$$

朴素聚合分别平均 $A_k$ 和 $B_k$：

$$
\Delta W_{\mathrm{naive}}
=
\left(\sum_k p_k B_k\right)
\left(\sum_k p_k A_k\right)
$$

理想的加权平均更新为：

$$
\Delta W_{\mathrm{ideal}}
=
\sum_k p_k B_k A_k
$$

聚合偏差定义为：

$$
\mathcal{E}_{agg}
=
\left\|
\sum_k p_k B_k A_k
-
\left(\sum_k p_k B_k\right)
\left(\sum_k p_k A_k\right)
\right\|_F
$$

后续方法需要说明：

- 共享 LoRA 聚合是否减少或绕开该偏差。
- 私有 LoRA 不上传是否降低 Non-IID 客户端对全局共享更新的干扰。
- 稳健聚合是否能降低异常更新对 $\Delta W_g$ 的影响。

## 2. 资源分配目标

客户端 $k$ 的资源预算记为 $b_k$，LoRA rank 为 $r_k$，通信成本可近似为：

$$
C_k(r_k) = c_l \cdot r_k
$$

其中 $c_l$ 与目标层数量、输入输出维度和上传频率有关。

资源约束：

$$
C_k(r_k) \leq b_k
$$

总体目标：

$$
\min_{\Delta \theta_g, \{\Delta \theta_k^p\}, \{r_k\}}
\sum_k p_k \mathcal{L}_k
+
\lambda \sum_k \|\Delta \theta_k^p\|_F^2
+
\beta \sum_k C_k(r_k)
$$

需要实验验证：

- 固定 rank 与自适应 rank 的性能/通信折中。
- low/mid/high 资源客户端的公平性变化。
- 资源预算变化时方法是否稳定。

## 3. 稳健聚合权重

为了降低 Non-IID 和异常客户端更新对共享 LoRA 的影响，可设计权重：

$$
\omega_k
\propto
p_k \cdot q_k \cdot s_k
$$

其中：

- $p_k$：样本量或均匀权重。
- $q_k$：资源可靠性或参与稳定性。
- $s_k$：更新相似度或训练收益。

共享 LoRA 聚合：

$$
\Delta \theta_g^{t+1}
=
\sum_{k \in \mathcal{S}_t}
\frac{\omega_k}{\sum_j \omega_j}
\Delta \theta_{g,k}^{t+1}
$$

最小可行实现：

- 先使用裁剪后的加权 FedAvg。
- 再加入基于更新范数或 cosine similarity 的异常更新降权。
- 不在第一阶段引入复杂聚类。

## 4. 与相关工作的差异化表述

| 工作 | 重点 | 本文差异 |
| --- | --- | --- |
| FLoRA | 异构 LoRA 聚合与聚合噪声 | 本文强调共享/私有个性化结构与资源预算下的统一评测 |
| FlexLoRA | 异构任务和资源下的动态 rank | 本文增加私有 LoRA 和稳健聚合，避免只做 rank 调度 |
| AFLoRA | 资源感知自适应 rank | 本文将自适应 rank 与个性化结构、稳健聚合结合 |
| FedHL | 无偏异构 LoRA 聚合和收敛分析 | 本文借鉴偏差分析，但以个性化和资源预算为主线 |
| EcoLoRA | 通信高效 LoRA segment sharing | 本文不主打通信压缩，而是评估通信成本和资源预算 |
| FedEx-LoRA | 精确聚合与残差修正 | 本文借鉴聚合偏差定义，但不直接做精确聚合替代 |

## 5. 需要完成的阅读

优先精读：

1. FLoRA。
2. FlexLoRA。
3. AFLoRA。
4. FedHL。
5. FedEx-LoRA。
6. EcoLoRA。

每篇文献必须产出：

- 问题定义。
- 方法公式。
- 理论分析点。
- 实验设置。
- 与本文的差异。
- 可复现或可借鉴部分。

