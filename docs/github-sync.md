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

当前用户已确认：后续优先解决 `git push` 网络问题。

优先解决网络或 git 传输问题，然后选择一种同步策略：

1. 若可以重新创建远程仓库：删除远程仓库后，用正常 `git push -u origin main` 推送本地历史。
2. 若保留当前远程仓库：先备份本地，再通过 `git fetch`/`git pull --allow-unrelated-histories` 对齐历史。
3. 若 git 传输长期不可用：继续用 GitHub API 做文件级同步，但这只适合早期文档阶段，不适合后续代码开发。

建议在进入代码开发前解决该问题。

## 2026-05-25 追加诊断

已确认：

- `gh auth status` 正常，账号为 `beedrunk`。
- `api.github.com:443` 可连。
- `github.com:443` 对命令行连接超时。
- `git ls-remote https://github.com/beedrunk/fedllm-ccf-paper.git` 失败。
- `ssh git@github.com` 的 22 端口连接被重置。
- `ssh -p 443 git@ssh.github.com` 连接被重置。
- 未发现 WinHTTP 代理配置。

当前判断：

问题优先级不是 GitHub 权限，而是命令行到 GitHub Git/SSH 入口的网络连通性。

下一步候选：

1. 检查系统代理、浏览器代理、VPN 或安全软件是否只对浏览器生效。
2. 尝试为 Git 配置与浏览器一致的代理。
3. 若有可用代理，配置 `git config --global http.proxy` 和 `git config --global https.proxy`。
4. 若网络恢复，重新创建远程仓库或对齐本地/远程历史后使用正常 `git push`。

## 2026-05-25 修复记录

发现 Windows 用户代理配置：

```text
127.0.0.1:7897
```

使用该代理后：

```powershell
git -c http.proxy=http://127.0.0.1:7897 -c https.proxy=http://127.0.0.1:7897 ls-remote https://github.com/beedrunk/fedllm-ccf-paper.git
```

可以正常访问远程仓库。

已在本仓库局部 Git 配置中设置：

```powershell
git config --local http.proxy http://127.0.0.1:7897
git config --local https.proxy http://127.0.0.1:7897
```

该设置只影响 `D:\paper` 仓库，不修改全局 Git 配置。
