# 文献阅读过程归档

本目录用于长期记录文献阅读、理解修正和选题思考过程。

它不替代：

- `literature/evidence-ledger.csv`：正式证据台账。
- `literature/reading-notes-template.md`：单篇论文精读模板。
- `manuscript/`：论文正文草稿。

## 记录目标

每篇阅读日志必须区分三类内容：

1. **原文事实**：论文明确写出的标题、方法、实验设置和结论。
2. **我的理解**：阅读者对论文的初始概括、直觉和疑问。
3. **项目启发**：该论文对 AdaFedLoRA-P 的方法、实验或写作叙事有什么影响。

## 命名规则

```text
NNN-short-paper-name.md
```

示例：

```text
001-fed-hello-heterogeneous-lora-allocation.md
```

## 推荐结构

```markdown
# NNN - Paper Short Name

## 基本信息
## 一句话总结
## 我的初始理解
## 对我的理解的校正
## 论文真正解决的问题
## 方法拆解
## 实验设计与局限
## 与 AdaFedLoRA-P 的关系
## 可借鉴点
## 不能直接照搬的点
## 后续问题
## 可引用证据
## 参考链接
```

## 写作规则

- 不把未经核验的理解写成论文事实。
- 不把阅读日志中的判断直接搬入论文正文。
- 可引用事实必须同步进入 `literature/evidence-ledger.csv`。
- 对不确定内容明确标注“待核验”。
- 保留错误理解和修正过程，因为这有助于长期复盘。

