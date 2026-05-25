# 长期存档和恢复策略

## 目标

保证项目在长期推进中可以恢复、回滚、审计和迁移，避免某次运行错误导致无法返回。

## 基本机制

1. Git 是主版本控制机制。
2. GitHub private 仓库作为远程备份。
3. 重要阶段使用 tag 标记。
4. 每次实验通过实验编号、配置、日志和结果文件追溯。
5. 大文件不进 git，通过说明文件记录来源和生成方式。

## Commit 策略

建议 commit 粒度：

- `initialize research project`
- `add literature review notes`
- `add baseline federated lora framework`
- `add adaptive rank method`
- `add experiment results for rq1`
- `draft manuscript sections`

每个 commit 应该能回答：

- 改了什么。
- 为什么改。
- 如何验证。

## Tag 策略

建议里程碑 tag：

- `v0.1-project-skeleton`
- `v0.2-literature-map`
- `v0.3-baselines-ready`
- `v0.4-method-mvp`
- `v0.5-main-results`
- `v0.9-submission-draft`
- `v1.0-submitted`

## Branch 策略

默认主分支：

```text
main
```

任务分支：

```text
codex/literature-review
codex/baseline-framework
codex/experiments
codex/manuscript
```

## 数据和模型存档

不提交：

- 原始大数据。
- 模型权重。
- checkpoint。
- cache。
- 临时日志。

必须提交：

- 数据来源说明。
- 下载脚本或链接。
- 预处理脚本。
- 小型配置文件。
- 可追溯结果汇总。

## 实验恢复

每个实验必须具备：

- 实验编号。
- 配置文件。
- 运行命令。
- git commit hash。
- 随机种子。
- 硬件信息。
- 结果路径。

如果结果无法通过这些信息复现，不允许进入论文正文。

## 故障恢复

如果误改文件：

1. 先运行 `git status --short`。
2. 用 `git diff` 查看改动。
3. 只恢复确认错误的文件。
4. 禁止使用 `git reset --hard`，除非用户明确要求。

如果实验结果损坏：

1. 保留损坏文件路径。
2. 在 `experiments/run-log.md` 标记失败。
3. 重新运行同一实验编号的修订版本，例如 `E20260525-01-rerun1`。

## 备份频率

- 每天工作结束至少 commit 一次。
- 每周 push 到 GitHub private 仓库。
- 关键实验完成后立即 tag。

