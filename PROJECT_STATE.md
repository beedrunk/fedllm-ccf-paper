# PROJECT_STATE

更新时间：2026-05-25

## 当前阶段

阶段 0 已完成：项目骨架、规则、约束和 3 个月计划已建立。

下一阶段：阶段 1，文献核验和环境核验。

## 当前工作目录

```text
D:\paper
```

## 当前研究主线

资源异构客户端下的自适应 Rank 个性化联邦 LoRA 微调。

暂定方法名：`AdaFedLoRA-P`。

## 用户已确认约束

- 目标：CCF C 类期刊。
- 语言：优先英文期刊。
- 周期：3 个月。
- 偏好：算法创新和实验完整性。
- 模型：开发阶段 1B 或更小；后期可租服务器补充实验。
- 数据：通用英文 NLP 数据集可作为主实验，教育数据作为补充实验。
- 主实验路线：通用英文文本分类 + NLI。
- 教育补充实验：学生答案/教育文本分类。
- 开源许可证：Apache-2.0。
- 联邦环境：接受模拟客户端。
- 开源：最终需要可开源；初期 GitHub 仓库设为 private。

## 已完成文件

- `README.md`
- `AGENTS.md`
- `PROJECT_STATE.md`
- `docs/no-fabrication-protocol.md`
- `docs/executable-plan-3months.md`
- `docs/project-constraints.md`
- `docs/open-questions.md`
- `docs/environment-check.md`
- `proposal/research-plan.md`
- `proposal/opening-report.md`
- `journal/ccf-targets.md`
- 文献、实验、结果、论文草稿相关模板。

## 当前未解决问题

1. 本地 GPU/CUDA 尚未核验。当前环境找不到 `nvidia-smi`。
2. GitHub private 仓库已创建，`git push` 已通过本仓库局部代理配置修复。API 上传历史已备份到远程分支 `api-upload-backup`。详见 `docs/github-sync.md`。
3. 目标 CCF C 英文期刊尚未核验。
4. 核心文献库尚未建立。
5. baseline 代码尚未开始。

## 下一步建议

1. 精读开题报告中列出的核心近两年 FedLoRA/FedLLM 文献，补充阅读笔记。
2. 核验 PyTorch CUDA 环境。
3. 跑通单客户端 LoRA baseline。
4. 根据文本分类 + NLI 主线确定第一批公开数据集候选。

## 恢复提示

如果未来 agent 从零接手，先运行：

```powershell
cd D:\paper
git status --short --branch
powershell -ExecutionPolicy Bypass -File scripts/check-project.ps1
```

然后阅读：

```text
AGENTS.md
PROJECT_STATE.md
docs/executable-plan-3months.md
```
