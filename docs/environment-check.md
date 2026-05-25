# 环境检查

## 2026-05-25

工作目录：`D:\paper`

已执行：

```powershell
nvidia-smi
```

结果：

```text
nvidia-smi : The term 'nvidia-smi' is not recognized
```

已检查常见路径：

```text
C:\Windows\System32\nvidia-smi.exe
C:\Program Files\NVIDIA Corporation\NVSMI\nvidia-smi.exe
```

结果：未找到。

结论：

当前不能确认 GPU 型号、显存、CUDA 版本和驱动版本。第一周任务必须先解决环境核验，否则 1B 模型实验计划存在风险。

下一步：

1. 确认是否已安装 NVIDIA 驱动。
2. 确认 PyTorch 是否能识别 CUDA。
3. 若 GPU 不可用，先使用 0.5B 或更小模型跑通 CPU/GPU 混合流程，再决定是否调整论文实验规模。

