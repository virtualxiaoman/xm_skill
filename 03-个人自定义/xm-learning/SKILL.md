---
name: xm-learning
description: 将学习材料或指定主题制作成学习、测验与答案复习网站；也用于按既有章节生成或改进题库与解析。组合下面2个skill： `xm-note` 的讲解风格与 `xm-web` 的视觉和 Markdown 规范，重点保证题目自包含、解析完整、来源可追溯。
---

# xm-learning

**目标：** Study 使读者理解概念背后的问题、机制和计算；Testing 检验读者能否独立推理与迁移；Answers 即使脱离 Study，也能从必要前提出发重建答案。**可核验的正确性优先于覆盖率，实质有效的解释优先于篇幅。**

## 先读什么

- 编写讲解前，读取同级 [xm-note/SKILL.md](../xm-note/SKILL.md)，重点参照其中“知识点讲解的示例”和“公式介绍的示例”：用具体对象、符号、推导与例子讲清机制。保留连贯叙述，疑问式标题按需使用。
- 编写或修改题目、解析前，完整读取 [题目与解析示例](references/assessment-examples.md)。参照其信息完整度和推理深度，题型、篇幅按实际内容调整。
- 建站或改界面前，读取同级 [xm-web/SKILL.md](../xm-web/SKILL.md) 及 [组合与网站约定](references/skill-composition.md)，再按约定读取适用的实现规范。内容任务仅应用相关部分。
- 所列路径不存在时，在已配置的技能目录中按名称查找对应技能。如果确实不存在，则询问用户是否从 [GitHub](https://github.com/virtualxiaoman/xm_skill) 拉取所需技能。

## 读者画像
以**用户是第一次系统学习该主题，具备较好的计算机与数学基础的研究生，有着较好的机器学习和深度学习的理论基础，乐于深入学习新知识**为默认。因此讲解的时候你可以尽量深入到具体细节、扩展到前沿理论，不必担心读者的水平不足。遇到难点时可以详细讲解。

## 确定内容与依据

采用用户指定的主题、水平、章节、版本和来源限制。未指定水平时，默认刚接触目标主题，交代必要前置知识；主题明确即可开始。有材料时保留其章节与范围；只有主题时，依据调研组织前置知识到应用的学习路径，标明为综合设计。

生成或实质性修改教学内容时，默认调研并实际阅读高质量公开来源；纯界面修改、格式调整和维护本 skill 无需学科调研。实现行为优先查官方文档、规范与源码，理论优先查原始论文、开放教材与大学课程。遵守禁止联网或仅限指定来源的要求；无法核验时披露限制，排除依据不足的题目。

用简明来源记录关联知识点与题目：来源 ID、标题、URL/路径、准确章节/页码/代码符号、已知日期、访问日期及适用版本。决定答案的规则须有已检查的证据或可复核的推导；搜索摘要和泛泛的章节链接不足以支撑答案。区分来源事实、实际观察、推导及原创教学情境。解决影响答案的版本冲突，标注外部补充，使用原创题目。

为章节与知识点建立稳定 ID，记录前置关系、学习目标、重点与易混淆处；有代码时关联实现位置。按理解难度和重要性分配讲解与练习，优先考查机制、比较和迁移。客观题为主，少量简答；材料支持时加入比较与代码推演题，不设固定题型比例或动画配额。

## 学习讲解内容的要求
### 讲解深度要求
对每个**重要**知识点，尽可能从以下层次逐步展开：

| 检查项 | 可观察的最低达标证据 | 不合格示例 |
| --- | --- | --- |
| 问题与动机 | 描述一个具体待解决问题、原有方案的具体限制，以及新设计针对限制改变了什么 | “为提高性能而提出……” |
| 内部机制 | 明确输入、关键变量、逐步变换／执行条件、输出；读者能按步骤复述算法或数据流 | “模型通过训练学会……” |
| 形式化与推导 | **主题涉及数学时**给出目标／公式、逐个解释符号、说明成立前提，并展开决定结论的非平凡变换；不涉及数学的主题使用等价的状态变化、协议或代码逻辑 | 只贴最终公式，不解释其计算对象 |
| 可核验实例 | 给出具体输入、关键中间状态／数值及输出；按本知识点机制完成计算、代码追踪或流程推演。可复用跨知识点实例，但必须写明本点对应的步骤 | 只说“例如可以用于分类” |
| 知识联系 | 至少解释一个前置／替代／后续方案与本方法的**机制差异**及实际后果，而不只是并列罗列名称 | “还可使用 A、B、C” |
| 边界与反例 | 说明至少一个必要假设、失效情境或有区分力的反例，并指出其对结论的影响 | “存在一定局限性” |

**具体例子：**出现“提高了性能／增强了能力／学习到了规律／优化了结果／能够适应任务”等结论，必须继续回答至少一个具体问题：**优化了哪个可计算量？改变了哪个参数或中间表示？通过什么数据和梯度／状态转移实现？在什么假设下可得出这个结论？** 若无法给出可验证的机制或证据，删除笼统结论或明确写为待验证假设。
### 内容质量要求
- **深度优先于篇幅**：讲解必须能带来新的机制、推导、例子、比较或洞察。
- **解释优先于罗列**：不要写成百科词条集合。应建立知识之间清晰的因果关系和逻辑递进。
- **具体优先于抽象**：出现“模型学会了”“能够优化”“提高性能”等表述时，应尽可能继续解释其背后的计算机制，不能只是浅浅地谈论现象而没有具体理论。
- **原理优先于类比**：技术解释可以用类比、直觉作为辅助工具帮助读者理解，但不能用类比代替技术解释。
- **严谨优先于流畅**：明确区分必要条件、充分条件、经验规律、工程实践与理论假设。
- **扩展必须有价值**：优先扩展能够帮助理解当前知识的理论，不为了显得全面而引入不相关概念。
- **避免知识断层**：新引入重要概念时，解释其定义及其在当前问题中的作用。
- **避免过早总结**：不要在刚介绍几个术语后就结束讲解。关键机制必须真正展开。
### 讲解组织方式
采用教材或技术专著的叙述风格，以连贯的段落构建论证过程。
建议遵循：
**问题提出 → 设计动机 → 核心思想 → 形式化描述 → 内部机制 → 具体计算 → 方法对比 → 局限与扩展**
标题只用于区分真正不同的讨论阶段，避免大量碎片化的小标题与浅层列表。
对于核心知识，宁可深入分析少数关键问题，也不要平均地介绍大量术语。
数学表达使用 LaTeX，代码使用 Python 或 PyTorch。代码可以查找原知识文档、原始论文、github上的官方实现，如果没有时可以自行完成。必要时通过表格比较不同方法。
### 深度自检
在输出前检查：
1. 是否真正回答了“为什么”，而不只是“是什么”？
2. 是否说明了技术内部具体如何计算或执行？
3. 是否包含足够具体、可以验证的实例？
4. 是否解释了关键公式背后的意义？
5. 是否建立了与相关知识的联系？
6. 是否讨论了该方法的局限、假设或替代方案？
7. 是否存在大量正确但信息密度低的套话？
如果某个核心知识点仅有定义、用途和简单例子，就应进一步深入，而不是直接进入下一个知识点。
### 讲解风格
可以参照 xm-note 这个skill。
### 讲解示例
普通讲解会说：“SFT 是一种有监督的模型微调方法，使用高质量指令数据，使预训练模型能够更准确地理解并执行人类指令。”但这几乎没有增加知识。真正有深度的讲解至少应该进一步回答：
**SFT 如何在数学上促使模型遵循指令？**
首先需要把指令和回答构成训练序列。假设指令为 $x$，参考回答为 $y=(y_1,\ldots,y_T)$，那么常见的回答部分 SFT 目标是：
$$
\mathcal L_{\mathrm{SFT}}(\theta) =-\mathbb E_{(x,y)\sim\mathcal D} \left[\sum_{t=1}^{T}\log\pi_\theta(y_t\mid x,y_{\<t})\right]
$$
必须解释 $\mathcal D,\theta,\pi_\theta,y_{<t}$ 的含义，以及为什么这一式子来自自回归条件概率分解。进一步展示如何把指令和回答拼接为 token 序列、怎样右移标签、Teacher Forcing 时每一步实际输入什么、回答损失掩码如何生效。
于是可以继续追问：
-   为什么最小化 NLL 能够学习指令与回答之间的映射？
-   Teacher Forcing 如何构造每一步的输入？
-   为什么通常只对 Assistant 的回答 token 计算损失？
-   如果参考回答具有多种合理表达，单一参考答案的交叉熵训练有什么限制？
-   SFT 能否真正提高推理能力，还是主要改变模型输出行为？
-   为什么经过 SFT 后，还可能需要 DPO、PPO 或 GRPO？
这里只给出了可以扩展的方向，实际你在讲解知识点的时候，在提出追问后应当同时完成回答，以让读者思考后参考你的回答进行深入理解。




## 教学绘图

- Mermaid 仅用于少量节点、关系清楚的简单流程。

- 多层架构、分组对比、多路径数据流等复杂示意图，调用 [drawio Skill](../../02-软件使用/绘图与内容制作/drawio/SKILL.md) 绘制。按其约定在当前项目的 `assets/drawio/` 保留 `.drawio` 和 `.png`，在讲解或解析中引用导出的 PNG。

可以绘制包括但不限于以下12种类型的图片：
| 图片类型                                     | 主要作用           | 深度学习中的典型应用                         |
| ---------------------------------------- | -------------- | ---------------------------------- |
| **1. 架构图（Architecture Diagram）**         | 展示系统的组成和模块连接   | Transformer、ResNet、MoE 架构          |
| **2. 数据流图（Data Flow Diagram）**           | 展示数据如何传递、变换    | Q/K/V 计算、反向传播、张量流                  |
| **3. 时序图（Sequence Diagram）**             | 展示不同参与者之间的交互顺序 | Agent 工具调用、RLHF 训练过程               |
| **4. 层次结构图（Hierarchy Diagram）**          | 展示上下级关系和分类     | AI/ML/DL 关系、模型分类体系                 |
| **5. 思维导图（Mind Map）**                    | 展示知识体系及其分支     | 强化学习知识体系、优化算法分类                    |
| **6. 概念关系图（Concept Map）**                | 展示不同概念间的关联     | Reward、Value、Advantage、Return      |
| **7. 对比图（Comparison Diagram）**           | 突出方法之间的异同      | PPO vs DPO vs GRPO、LoRA vs Full FT |
| **8. 矩阵图 / 热力图（Heatmap）**                | 展示矩阵结构及数值强弱    | Attention Matrix、Causal Mask       |
| **9. 函数曲线图（Function Plot）**              | 展示数学关系与变化趋势    | PPO Clip、Sigmoid、学习率调度             |
| **10. 几何示意图（Geometric Illustration）**    | 将抽象数学转化为空间直觉   | 梯度下降、向量投影、决策边界                     |
| **11. 分布图（Distribution Plot）**           | 展示数据和概率分布      | Logits、Softmax、量化误差分布              |
| **12. 分步演示图（Step-by-Step Illustration）** | 逐阶段拆解复杂计算      | GAE 计算、矩阵乘法、Attention 计算           |


## 命制知识点相关、扩展的有深度的题目

每题围绕明确的学习目标。难度来自对知识的应用，题面提供以下解题背景：

- **对象与任务：** 点明知识领域、具体情境和所求结果。引用某段实现时，说明它属于什么知识点、解决什么问题；文件路径或函数名只是补充定位。
- **定义与条件：** 逐题定义辅助术语、符号、变量和必要的 shape、初始值、约束、比较标准；索引、精度、环境或版本影响答案时须说明。随机抽题后仍能读懂，不依赖上一题或学习页的临时上下文。
- **实际代码：** 凡答案依赖实现，题面须有带语言标记的相关代码、输入及必要辅助定义。比较时展示双方；修复题展示待修代码与预期行为；不使用省略号隐藏关键步骤。标明原始/改编/原创示例及来源。
- **作答规则：** 说明单选、多选、计算、排序或诊断什么。单选有唯一答案，多选列全正确项；干扰项对应真实误区，长度与措辞不暗示答案。
- **选项个数**：不要求单选/多选题必须有且仅有四个选项，你可以根据不同的题目调整选项的个数。多选题允许只选2个也允许全选，不必局限正确选项的个数。
- **题目命制**：对于关键知识点，你可以利用一个背景出多个题目，比如一个背景出一个单选、一个多选（题目类型和数量不限）。

自包含允许声明学科前置知识，不要求把被考查的结论直接写在题面。区分“求解需要的背景”与“要由学习者推理的知识”：例如考查浅复制语义，应交代复制任务、完整代码和输入，把共享引用的机制留给作答与解析。

逐题离开 Study 阅读：目标学习者能否辨认考什么、每个量指什么、要做什么？若两种合理但未声明的假设导出不同答案，补条件或改题。学习链接不能补救缺失题面。

## 写能直接教会读者的解析

按“读者可能正因为没学懂才来查答案”编写。解析须在当前题内完成必要教学；Study 链接放在核心解释之后，作为延伸阅读。

1. 给出正确答案及具体含义。补讲决定本题的概念、规则与必要前提，重新定义解析中新增的符号；不能预设读者已理解学习页。
2. 把规则应用到本题数据，逐步走到结论。公式题展示计算和关键变形；机制题解释因果；代码题按执行顺序追踪重要语句、真实值、shape 或引用关系，指出输出或出错位置。
3. 选择题逐项说明成立或不成立的具体原因；判断题纠正错误陈述；匹配/排序题解释关系与依赖。避免用“根据定义”“其他都错”“回看知识点”代替论证。
4. 修复/补全题提供完整参考代码、修改理由和具体预期输出。如提供额外修复演示，清楚区分原题结果与修改后的结果。
5. 针对本题说明误区和适用边界；必要时加入小例子或反例。准确来源、Study 链接与进阶内容置后，理解核心答案不依赖它们。

解析深度以读者能否跟上并复核为准。简单题可用连贯短段落，复杂题保留充分推导；不机械套满标题，不截断正文，不用多题通用段落替代本题推理。复用 Study 的基础解释时，仍须完成本题的数据代入、步骤和选项分析。

## 命题与解析示例

以 SFT 中的标签对齐、损失掩码与梯度传播 为例：

- **知识领域：** 深度学习 / 大语言模型 / 监督微调（SFT）
- **题型：** 多选题 + 数值计算 + 数学推导 + 代码诊断
- **考查知识点：** 自回归语言建模、Next-token Prediction、Teacher Forcing、Cross Entropy、Loss Masking、梯度反向传播、EOS 学习机制。

### 一、题目

#### 1. 题目共用内容

在 Decoder-only Transformer 的监督微调（Supervised Fine-Tuning, SFT）中，通常将用户输入 Prompt 与 Assistant 的参考回答拼接成一个 Token 序列，并通过 Causal Language Modeling 目标进行训练。现有一条经过 Tokenization 的训练样本：

$$
X=[\mathrm{BOS},Q,A,B,\mathrm{EOS},\mathrm{PAD}]
$$

其中：

- `BOS`：序列起始标记。
- `Q`：用户输入的 Prompt，简化为一个 Token。
- `A, B`：Assistant 参考回答的两个 Token。
- `EOS`：Assistant 回答结束标记。
- `PAD`：用于批处理的填充 Token

词表大小为 $V=6$，上述 Token 的 ID 依次为 $0,1,2,3,4,5$。在本题中，只有 Assistant 回答及其结束标记参与 SFT 损失计算，即目标 Token 为：

$$
Y=[A,B,\mathrm{EOS}]
$$

假设模型采用标准的 Causal Attention。在位置 $t$，模型只能访问位置 $0,\ldots,t$ 的输入，并输出用于预测位置 $t+1$ 的概率分布。一次前向传播后，模型对真实下一个 Token 给出的概率如下：

| 预测位置 $t$ | 已输入序列（截至 $t$） | 真实下一个 Token | 预测概率 |
| ------------ | ----------------- | ----------- | ---- |
| 0 | BOS | Q | 0.80 |
| 1 | BOS, Q | A | 0.50 |
| 2 | BOS, Q, A | B | 0.25 |
| 3 | BOS, Q, A, B | EOS | 0.50 |
| 4 | BOS, Q, A, B, EOS | PAD | 0.90 |

采用自然对数的 Token-level Cross Entropy，设置：

```python
ignore_index = -100
reduction = "mean"
```

不使用 Label Smoothing、类别权重或其他辅助损失。损失只对未忽略的目标 Token 求平均。

#### 2. 问题一：多选题

**以下哪些陈述是正确的？**

- **A.** 正确的 SFT Loss 为 $\mathcal L_{\mathrm{SFT}}=\frac{4\ln2}{3}\approx0.9242$。
- **B.** 由于 Prompt Token `Q` 没有直接参与 Loss 计算，因此 `Q` 的输入 Embedding 在反向传播时梯度必然为 0。
- **C.** 在计算 `B` 的预测概率时，Teacher Forcing 使用真实的 `A` 作为上下文，而不是模型在上一步生成的 Token。
- **D.** 若使用位置 $t$ 的 Logits 预测位置 $t$ 的 Token，可能导致训练目标直接暴露在模型输入中。
- **E.** 若训练时忽略 EOS 的 Loss，则模型在推理阶段必然永远无法生成 EOS。

#### 3. 问题二：数值计算与梯度推导

设模型在位置 $t$ 输出的 Logits 为：

$$
\mathbf z^{(t)}\in\mathbb R^V
$$

通过 Softmax 得到预测概率：

$$
p_\theta(j\mid x_{\le t}) =\frac{\exp(z_j^{(t)})}{\sum_{k=1}^{V}\exp(z_k^{(t)})}
$$

请完成：

1. 写出正确的 SFT Loss，计算其数值，并解释分母为什么不是 5 或 6。
2. 推导在预测 Token `B` 时，平均损失对正确类别 Logit $z_B^{(2)}$ 的梯度。
3. 说明为什么 `Q` 不参与直接监督损失，却仍然可能获得非零的 Embedding 梯度。

#### 4. 问题三：代码诊断

现有如下完整的最小化 PyTorch 示例。为了使计算可复现，代码直接构造与题目概率表一致的 Logits，而不是调用一个随机初始化的模型。在每个预测位置，除真实下一个 Token 外，其余五类共享剩余概率。

```python
import math
import torch
import torch.nn.functional as F

input_ids = torch.tensor([[0, 1, 2, 3, 4, 5]])
V = 6
probs = [0.80, 0.50, 0.25, 0.50, 0.90]

# logits: [batch_size=1, seq_len=6, vocab_size=6]
logits = torch.zeros((1, 6, V), dtype=torch.float64)

for t, p in enumerate(probs):
    logits[0, t, :] = math.log((1 - p) / (V - 1))
    target_id = int(input_ids[0, t + 1])
    logits[0, t, target_id] = math.log(p)

labels = input_ids.clone()
labels[:, :2] = -100
labels[:, -1] = -100

loss = F.cross_entropy(
    logits[:, :-1, :].reshape(-1, V),
    labels[:, :-1].reshape(-1),
    ignore_index=-100,
)

print(loss.item())
```

请回答：

1. 该代码能否正确计算期望的 SFT Loss？如果不能，指出错误的具体位置。
2. 给出最小修改后的正确代码。
3. 分析错误实现为什么可能仍然得到一个正常的浮点数 Loss，却没有正确实现 Next-token Prediction。

### 二、答案与解析

#### 1. 多选题答案

A,C,D

| 选项 | 判断 | 核心依据 |
| -- | -- | ------------------------------------ |
| A | 正确 | 三个有效监督 Token 的平均 NLL 为 $4\ln2/3$ |
| B | 错误 | Loss Masking 不会切断 Prompt 到后续预测的梯度传播 |
| C | 正确 | Teacher Forcing 使用真实历史 Token 构造训练上下文 |
| D | 正确 | 预测当前位置的 Token 可能发生目标泄露 |
| E | 错误 | 忽略某个样本的 EOS 监督不代表模型无法生成 EOS |

#### 2. 为什么要进行标签右移？

理解这道题，首先必须区分两个对象：

- **输入 Token**：已经提供给模型、参与当前隐藏状态计算的 Token。
- **目标 Token**：当前隐藏状态对应的预测目标，位于输入位置的下一个位置。

对于自回归语言模型，联合概率可以根据链式法则分解为：

$$
p_\theta(x_1,\ldots,x_T) =\prod_{t=1}^{T}p_\theta(x_t\mid x_{\<t})
$$

这意味着模型在预测 $x_t$ 时，不能直接将 $x_t$ 作为当前预测位置可见的输入，否则训练目标已经泄露。

##### 2.1 本题的标签对齐关系

| 输入位置 | 输入 Token | 预测目标 | 是否计算 Loss |
| ---- | -------- | ---- | --------- |
| 0 | BOS | Q | 否 |
| 1 | Q | A | 是 |
| 2 | A | B | 是 |
| 3 | B | EOS | 是 |
| 4 | EOS | PAD | 否 |
| 5 | PAD | 无 | 否 |

例如，模型在读取 `BOS, Q, A` 后预测 `B`，而不是在已经读取 `B` 后再预测 `B`。

如果输入序列为：

$$
X=[x_0,x_1,\ldots,x_5]
$$

模型输出的 Logits 是：

$$
Z\in\mathbb R^{6\times V}
$$

那么手动计算 Next-token Loss 时，应该使用：

$$
Z_{0:5}\longleftrightarrow X_{1:6}
$$

对应代码为：

```python
shift_logits = logits[:, :-1, :]
shift_labels = labels[:, 1:]
```

这是标签右移的数学本质：**让每一步的预测目标严格位于模型当前可见前缀之外。**

##### 2.2 为什么同位置预测会出现问题？

假设模型通过 Transformer 计算位置 $t$ 的隐藏状态：

$$
h_t=f_\theta(x_{\le t})
$$

并将其映射为 Logits：

$$
z_t=Wh_t
$$

由于当前位置的输入 $x_t$ 已经进入隐藏状态计算，如果使用 $z_t$ 预测 $x_t$，模型就可能利用当前 Token 自身的信息完成预测。

训练目标变成：

$$
p_\theta(x_t\mid x_{\le t})
$$

而实际需要的是：

$$
p_\theta(x_{t+1}\mid x_{\le t})
$$

二者的条件信息不同。前者包含待预测的 Token 自身，后者不包含。因此，同位置监督不仅是索引错误，还会改变整个学习问题的定义。

**结论：选项 D 正确。**

#### 3. 正确 SFT Loss 的计算

对于本题，回答部分的平均负对数似然损失为：

$$
\mathcal L_{\mathrm{SFT}} =-\frac1N\sum_{t\in\mathcal I} \log p_\theta(x_{t+1}\mid x_{\le t})
$$

其中：

- $\mathcal I=\\{1,2,3\\}$：参与监督的预测位置集合。
- $N=|\mathcal I|=3$：有效监督 Token 数量。
- $p_\theta$：模型计算的条件概率分布。

三个有效预测分别为：

$$
p_\theta(A\mid\mathrm{BOS},Q)=0.5
$$

$$
p_\theta(B\mid\mathrm{BOS},Q,A)=0.25
$$

$$
p_\theta(\mathrm{EOS}\mid\mathrm{BOS},Q,A,B)=0.5
$$

因此：

$$
\begin{aligned} \mathcal L_{\mathrm{SFT}} &=-\frac13(\ln0.5+\ln0.25+\ln0.5)\\\ &=-\frac13(-\ln2-2\ln2-\ln2)\\\ &=\boxed{\frac{4\ln2}{3}\approx0.9242} \end{aligned}
$$

##### 3.1 为什么分母是 3，而不是 5 或 6？

因为 `CrossEntropyLoss` 在默认 `reduction="mean"`、没有类别权重时，只对未被 `ignore_index` 忽略的目标求平均。这里虽然有 6 个输入 Token，但只有 `A`、`B` 和 `EOS` 三个 Token 参与监督。因此分母为 3。

一个重要细节是：**Loss 的数值大小不能脱离归一化方式进行比较。**假设忽略 EOS 的 Loss，那么监督目标只剩 `A` 和 `B`：

$$
\begin{aligned} \mathcal L' &=-\frac{\ln0.5+\ln0.25}{2}\\\ &=\frac{3\ln2}{2}\\\ &\approx1.0397 \end{aligned}
$$

它比原来的 $0.9242$ 更大，但不能据此断言模型变差，因为两次计算的监督集合和归一化分母不同。

**结论：选项 A 正确。**

#### 4. Teacher Forcing 究竟改变了什么？

在预测 `B` 时，题目规定模型已经读取真实的 `A`：

$$
p_\theta(B\mid\mathrm{BOS},Q,A)=0.25
$$

即使模型在上一步预测 `A` 的概率只有 $0.5$，它仍然使用参考答案中的真实 `A` 作为后续训练上下文。这就是 Teacher Forcing。它带来一个重要的训练与推理差异：

| 阶段 | 预测下一个 Token 使用的上下文 |
| ------ | ------------------ |
| SFT 训练 | 数据集中真实的历史 Token |
| 自回归推理 | 模型自身已经生成的历史 Token |

##### 4.1 为什么训练时使用真实历史 Token？

假设参考回答是：

$$
Y=[A,B,\mathrm{EOS}]
$$

模型需要学习：

$$
p_\theta(Y\mid Q) = p_\theta(A\mid Q) p_\theta(B\mid Q,A) p_\theta(\mathrm{EOS}\mid Q,A,B)
$$

这里为简洁省略了 BOS。

如果每一步都使用模型实际生成的 Token，就可能出现以下情况：模型第一步没有生成 `A`，而是生成 `C`。接下来训练第二步时，模型面对的上下文就变成：

$$
[Q,C]
$$

此时如果仍然直接要求模型预测参考答案 `B`，训练的条件分布将不再是原先参考序列对应的：

$$
p_\theta(B\mid Q,A)
$$

而变成：

$$
p_\theta(B\mid Q,C)
$$

这改变了监督目标所对应的条件上下文。Teacher Forcing 使用参考答案前缀，使训练可以直接计算数据序列的条件似然，并通过一次并行的 Transformer 前向传播获得各位置的预测结果。

##### 4.2 为什么 Teacher Forcing 可能带来 Exposure Bias？

训练时，模型主要接触真实数据中的前缀：

$$
y_{\<t}\sim p_{\mathrm{data}}
$$

而推理时，模型接触的是自己已经生成的前缀：

$$
\hat y_{\<t}\sim p_\theta
$$

这两个前缀分布可能不同。模型在前几个位置出现错误后，后续就可能进入训练数据中较少出现的上下文。这种训练与推理阶段前缀分布不一致的问题，与 Exposure Bias（暴露偏差）相关。

但是需要注意，不能简单得出“Teacher Forcing 一定导致严重错误累积”的结论。错误累积程度还受到模型准确率、数据分布和解码方式等因素影响。

**结论：选项 C 正确。**

#### 5. 为什么被 Mask 的 Prompt 仍然可以获得梯度？

这是本题最重要的机制问题之一。首先需要区分两个完全不同的操作：

- **Loss Masking**：决定哪些预测位置直接参与损失计算。
- **Attention Masking**：决定哪些输入位置可以被其他位置的注意力机制访问。

本题中，`Q` 对应的预测目标被 Mask，并不意味着 `Q` 被移出模型输入，更不意味着模型后续的隐藏状态无法依赖 `Q`。

##### 5.1 从计算图理解梯度传播

考虑一个简化模型：

$$
\mathbf h_1=f_\theta(\mathrm{BOS},Q)
$$

$$
\mathbf z^{(1)}=W\mathbf h_1
$$

$$
\mathbf p^{(1)}=\operatorname{softmax}(\mathbf z^{(1)})
$$

虽然位置 0 对 `Q` 的直接预测损失被忽略，但是位置 1 对 `A` 的预测依然依赖输入中的 `Q`。假设 `Q` 的输入 Embedding 为 $\mathbf e_Q$。总损失为：

$$
\mathcal L=\frac13(\ell_A+\ell_B+\ell_{\mathrm{EOS}})
$$

根据链式法则：

$$
\frac{\partial\mathcal L}{\partial\mathbf e_Q} = \frac13\left( \frac{\partial\ell_A}{\partial\mathbf e_Q} + \frac{\partial\ell_B}{\partial\mathbf e_Q} + \frac{\partial\ell_{\mathrm{EOS}}}{\partial\mathbf e_Q} \right)
$$

进一步展开：

$$
\frac{\partial\mathcal L}{\partial\mathbf e_Q} = \sum_{t\in\\{1,2,3\\}} \frac{\partial\mathcal L}{\partial\mathbf z^{(t)}} \frac{\partial\mathbf z^{(t)}}{\partial\mathbf e_Q}
$$

只要后续预测确实依赖 $\mathbf e_Q$，并且相关梯度没有恰好抵消或退化为零，Prompt Embedding 就可以得到非零梯度。

##### 5.2 从 Self-Attention 理解这一现象

Transformer 中的 Self-Attention 计算为：

$$
\operatorname{Attention}(Q,K,V) = \operatorname{softmax}\left( \frac{QK^\top}{\sqrt{d_k}}+M \right)V
$$

其中：

- $Q,K,V$：Query、Key、Value 矩阵。
- $d_k$：Key 向量的维度。
- $M$：注意力掩码矩阵。

需要注意，这里的 $M$ 是注意力掩码，不是 Loss Mask。例如，模型在预测 `B` 时，位置 2 的隐藏状态可以通过 Causal Self-Attention 访问 `BOS`、`Q` 和 `A`。因此：

$$
h_2=f_\theta(\mathrm{BOS},Q,A)
$$

由于 `Q` 参与了 $h_2$ 的计算，它也可能影响最终损失：

$$
\ell_B=-\log p_\theta(B\mid\mathrm{BOS},Q,A)
$$

反向传播时，梯度能够沿着模型的计算路径传回 `Q` 的输入 Embedding 以及相关模型参数。

**因此，Loss Masking 只阻止被忽略预测位置产生直接损失，并不切断其他有效监督位置经过该 Token 的计算图。**

##### 5.3 什么情况下 Prompt Embedding 的梯度可能为零？

尽管 Loss Masking 本身不会切断梯度，但以下情况可能使某个 Prompt Embedding 的梯度为零：

1. 相关输入参数被冻结，未参与梯度计算。
2. 计算图中存在 `detach()` 等显式截断梯度的操作。
3. 网络结构或注意力约束使该输入无法影响任何有效监督位置。
4. 局部导数为零，或者不同梯度贡献恰好抵消。

因此，“Prompt 不计算直接 Loss”与“Prompt Embedding 梯度为零”之间不存在必然关系。

**结论：选项 B 错误。**

#### 6. Softmax + Cross Entropy 的梯度推导

下面从数学上回答问题二的第二小问。

##### 6.1 从交叉熵定义开始

对于单个目标 Token $y$，交叉熵为：

$$
\ell=-\log p_y
$$

利用 Softmax 定义：

$$
p_y=\frac{e^{z_y}}{\sum_j e^{z_j}}
$$

可将交叉熵展开：

$$
\begin{aligned} \ell &=-\log\frac{e^{z_y}}{\sum_j e^{z_j}}\\\ &=-z_y+\log\sum_j e^{z_j} \end{aligned}
$$

##### 6.2 对 Logit 求导

对任意类别的 Logit $z_k$ 求偏导：

$$
\begin{aligned} \frac{\partial\ell}{\partial z_k} &= -\frac{\partial z_y}{\partial z_k} + \frac{\partial}{\partial z_k} \log\sum_j e^{z_j}\\\ &=-\mathbb1[k=y] +\frac{e^{z_k}}{\sum_j e^{z_j}}\\\ &=\boxed{p_k-\mathbb1[k=y]} \end{aligned}
$$

其中 $\mathbb1[k=y]$ 是指示函数，当 $k=y$ 时等于 1，否则为 0。这一公式说明：

- 对于正确类别 $k=y$，梯度为 $p_y-1$。
- 对于其他类别 $k\ne y$，梯度为 $p_k$。

##### 6.3 代入本题

本题使用三个有效 Token 的平均损失，因此在预测 `B` 的位置 $t=2$，对于正确类别 `B`：

$$
\frac{\partial\mathcal L}{\partial z_B^{(2)}} =\frac13(p_B-1)
$$

代入 $p_B=0.25$：

$$
\begin{aligned} \frac{\partial\mathcal L}{\partial z_B^{(2)}} &=\frac13(0.25-1)\\\ &=\boxed{-0.25} \end{aligned}
$$

##### 6.4 梯度的实际意义是什么？

梯度为负，表示进行梯度下降时，在其他因素不变的局部 Logit 层面上，正确类别的 Logit 有被提高的趋势。对于其他类别 $k\ne B$：

$$
\frac{\partial\mathcal L}{\partial z_k^{(2)}} =\frac{p_k}{3}>0
$$

因此它们的 Logit 有被降低的趋势。但需要区分：这是**损失对 Logits 的局部偏导数**，不意味着一次神经网络参数更新后，所有样本对应的 Logits 都一定按这些方向变化。因为神经网络的参数是共享的，不同训练位置产生的梯度会共同影响同一组参数。

进一步，根据链式法则：

$$
\frac{\partial\mathcal L}{\partial\theta} = \sum_t \frac{\partial\mathcal L}{\partial\mathbf z^{(t)}} \frac{\partial\mathbf z^{(t)}}{\partial\theta}
$$

真正被优化器更新的是模型参数 $\theta$，而不是作为中间输出的 Logits 本身。因此，正确的理解应当是：

**交叉熵通过 Logit 层面的梯度提供优化信号，再经由反向传播映射到整个网络的共享参数。**

#### 7. 代码诊断

原始代码的核心错误位于：

```python
labels[:, :-1].reshape(-1)
```

它让位置 $t$ 的 Logits 去预测位置 $t$ 的 Token，而不是 $t+1$。

##### 7.1 错误代码实际在预测什么？

原始标签为：

```text
labels = [-100, -100, A, B, EOS, -100]
```

原始代码使用：

```python
logits[:, :-1, :]
labels[:, :-1]
```

因此实际形成的监督关系是：

| Logits 位置 | 当前输入 Token | 错误预测目标 |
| --------- | ---------- | ------ |
| 0 | BOS | 忽略 |
| 1 | Q | 忽略 |
| 2 | A | A |
| 3 | B | B |
| 4 | EOS | EOS |

- 位置 2 原本应该预测 `B`，却被要求预测 `A`。
- 位置 3 原本应该预测 `EOS`，却被要求预测 `B`。
- 位置 4 原本应该预测 `PAD`，却被要求预测 `EOS`。

因此，模型并没有按照正确的 Next-token Prediction 目标进行训练。

##### 7.2 为什么错误代码仍然能输出正常的 Loss？

`cross_entropy` 不知道当前任务究竟是预测下一个 Token，还是预测当前 Token。它只接收两组张量：

- 一组形状为 $[N,V]$ 的 Logits。
- 一组形状为 $[N]$ 的类别标签。

只要张量形状和标签取值合法，它就能计算交叉熵。数学上，错误目标仍然对应一个合法的分类损失：

$$
\mathcal L_{\mathrm{wrong}} =-\frac13 \sum_{t=2}^{4} \log p_\theta(x_t\mid x_{\le t})
$$

但这不是期望的自回归语言建模目标。

##### 7.3 计算错误代码的 Loss

由于题目明确规定了每个位置的剩余概率在非目标类别间均分，因此可以算出错误代码的实际 Loss。

| Logits 位置 | 正确的下一个 Token | 错误监督标签 | 错误标签对应概率 |
| --------- | ------------ | ------ | --------------------- |
| 2 | B | A | $(1-0.25)/5=0.15$ |
| 3 | EOS | B | $(1-0.50)/5=0.10$ |
| 4 | PAD | EOS | $(1-0.90)/5=0.02$ |

于是：

$$
\begin{aligned} \mathcal L_{\mathrm{wrong}} &=-\frac{\ln0.15+\ln0.10+\ln0.02}{3}\\\ &\approx\boxed{2.7039} \end{aligned}
$$

对比正确 Loss：

$$
\mathcal L_{\mathrm{correct}}\approx0.9242
$$

这说明代码可以正常执行，返回有限的浮点数 Loss，却在优化错误的监督目标。

需要注意，错误 Loss 比正确 Loss 大并不是识别此类 Bug 的可靠依据。在其他概率分布下，错误实现也可能产生更小的 Loss。真正的验证方式是检查 **Logits 与 Labels 的语义对齐关系**。

#### 8. 修复后的完整 PyTorch 代码

```python
import math
import torch
import torch.nn.functional as F

# Token IDs:
# BOS=0, Q=1, A=2, B=3, EOS=4, PAD=5
input_ids = torch.tensor([[0, 1, 2, 3, 4, 5]])

V = 6
probs = [0.80, 0.50, 0.25, 0.50, 0.90]

# [batch_size=1, seq_len=6, vocab_size=6]
logits = torch.zeros((1, 6, V), dtype=torch.float64)

# 构造每个预测位置的完整概率分布
for t, p in enumerate(probs):
    other_prob = (1 - p) / (V - 1)

    logits[0, t, :] = math.log(other_prob)

    target_id = int(input_ids[0, t + 1])
    logits[0, t, target_id] = math.log(p)

# 允许计算 Logits 的梯度
logits.requires_grad_()

# 只监督 Assistant 回答及 EOS
labels = input_ids.clone()
labels[:, :2] = -100
labels[:, -1] = -100

# 错误实现：同位置预测
wrong_loss = F.cross_entropy(
    logits[:, :-1, :].reshape(-1, V),
    labels[:, :-1].reshape(-1),
    ignore_index=-100,
)

# 正确实现：预测下一个 Token
shift_logits = logits[:, :-1, :]
shift_labels = labels[:, 1:]

correct_loss = F.cross_entropy(
    shift_logits.reshape(-1, V),
    shift_labels.reshape(-1),
    ignore_index=-100,
)

# 计算正确目标对应的梯度
correct_loss.backward()

print("Wrong loss:", wrong_loss.item())
print("Correct loss:", correct_loss.item())

# 位置 2 预测 B，B 的 Token ID 为 3
print("dL/dz_B:", logits.grad[0, 2, 3].item())

# 被忽略的预测位置不产生直接梯度
print(
    "Masked row gradient:",
    logits.grad[0, 0].abs().max().item()
)
```

预期输出：

```text
Wrong loss: 2.703909361086387
Correct loss: 0.9241962407465939
dL/dz_B: -0.25
Masked row gradient: 0.0
```

最后一行表明：在这个直接构造 Logits 的示例中，位置 0 的被忽略预测没有梯度。但这不代表真实 Transformer 中作为输入的 Prompt Embedding 没有梯度。因为本示例没有建模从输入 Embedding 到后续 Logits 的前向计算关系，只将 Logits 作为独立的可求导张量。

实际 Transformer 中，后续位置的 Logits 可能依赖 Prompt Embedding，因此后者仍可能接收到反向传播的梯度。

##### 8.1 一个容易忽略的框架差异

上述代码直接调用：

```python
F.cross_entropy(...)
```

因此需要手动完成 Logits 与 Labels 的位置对齐。

但是在一些 Hugging Face 的 Causal Language Modeling 模型中，调用：

```python
outputs = model(
    input_ids=input_ids,
    labels=labels,
)
```

模型内部的损失计算可能已经完成了标签右移。因此不能简单地在所有模型接口外部重复执行：

```python
labels = labels[:, 1:]
```

否则可能发生重复位移或形状不匹配。应当以具体模型版本的 `forward` 和损失函数实现为准。

#### 9. EOS 为什么必须谨慎处理？

EOS 不仅是一个普通的监督标签，它还承担着序列结束标记的作用。

在自回归生成中，模型不断预测下一个 Token：

$$
y_t\sim p_\theta(\cdot\mid x,y_{\<t})
$$

当生成的 Token 满足停止条件时，推理过程结束。对于使用 EOS 作为终止标记的模型，EOS 的概率直接影响回答何时结束。

##### 9.1 如果忽略 EOS Loss，会发生什么？

本题原本包含：

$$
-\log p_\theta(\mathrm{EOS}\mid Q,A,B)
$$

这一监督项。

如果忽略 EOS，那么当前训练样本就不会直接鼓励模型在 `Q,A,B` 之后提高 EOS 的条件概率。

但是不能因此认为模型永远无法生成 EOS。因为模型可能已经通过预训练或其他 SFT 样本学习到了 EOS 的生成模式。所以：

$$
\text{忽略当前样本的 EOS Loss} \not\Rightarrow \text{模型无法生成 EOS}
$$

**结论：选项 E 错误。**

##### 9.2 EOS 与 PAD 的区别

EOS 与 PAD 在训练时的作用不同：

| Token | 主要用途 | 训练时的典型处理 |
| ----- | --------- | -------------------- |
| EOS | 标记回答结束 | 对 Assistant 回答通常保留监督 |
| PAD | 对齐不同长度的序列 | 通常忽略对应的目标 Loss |

特别需要注意，在某些模型配置中，`pad_token_id` 可能与 `eos_token_id` 相同。如果简单地根据 Token ID 屏蔽所有 EOS，就可能同时屏蔽真正的回答结束标记。

更稳妥的实现方式是根据实际序列长度、消息边界或预先构建的 Loss Mask 决定哪些位置参与监督，而不是不加区分地按 Token ID 删除所有 EOS 监督。

### 三、最终答案汇总

#### 多选题

$$
\boxed{\mathrm{A、C、D}}
$$

#### 数值结果

| 计算项目 | 结果 |
| ------------------------------------------- | -------------- |
| 正确 SFT Loss | $0.924196$ |
| 错误代码 Loss | $2.703909$ |
| 有效监督 Token 数量 | $3$ |
| $\partial\mathcal L/\partial z_B^{(2)}$ | $-0.25$ |

#### 代码修复

- 错误：`labels[:, :-1]`
- 正确：`labels[:, 1:]`

需要与 `logits[:, :-1, :]` 对应使用。

#### 核心结论

1. **Next-token Prediction**：位置 $t$ 的 Logits 应预测位置 $t+1$ 的 Token，必须保证条件上下文中不包含当前预测目标。
2. **Teacher Forcing**：训练时使用真实历史 Token，推理时通常使用模型自身生成的 Token，因此可能出现训练与推理的前缀分布差异。
3. **Loss Masking**：决定哪些预测位置产生直接损失，但不自动切断这些输入 Token 对后续预测的计算路径。
4. **梯度传播**：Softmax + Cross Entropy 对 Logits 的局部梯度为 $p_k-\mathbb1[k=y]$，平均损失还需要考虑有效监督 Token 数量。
5. **EOS 监督**：EOS 可以作为模型学习停止行为的监督信号，不能将忽略某个 EOS Loss 等同于模型无法生成 EOS。
6. **工程实现**：一个训练程序即使正常运行并持续降低 Loss，也不代表它实现了正确的优化目标。必须检查标签对齐、监督掩码与实际计算图。

### 四、来源与参考资料

本题为原创教学题，数值与代码属于专门构造的教学情境。

| 来源 ID | 参考资料 | 对应知识点 |
| ----- | ------------------------------------------------------------------------------------------------------------------------------------ | ---------------------------------- |
| S1 | [PyTorch CrossEntropyLoss](https://docs.pytorch.org/docs/stable/generated/torch.nn.CrossEntropyLoss.html?utm_source=chatgpt.com) | 交叉熵、`ignore_index`、`reduction` |
| S2 | [PyTorch Autograd Mechanics](https://docs.pytorch.org/docs/stable/notes/autograd.html?utm_source=chatgpt.com) | 计算图与梯度传播 |
| S3 | [Hugging Face Causal Language Modeling](https://huggingface.co/docs/transformers/tasks/language_modeling?utm_source=chatgpt.com) | 自回归语言建模、标签与模型训练 |
| S4 | [Attention Is All You Need](https://arxiv.org/abs/1706.03762?utm_source=chatgpt.com) | Transformer、Decoder Self-Attention |
| S5 | [Scheduled Sampling for Sequence Prediction with Recurrent Neural Networks](https://arxiv.org/abs/1506.03099?utm_source=chatgpt.com) | Teacher Forcing 与 Exposure Bias |

**可复现性说明：** 数值结果由题目给定的概率直接推导，并提供完整 PyTorch 验证代码。运行环境需安装 PyTorch；本例不涉及随机采样，主要计算使用 `float64`，因此不存在由随机种子引起的结果差异。

## 实施与验收

- 先完成代表性知识点及配套题目、答案，检查教学完整性，再扩展到其余章节；持续完成用户要求的范围。
- 按 [组合与网站约定](references/skill-composition.md) 实现对应功能。完整网站以 Study、Testing、Answers 为三个主界面，内容与界面分离，共用 Markdown 渲染和源码复制，保持稳定引用与本地进度。注意用户是Windows电脑，做完网站后，你需要给一个脚本，用户点击即可查看网站。网站只需要考虑电脑端，不用考虑手机端，也不用考虑暗色模式。
- 每道题发布前独立检查：背景足够、依据成立、答案正确且无歧义、解析可从基础推到结果。核对公式、数值、shape、所有选项及代码。只执行可信、范围受限的教学示例，遵守环境权限；如实区分实际运行与静态推导。无法确认的题目改写或移除，质量优先于题量。
- 检查真实页面与复制结果保留完整题面、代码和解析；考试提交前隐藏答案，题面导出、预览、动画与跨页导航同样不能泄露当前考试答案。按已实现范围运行项目检查与浏览器验证，未执行的检查如实说明。
- 交付实际产物与启动方式，简述章节/题型覆盖、来源与版本、可视化选择、已运行检查和剩余缺口。仅内容任务交付对应内容，不额外搭网站或管理后台。
