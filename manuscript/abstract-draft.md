# 摘要（初稿）

> 说明：本文为论文摘要的**初稿**，供毕业论文章节占位与导师讨论使用。
> 依据项目防编造协议，凡涉及实验结果的表述一律以占位符 `【】` 标出，待主要实验完成后回填，
> 不得在未做实验前填入手写数值。

---

## 中文摘要

大语言模型在文本分类、自然语言推理等自然语言处理任务上展现出较强的迁移能力，但对其进行全参数微调需要较高的显存、计算与存储开销。参数高效微调（Parameter-Efficient Fine-Tuning, PEFT）中的低秩适配（Low-Rank Adaptation, LoRA）通过冻结主干参数、仅训练低秩增量矩阵，显著降低了微调成本。与此同时，现实中的数据往往分散于不同机构、终端与用户侧，受隐私与合规约束无法集中，联邦学习允许各客户端在本地保留数据、仅上传模型更新，为大模型的分布式协作微调提供了可行框架。然而，将联邦学习与 LoRA 结合时仍面临两方面挑战：其一，客户端数据分布高度 Non-IID，统一的全局适配器难以兼顾不同客户端的个性化需求，甚至可能产生负迁移；其二，客户端计算与通信资源异构，统一的 LoRA rank 既会限制高资源客户端的表达能力，又会抬高低资源客户端的参与成本。

针对上述问题，本文提出一种面向资源异构客户端的个性化联邦 LoRA 微调方法 AdaFedLoRA-P（Adaptive Rank-aware Personalized Federated LoRA Fine-tuning）。该方法在冻结大模型主干的基础上，将 LoRA 适配器解耦为服务器端聚合的全局共享 LoRA 与客户端本地保留的私有 LoRA：共享部分学习跨客户端共性知识，私有部分保留本地数据分布特征。在此基础上，方法根据客户端的资源预算与近期训练收益进行自适应 rank 分配，使异构设备能够以差异化的参数规模共同参与训练；并在共享 LoRA 聚合过程中引入轻量稳健聚合机制（更新范数裁剪与基于相似度的异常更新降权），以降低 Non-IID 与异常客户端更新对共享适配器的干扰。此外，本文还对异构 LoRA 聚合偏差与资源分配目标进行了形式化描述，以增强方法的可解释性。

为验证方法有效性，本文以通用英文文本分类与自然语言推理任务为主实验，以学生答案/教育文本分类为补充实验，并与本地 LoRA、FedAvg-LoRA、个性化 LoRA 等多组基线进行对比，设计结构消融、rank 策略消融以及不同 Non-IID 强度与资源预算下的差异性实验，从平均性能、尾部客户端性能、个性化收益与通信成本等维度进行联合评估。【实验结果表明……：此处待主要实验完成后，回填平均准确率/宏 F1、尾部客户端性能、通信量等具体数值与显著性结论。】

**关键词**：联邦学习；大语言模型；参数高效微调；LoRA；个性化联邦学习；资源异构

---

## English Abstract

Large language models exhibit strong transferability across natural language processing tasks such as text classification and natural language inference, yet full-parameter fine-tuning entails substantial memory, computation, and storage overheads. Parameter-efficient fine-tuning (PEFT), and low-rank adaptation (LoRA) in particular, mitigates this cost by freezing the backbone and training only low-rank incremental matrices. Meanwhile, real-world data are often distributed across institutions, terminals, and users and cannot be centralized due to privacy and compliance constraints; federated learning enables collaborative model training by keeping data local and exchanging only model updates. However, combining federated learning with LoRA still faces two challenges: first, client data are highly non-IID, so a single global adapter struggles to meet diverse personalization needs and may even induce negative transfer; second, client compute and communication resources are heterogeneous, so a uniform LoRA rank either constrains the expressiveness of capable clients or raises the participation cost of weak clients.

