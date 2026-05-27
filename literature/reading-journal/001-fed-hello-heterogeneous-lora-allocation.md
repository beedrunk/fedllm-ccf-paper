# 001 - Fed-HeLLo

## 基本信息

- 标题：Fed-HeLLo: Efficient Federated Foundation Model Fine-Tuning with Heterogeneous LoRA Allocation
- 作者：Zikai Zhang, Ping Liu, Jiahao Xu, Rui Hu
- 年份：2025
- 状态：arXiv，页面备注为 Accepted to TNNLS 2025
- arXiv ID：2506.12213
- 阅读日期：2026-05-27
- 链接：
  - https://arxiv.org/abs/2506.12213
  - https://ar5iv.labs.arxiv.org/html/2506.12213v1

## 一句话总结

Fed-HeLLo 的核心是：在资源异构的联邦 LoRA 微调中，不同客户端不必训练同一组 LoRA 层，而是根据客户端资源能力和层重要性分配不同的可训练 LoRA layer。

## 我的初始理解

用户的初始理解：

> 其实它就是将以前的策略进行了一个分配，相当于把不同策略进行了组合。根据 transformer 不同深度层的特点设计了一些结构，给不同客户端分配不同的 LoRA 层。重点说明了自己的设计与传统设计的最大不同，但是并没有充分的实验性验证。验证的设备只有 A100、RTX3060 和手机，符合他的三层设计。核心思路是让不同类型的设备训练不同的 LoRA 层，从而降低每台设备的显存压力，进行微调。创新点：谁训练对应的 LoRA layer。

## 对我的理解的校正

### 基本正确

“创新点是：谁训练对应的 LoRA layer”这个概括是准确的简化表达。

更严谨的表达是：

> 在资源异构客户端中，根据客户端资源能力和 LoRA 层重要性分配可训练 LoRA 层，从而让不同客户端承担不同的本地 LoRA 训练负载。

### 需要修正

1. **不只是旧策略组合。**  
   论文提出的是 HLA 策略族，包括 FIM-HLA、GD-HLA 和 RGD-HLA。它不是简单把旧方法拼接，而是围绕“动态层重要性”和“固有层重要性”设计 LoRA 层分配策略。

2. **实验不应写成只有 A100、RTX3060 和手机。**  
   当前可核验内容显示，论文主要模拟不同资源能力客户端，并在五个数据集和 IID 到 extreme Non-IID 设置下评估。真实设备可以作为资源层级的直觉，但不能在我们的证据台账中写成论文唯一实验设置。

3. **实验验证并非完全不足。**  
   论文覆盖视觉和语言任务，并有多个 Non-IID 设置、资源能力分布和消融。更合适的批评是：它的主贡献集中在 heterogeneous layer allocation，对个性化结构、共享/私有解耦、稳健聚合和统一评测的覆盖仍不是我们的主线目标。

## 论文真正解决的问题

传统联邦 LoRA 微调通常假设客户端训练相同结构或相同 rank 的 LoRA 模块。但在真实环境中，客户端资源能力不同，如果所有客户端训练相同 LoRA 层，会出现：

- 低资源客户端训练压力大。
- 高资源客户端能力利用不足。
- 不同客户端对不同层的训练贡献没有被显式调度。

Fed-HeLLo 试图解决的问题是：

> 如何在资源异构客户端中，为不同客户端分配不同可训练 LoRA 层，使其在有限资源下协同微调 foundation model。

## 方法拆解

### 1. Heterogeneous LoRA Allocation

Fed-HeLLo 的主要机制是 HLA，即 heterogeneous LoRA allocation。

每个客户端不是训练所有 LoRA layer，而是根据资源能力训练一部分 LoRA layer。这样可以降低低资源客户端的本地训练成本，也让高资源客户端训练更多层。

### 2. FIM-HLA

FIM-HLA 使用 Fisher Information Matrix score 相关思想，根据动态梯度信息估计层重要性，并由服务器生成 LoRA 层分配。

理解：

- 优点：能根据训练过程动态调整。
- 风险：训练早期层重要性估计可能不稳定。

### 3. GD-HLA

GD-HLA 使用 transformer 不同深度层的固有作用设计几何分配模式。

论文提到的模式包括：

- Triangle
- Inverted Triangle
- Bottleneck
- Uniform

理解：

- shallow layers 更偏低层特征。
- deep layers 更偏语义特征。
- Bottleneck 试图兼顾浅层和深层。

### 4. RGD-HLA

RGD-HLA 是 GD-HLA 的随机化版本，用随机性增强训练稳定性和模型表现。

### 5. FIM-HLA + RGD-HLA 协同

论文最终不是只用一种策略，而是把 RGD-HLA 和 FIM-HLA 结合：

