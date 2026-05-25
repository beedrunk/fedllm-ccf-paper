# 文献检索日志

## 记录模板

```text
日期：
检索人：
数据库：
检索式：
时间范围：
筛选标准：
排除标准：
初筛数量：
精读候选：
备注：
```

## 检索记录

### 2026-05-25：开题报告第一轮文献核验

检索人：Codex

数据库/来源：
- arXiv
- NeurIPS Proceedings
- OpenReview
- ACL Anthology
- ICLR 页面
- Google Research publication page
- ScienceDirect
- Springer/Elsevier/出版社页面

检索式：
- `LoRA Low-Rank Adaptation Large Language Models ICLR 2022`
- `QLoRA Efficient Finetuning of Quantized LLMs NeurIPS 2023`
- `FLoRA Federated Fine-Tuning Large Language Models heterogeneous low-rank adaptations`
- `FlexLoRA Federated Fine-tuning of Large Language Models heterogeneous tasks client resources`
- `FSLoRA Federated Sketching LoRA On-Device Collaborative Fine-Tuning`
- `AFLoRA Adaptive Federated Fine-Tuning Large Language Models Resource-Aware Low-Rank Adaptation`
- `FedIT federated instruction tuning large language models`
- `FedAvg Communication-Efficient Learning of Deep Networks from Decentralized Data`
- `GLUE benchmark ICLR 2019`
- `MultiNLI NAACL 2018`
- `SST Stanford Sentiment Treebank EMNLP 2013`
- `SemEval 2013 Task 7 student response analysis`

筛选标准：
- 有 arXiv、OpenReview、NeurIPS、ACL、出版社或官方项目信息页面。
- 与 PEFT、LoRA、联邦微调、资源异构、个性化或实验数据集直接相关。
- 优先近两年 FedLLM/LoRA 联邦微调文献。

排除标准：
- 只来自博客且没有原始论文链接。
- 不能核验标题、作者、年份或来源。
- 与当前主线无直接关系。

备注：
- 当前只是开题阶段的第一轮核验；部分文献尚未精读全文，不能在论文正文中写成强结论。
- 用户提供的 YOLO-Adapter 论文已核验为 Neurocomputing 2026 文章，可作为“导师写作套路和 PEFT 动机表达”的参考，不作为本文技术基线。

### 2026-05-25：导师反馈后补充检索

检索人：Codex

数据库/来源：
- arXiv
- ACL Anthology
- ScienceDirect
- CCF 官方推荐目录入口

检索式：
- `FedHL federated learning heterogeneous LoRA`
- `FedEx-LoRA Exact Aggregation federated LoRA`
- `EcoLoRA communication efficient federated fine tuning LLM`
- `Computer Networks journal aims and scope`
- `Journal of Network and Computer Applications aims and scope`
- `Neurocomputing journal aims and scope`

筛选标准：
- 与聚合偏差、异构 LoRA、通信高效联邦微调或期刊定位直接相关。
- 只记录能打开到 arXiv、ACL Anthology、ScienceDirect 或 CCF 官方目录入口的来源。

备注：
- 用户提到 `ECLoRA`，当前检索到最接近的是 `EcoLoRA`。在未进一步确认前，不把 `ECLoRA` 和 `EcoLoRA` 写成同一工作。
- Computer Networks、JNCA、Neurocomputing 的最终 CCF 类别必须投稿前复核。