To address these issues, this paper proposes AdaFedLoRA-P (Adaptive Rank-aware Personalized Federated LoRA Fine-tuning), a personalized federated LoRA fine-tuning method for resource-heterogeneous clients. With the LLM backbone frozen, the method decomposes the LoRA adapter into a global shared LoRA aggregated at the server and a private LoRA retained locally by each client: the shared part captures cross-client common knowledge while the private part preserves local data characteristics. It further performs resource-aware adaptive rank allocation based on each client's resource budget and recent training gain, enabling heterogeneous devices to participate at differentiated parameter scales, and incorporates lightweight robust aggregation (update-norm clipping and similarity-based down-weighting of anomalous updates) when combining shared updates to reduce interference from non-IID and anomalous clients. A formalization of heterogeneous-LoRA aggregation bias and the resource allocation objective is also provided.

The method is evaluated with general English text classification and natural language inference as the main experiments and student-answer/educational text classification as a supplementary experiment, and compared against baselines including local LoRA, FedAvg-LoRA, and personalized LoRA, together with structural ablations, rank-policy ablations, and sensitivity studies across non-IID degrees and resource budgets. Performance is assessed jointly along average performance, tail-client performance, personalization gain, and communication cost. [Experimental results and conclusions to be completed after the main experiments.]

**Keywords**: Federated Learning; Large Language Models; Parameter-Efficient Fine-Tuning; LoRA; Personalized Federated Learning; Resource Heterogeneity

---

## English Abstract（投稿压缩版，约 200 词，偏 Computer Networks 口径）

> 目标：CCF C 英文期刊投稿摘要。相比毕业论文版更紧凑，突出 resource allocation / communication cost / networked learning 表述。

Large language models (LLMs) are costly to fully fine-tune, and low-rank adaptation (LoRA) mitigates this by training only low-rank matrices on a frozen backbone. Yet training data are often scattered across institutions and devices that cannot be centralized for privacy and compliance reasons. Federated learning lets such clients collaboratively fine-tune an LLM by exchanging model updates instead of raw data. Two obstacles remain: client data are highly non-IID, so a single global adapter cannot meet heterogeneous personalization needs; and client resources differ, so a uniform LoRA rank either limits capable clients or prices out weak ones.

We propose AdaFedLoRA-P, a resource-aware personalized federated LoRA fine-tuning framework. It decouples each client's adapter into a server-aggregated shared LoRA and a locally retained private LoRA, jointly capturing common and personalized knowledge. A budget-aware rank allocator assigns each client a rank from its resource budget and recent training gain, so heterogeneous devices participate at differentiated communication costs, while robust aggregation (norm clipping and similarity-based down-weighting) suppresses interference from non-IID and anomalous updates. We also formalize the heterogeneous-LoRA aggregation bias and the resource-allocation objective.

Evaluated on English text classification and natural language inference, with educational text classification as a supplement, AdaFedLoRA-P is compared against local LoRA, FedAvg-LoRA, and personalized LoRA under varying non-IID degrees and resource budgets, jointly reporting accuracy, tail-client performance, personalization gain, and communication cost. [Results to be filled after experiments.]

**Keywords**: Federated Learning; Large Language Models; Parameter-Efficient Fine-Tuning; LoRA; Personalized Federated Learning; Resource Heterogeneity

---

## 回填清单（待实验后补充）

以下占位内容需在主要实验完成后填写，且必须对应 `experiments/run-log.md` 与 `results/` 中的可复现结果：

1. 主实验结果：文本分类（Accuracy / Macro-F1）与 NLI（Accuracy）在主要数据集上的具体数值，以及与各基线的对比。
2. 尾部客户端性能：最差 20% 客户端的性能提升幅度。
3. 通信成本：每轮上传参数量 / 总通信量的量化下降比例。
4. 消融与敏感性结论：共享/私有结构、自适应 rank、稳健聚合各模块的增益与 Non-IID（Dirichlet α）、资源预算变化下的稳定性结论。
5. 最终结论句：方法是否在相同通信预算下优于基线、在相近性能下降低通信成本，是否支持初始研究假设。
