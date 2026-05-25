# GitHub 同步状态

更新时间：2026-05-25

## 远程仓库

```text
https://github.com/beedrunk/fedllm-ccf-paper
```

状态：

- Visibility：PRIVATE
- Default branch：main
- 初始文件已上传。
- 远程 tag：`v0.1-project-skeleton`

## 当前上传方式

本地 `git push` 通过 HTTPS 多次失败：

```text
Recv failure: Connection was reset
Failed to connect to github.com port 443
```

因此初始文件通过 GitHub Contents API 上传。

## 风险

本地仓库有一个初始 commit：

```text
b4e447b initialize FedLLM paper project
```

远程仓库由于使用 Contents API 逐文件上传，远程 commit 历史和本地 commit 历史不完全一致。

这不影响当前文件备份，但会影响后续直接 `git push`。

## 后续处理建议

优先解决网络或 git 传输问题，然后选择一种同步策略：

1. 若可以重新创建远程仓库：删除远程仓库后，用正常 `git push -u origin main` 推送本地历史。
2. 若保留当前远程仓库：先备份本地，再通过 `git fetch`/`git pull --allow-unrelated-histories` 对齐历史。
3. 若 git 传输长期不可用：继续用 GitHub API 做文件级同步，但这只适合早期文档阶段，不适合后续代码开发。

建议在进入代码开发前解决该问题。