- 训练早期用 RGD-HLA warm-start。
- 后续周期性用 FIM-HLA 根据动态层重要性更新分配。

## 实验设计与局限

### 已核验实验设计

论文使用五个数据集：

- CIFAR-100
- DomainNet-121
- LEDGAR
- Natural Instruction
- Dolly-15K

任务覆盖：

- 视觉分类
- 文本分类
- 指令微调

数据异构设置：

- IID
- Non-IID
- extreme Non-IID

资源异构：

- 模拟不同 resource capability / RoC 分布，例如 6:3:1 和 1:1:1。

### 局限与疑问

1. 方法主线是 LoRA layer allocation，不是个性化共享/私有结构。
2. 对客户端私有适配器、客户端个性化性能和尾部客户端收益的讨论不是核心。
3. 如果我们直接做“谁训练哪些 LoRA layer”，会和 Fed-HeLLo 太接近。
4. 它使用 proxy data 估计层重要性，这一点对真实隐私场景是否合适，需要继续思考。
5. 需要进一步精读实验表，判断它对 A100、RTX3060、手机等真实设备的描述到底出现在正文、附录还是用户理解中。

## 与 AdaFedLoRA-P 的关系

Fed-HeLLo 对我们非常重要，因为它已经覆盖了“资源异构客户端训练不同 LoRA 层”这个方向。

因此 AdaFedLoRA-P 不能只讲：

> 给不同设备分配不同 LoRA 层或不同训练负载。

我们的差异化应强调：

1. **Shared-private personalization**  
   我们将 LoRA 拆成共享 LoRA 和私有 LoRA，显式处理 Non-IID 下的个性化需求。

2. **Adaptive rank/resource allocation**  
   我们可以使用 rank 或上传预算作为资源分配对象，而不是主要做 layer allocation。

3. **Robust aggregation**  
   我们要说明如何降低异构更新和异常客户端对共享 LoRA 的干扰。

4. **Unified evaluation**  
   我们不仅看平均性能，还看个性化性能、尾部客户端、通信成本、资源预算和 Non-IID 强度。

## 可借鉴点

1. **资源能力分层设计**  
   可以借鉴 low/mid/high 或 RoC 分布来模拟资源异构客户端。

2. **层重要性思想**  
   如果后续扩展 layer-wise rank allocation，可以参考动态层重要性和固有层重要性。

3. **Non-IID 强度设置**  
   论文从 IID 到 extreme Non-IID 的评估方式适合我们设计差异性实验。

4. **写作叙事**  
   它清楚说明了与传统“同构 LoRA 训练”的区别，这点可用于我们解释与 FedAvg-LoRA、FLoRA、FlexLoRA 的差异。

## 不能直接照搬的点

1. 不应把 layer allocation 作为我们的唯一创新点。
2. 不应只用资源分层证明方法有效，还要证明个性化结构有效。
3. 不应完全依赖 proxy data 估计层重要性，否则会引入隐私和数据可得性问题。
4. 不应把多模态实验作为当前主线，三个月目标下仍以文本分类 + NLI 为主。

## 后续问题

1. Fed-HeLLo 的真实设备实验到底如何设置？是否有 A100、RTX3060、手机的硬件表？需要进一步精读 PDF。
2. FIM-HLA 的 proxy data 是否会造成隐私或公平性问题？
3. HLA 与 rank allocation 是否可以组合？例如不同客户端训练不同 rank，同时保留共享/私有 LoRA。
4. 如果我们加入稳健聚合，是否能比 Fed-HeLLo 更好处理 extreme Non-IID？
5. 它的五个数据集里 LEDGAR 是否适合作为我们 NLP 主实验或补充实验？

## 可引用证据

准备进入 `literature/evidence-ledger.csv` 的事实：

| claim | 原文位置 | 备注 |
| --- | --- | --- |
| Fed-HeLLo 提出 heterogeneous LoRA allocation，让不同客户端训练不同本地 LoRA 层。 | arXiv 摘要 | 可用于相关工作 |
| Fed-HeLLo 包含 FIM-HLA、GD-HLA、RGD-HLA 策略。 | arXiv 摘要与 HTML 方法部分 | 可用于方法对比 |
| Fed-HeLLo 在五个数据集上评估，覆盖 IID 到 extreme Non-IID。 | arXiv 摘要与 HTML 实验部分 | 可用于实验设计对比 |
| Fed-HeLLo 页面备注为 Accepted to TNNLS 2025。 | arXiv comments | 可用于文献状态记录 |

## 参考链接

- arXiv：https://arxiv.org/abs/2506.12213
- HTML：https://ar5iv.labs.arxiv.org/html/2506.12213v1
- 代码链接：https://github.com/TNI-playground/Fed_HeLLo

