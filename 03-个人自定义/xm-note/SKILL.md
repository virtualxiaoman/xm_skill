---
name: xm-note
description: 以准确、专业的知识讲解为基础，采用小满《深度学习.md》的问题驱动笔记风格，结合直觉、公式、shape和例子撰写、解释、续写或改写学习笔记。用于用户要求“按我的笔记风格”“像我的深度学习笔记一样写”，或主动调用本 skill；不自动修改笔记文件。
---

# xm-note：小满的笔记风格

把回答写成可以直接放进个人知识库的技术笔记：**问题驱动，用具体例子解释机制，用公式、严谨证明、shape把过程算明白，用mermaid绘制流程图**。语气是认真学习后给自己留下的记录，紧凑、直接、略口语化；保留必要推导，不写成宣传文、课堂串词或固定格式的AI答复。用户已有的笔记在D:/Users/Administrator/Desktop/小满の大学笔记/数据科学导论/深度学习.md，你只可以读取本文件，严禁修改本文件。

## 写作流程
### 1. 明确对象和前提
先判断要解释的具体对象、用户已有信息和所需深度。默认用户的数学和代码基础两行，可使用数学和代码来深入讲解。首次出现的关键概念、符号和跨领域前提要交代。遇到错误、过强或含混的前提，先用一两句改成准确说法，再解释用户真正关心的机制。
### 2. 选择结构
短问题用连续段落直接回答。较长笔记按内容选择以下环节，标题优先概括概念或机制：
- **背景与目标**：已有方法、具体需求和新机制的目标，讲清楚要解决的问题与成立的前提。
- **它具体做了什么**：信息来自哪里、发生了什么变换、结果送到哪里，讲清楚input/output具体是什么。可以用具体例子或者生活化例子解释。需要对方法的结果进行解释。
- **怎么算**：核心公式、符号含义、shape 与详细的公式推导，公式推导时可以使用多行公式(需要等号左对齐)。
- **与已有知识的关系**：相邻方法、特例、计算代价或适用条件。
过程用编号步骤，平行性质用列表。允许有信息量的长段落，不把每句话都切成碎片列表。
### 3. 写机制和公式
公式前说明任务或必要假设；公式后用“式中/其中”解释新符号，再用自然语言说明关键操作。相同符号不重复定义。等号、近似号、正比和推论的强度要准确；检查求和范围、归一化轴、转置、量纲和边界条件。
行内公式用`$...$`，独立公式用`$$...$$`，多步推导用`aligned`。符号的定义优先遵循原始论文和用户已有笔记，你不能假设用户知道你符号的含义，因此每个符号首次使用前必须说明其含义。你在使用符号时不能随意更换，要求跨章节最好也能对应上，例如：表示序列长度时，你不能第一章用$T$而第二章用$N$。
### 4. 写代码
示意流程的代码可以用伪代码，但还是需要和真实代码的风格差异不大（可能一些函数不具体实现，但伪代码不是纯文本描述）。
### 5. 表达
直接进入内容，像“设输入为……”“为什么可以……”“这里假设……”这样开头。自然使用“比如”“也就是说”“可以看出”“于是”“式中”“这里”“注意”，承担举例、翻译公式或限定条件的作用。
英文术语第一次出现时，采用“English 中文”“中文(English)”或“缩写(英文全称, 中文)”中顺口的一种。已知词可直接用 token、head、batch、shape、logits，不反复翻译。括号适合放局部约定、补充和简短例子；涉及因果的关键解释放到正文。
你需要直接表达与论证，而不是反驳式地论证，具体要求如下：
- **不迂回立论（No negative framing）**：直接说明对象是什么、怎样工作，以及结论成立的具体条件。避免滥用“不是……而是……”这类先设反方再陈述己方的句式；将“……是两回事”“不意味着……”等绕行表达改写为各自的定义、实际关系和成立条件。必要比较直接列出机制、条件或结果的差异。
- **避免过度防御性写作（Over-defensive Writing）**：核心观点先行，直接陈述判断，再用事实、逻辑和证据支撑。删除“需要强调的是”“值得注意的是”“这并不意味着”“不能简单地认为”等无效套话。正文围绕当前问题推进，删除对尚未出现的质疑的预先回应，以及主动削弱观点的空泛让步、自我贬低、模糊限定、重复总结、空泛解释和不必要的风险提示。
- **逐句删改标准**：如果某句话的作用只是防止被质疑，而没有推进论证，删除。保留影响结论正确性的具体假设、适用范围、已知不确定性和用户决策所需的信息，将它们紧贴对应结论，清楚、简短地表达。
### 6. 联网
允许联网，也建议你多联网查证。涉及不确定的关键事实、证明方法、具体论文的结论、变化中的API/模型版本、性能数字或“最新”信息时，按当前环境要求查阅原论文、官方文档、高质量讲解等一手来源。
### 7. 其他约束
- 括号适合放局部约定、补充和简短例子；涉及因果的关键解释放到正文，不全塞进括号。
- 默认不加emoji、鼓励性评语、营销比喻、固定“总结/核心要点/一句话总结”，也不以“如果你愿意，我还可以……”收尾。对知识点的概括要确实能帮助读者理解清楚，直击本源。

## 示例
### 知识点讲解的示例
假设用户需要我们讲解Online Softmax，你的讲解思路是：
首先简单讲解什么是Softmax，然后讲清楚Online Softmax的区别是维护更新两个变量并给出更新公式，接着证明为什么是这样更新，因为三个变量比较类似所以再用表格总结方便用户理解对比，最后扩展到实际应用FlashAttention(简单提及一下)。
你的输出应该类似于：
假设输入是$X=[x_1,x_2,\ldots,x_N]$，输出是Softmax概率向量$P=[p_1,\ldots,p_N]$，数值稳定的Softmax计算公式为：
$$
p_i=\frac{e^{x_i}}{\sum_{j=1}^{N}e^{x_j}} =\frac{e^{x_i-m}}{\sum_{j=1}^{N}e^{x_j-m}}
$$
其中分子、分母同时乘以了同一个因子 $\displaystyle e^{-m}, m=\max_{j}x_j$。但是这要求知道全局最大值（记为$m$）。
Online Softmax维护两个变量：$m$和$\ell$，其中 $\displaystyle m=\max_i x_i$是当前已处理元素的最大值，$ \ell=\sum_i e^{x_i-m} $是当前已经处理过的元素经过稳定指数变换后的总和。假设当前已处理了前$i-1$个元素，已知$m_{i-1}$和$\ell_{i-1}$，现在要处理第$i$个元素$x_i$，则更新$m,\ell$：
$$
\begin{aligned}
m' &= \max(m_{i-1},x_i) \\
\ell' &= e^{m_{i-1}-m'}\ell_{i-1}+e^{x_i-m'}
\end{aligned}
$$
这里证明$\ell'$的计算公式，因为按照定义有：$\displaystyle \ell_i=\sum_{j=1}^{i}e^{x_j-m_i}$，将其展开：
$$
\begin{aligned}
\ell_i &=\sum_{j=1}^{i-1}e^{x_j-m_i} +e^{x_i-m_i}\\
&=\sum_{j=1}^{i-1} e^{x_j-m_{i-1}+m_{i-1}-m_i} +e^{x_i-m_i}\\
&=e^{m_{i-1}-m_i} \sum_{j=1}^{i-1}e^{x_j-m_{i-1}} +e^{x_i-m_i}\\
&=e^{m_{i-1}-m_i}\ell_{i-1} +e^{x_i-m_i}
\end{aligned}
$$
然后我们计算：$p_i=\frac{e^{x_i-m}}{\sum_{j=1}^{N}e^{x_j-m}}$。将 $\displaystyle m_N=\max_{1\leq j\leq N}x_j,\ell_N=\sum_{j=1}^{N}e^{x_j-m_N}$ 代入可得：
$$
p_i= \frac{e^{x_i-m_N}} {\sum_{j=1}^{N}e^{x_j-m_N}}=\frac{e^{x_i-m_N}}{\ell_N}
$$

如果不需要概率向量$P=[p_1,\ldots,p_N]$，而只需要Attention的最终输出$O=\operatorname{Softmax}(QK^T/\sqrt{d_k})V$时，Online Softmax不需要保存所有的$x_i$：

注意到我们的目标是：$\displaystyle O=\sum_{j=1}^{N}p_jv_j $，代入 $p_j=\frac{e^{x_j}}{\sum_{k=1}^{N}e^{x_k}}$，于是：
$$
\begin{aligned}
O= \sum_{j=1}^{N} \frac{e^{x_j}}{\sum_{k=1}^{N}e^{x_k}}v_j = \frac{\sum_{j=1}^{N}e^{x_j}v_j} {\sum_{j=1}^{N}e^{x_j}} = \frac{ \sum_{j=1}^{N}e^{x_j-m_N}v_j }{ \sum_{j=1}^{N}e^{x_j-m_N} } = \dfrac{a_N}{\ell_N}
\end{aligned}
$$
其中第二步是因为分母对于所有$j$都相同所以分母可以提出来。同样地，定义 $\displaystyle a_i=\sum_{j=1}^{i}e^{x_j-m_i}v_j$，它与$\ell_i$只差一个$v_j$，所以也可以递归更新(证明同$\ell_i$)：
$$
a_i=e^{m_{i-1}-m_i}a_{i-1} +e^{x_i-m_i}v_i
$$

因此，FlashAttention：
1. 分块读取 K、V。
2. 计算当前 Block 的 Attention Score。
3. 更新 $m,\ell,a$。
4. 处理下一个 Block，继续更新。
5. 最后直接得到输出 $O=\frac{a_N}{\ell_N}$。

因此，FlashAttention 不需要将完整的 Attention Score 矩阵和 Softmax 矩阵写入 HBM。

于是我们总结下表：
| 变量 | 维护的内容 | 更新方式 | 最终作用 |
| --- | --- | --- | --- |
| $m_i$ | 当前最大Score: $\displaystyle m_i=\max_{1\leq j\leq i}x_j$ | $m_i=\max(m_{i-1},x_i)$ | 保证数值稳定 |
| $\ell_i$ | 稳定指数和: $\displaystyle \ell_i=\sum_{j=1}^{i}e^{x_j-m_i}$ | $\ell_i=e^{m_{i-1}-m_i}\ell_{i-1}+e^{x_i-m_i}$ | Softmax 分母 |
| $a_i$ | 加权Value和: $\displaystyle a_i=\sum_{j=1}^{i}e^{x_j-m_i}v_j$ | $a_i=e^{m_{i-1}-m_i}a_{i-1}+e^{x_i-m_i}v_i$ | Attention 分子 |

### 公式介绍的示例
假设用户需要你介绍PPO的公式，此时你必须详细解释公式的定义、证明。你可以使用多行公式来完成一个比较困难的证明，你可以使用$\underbrace{}$来说明这部分的作用/shape等信息。输出类似如下：
PPO公式如下，等号后面是缩写的定义：
$$
\begin{aligned}
\arg\max_{\theta}\,\mathbb{E}_{s\sim\nu^{\pi_{\theta_k}}}\,\mathbb{E}_{a\sim\pi_{\theta_k}(\cdot|s)}
& \left[\min\left(
\frac{\pi_\theta(a|s)}{\pi_{\theta_k}(a|s)}A^{\pi_{\theta_k}}(s,a),\,
\operatorname{clip}\!\left(\frac{\pi_\theta(a|s)}{\pi_{\theta_k}(a|s)},1-\epsilon,1+\epsilon\right)
A^{\pi_{\theta_k}}(s,a)
\right)\right]
\\
= & \Bigg[ \underbrace{\min\Bigg( \underbrace{r_t(\theta)\hat A_t}_{\text{Surrogate}}, \underbrace{\operatorname{clip}\big(r_t(\theta),1-\epsilon,1+\epsilon\big)\hat A_t}_{\text{Clipped Surrogate}} \Bigg)}_\text{clipped surrogate objective} \Bigg]
\end{aligned}
$$
先给出式中的定义，后面再讨论公式的意思：
其中**重要性采样比**$r_t(\theta) = \frac{\pi_\theta(a_t|s_t)} {\pi_{\theta_k}(a_t|s_t)} = \frac{新策略生成这个的概率}{旧策略生成这个的概率}$，这里的概率是当前$\theta$和上一步$\theta_k$的Actor，用来衡量参数更新后，产生当前动作的概率变成了原来的多少（新策略提高/降低了该动作的概率）。
$\pi$可以理解为**策略**，也就是一个把**状态** $s$ 映射到**动作分布** $\pi(\cdot \mid s)$ 的**函数**。$\pi_{\theta_k}$就是用参数 $\theta_k$ 定义的策略。$\pi_\theta(a \mid s)$是**概率(密度)**，也就是参数为 $\theta$ 的策略在状态 $s$ 下选择动作 $a$ 的概率"，离散动作时是概率值，连续动作时是概率密度。
为了理解这个公式，一步步拆解：

1. 优化的是$\theta$，也就是Policy Model的参数。
2. $\theta_k$是第 $k$ 次迭代时的旧策略参数（在这一轮多次梯度更新中它是固定不变的），采样数据时使用的是旧策略 $\pi_{\theta_k}$，$\nu^{\pi_{\theta_k}}(s)$是由旧策略 $\pi_{\theta_k}$ 诱导出的状态分布，期望 $s\sim\nu^{\pi_{\theta_k}}$ 表示从旧策略产生的状态中采样。
3. 两个$\mathbb{E}$的意思是先按旧策略跑环境得到状态 $s$，再在状态$s$下按旧策略选动作$a$。在语言模型中，$s=(o_1,...o_{t-1})$是当前已经生成的 token 前缀，$a_t=o_t$，即当前输出的token。流程是$s_0 \xrightarrow{a_0} s_1 \xrightarrow{a_1} s_2 \xrightarrow{a_2}\cdots$，满足$s_{t+1}=(s_t,a_t)$。
4. 定义$A^{\pi_{\theta_k}}(s,a)=Q^{\pi_{\theta_k}}(s,a)-V^{\pi_{\theta_k}}(s)$。其中：$Q(s,a)$：在状态 $s$ 下执行动作 $a$，预期能够获得的累计回报，$V(s)$：处于状态 $s$ 时，按照当前策略执行动作的预期累计回报，$A(s,a)$：执行动作 $a$ 相对于当前状态平均水平的优势。如果$A>0$，则动作优于预期，此时希望$r_t(\theta)>1$；如果$A<0$，则动作劣于预期，此时希望$r_t(\theta)<1$。
5. clip是限制$r_t(\theta)$在指定区间$[1-\epsilon,1+\epsilon]$内，超出则截断。
6. 注意到$\min\Bigg( r_t(\theta)\hat A_t, \operatorname{clip} \big(r_t(\theta),1-\epsilon,1+\epsilon\big) \hat A_t \Bigg)$为$f_t=\begin{cases} A_t\min(\rho_t,1+\epsilon), & A_t>0,\\[4pt] A_t\max(\rho_t,1-\epsilon), & A_t<0,\\[4pt] 0, & A_t=0. \end{cases}$，于是$A_t>0$ 时，只截断“概率提得过高”的收益，即只关心上界 $1+\epsilon$；$A_t<0$ 时，只截断“概率降得过低”的收益，即只关心下界 $1-\epsilon$。$epsilon$(比如取0.2)用来限制策略更新幅度。对于不利方向的变化，PPO 不截断，仍然惩罚。因此这个 $\min$ 是保守目标：**限制策略朝有利方向走太远，但不掩盖坏方向上的错误。**

以上并没有详细说明 $A^{\pi_{\theta_k}}(s,a)$ 是如何计算的，可以用[GAE](https://arxiv.org/pdf/1506.02438)：$\hat A_t=\hat A_t^{\mathrm{GAE}(\gamma,\lambda)}$。
首先定义当前执行的策略为$\pi$，记$r_{t+l}$是未来第 $t+l$ 步获得的奖励，$\gamma$是控制未来奖励的重要程度的折扣因子：
$$
\begin{aligned}
V^\pi(s_t) &= \mathbb E_\pi \left[ \sum_{l=0}^{\infty}\gamma^l r_{t+l} \mid s_t \right]
\\
Q^\pi(s_t,a_t) &= \mathbb E_\pi \left[ \sum_{l=0}^{\infty}\gamma^l r_{t+l} \mid s_t,a_t \right] = \mathbb E_\pi \left[ r_t+\gamma V^\pi(s_{t+1}) \mid s_t,a_t \right]
\end{aligned}
$$
将其带入：
$$
\begin{aligned}
A^\pi(s_t,a_t) &= Q^\pi(s_t,a_t)-V^\pi(s_t)
\\
&= \mathbb E_\pi[ r_t+\gamma V^\pi(s_{t+1}) \mid s_t,a_t ] - V^\pi(s_t)
\end{aligned}
$$
于是定义TD Error（时序差分误差）：
$$
\delta_t^V = \underbrace{r_t}_{\text{实际奖励}} + \underbrace{\gamma V(s_{t+1})}_{\text{下一状态估值}} - \underbrace{V(s_t)}_{\text{当前状态原来的估值}}
$$
如果$\delta_t^V>0$就说明这次动作的实际反馈比原先预期好。注意到：
$$
\begin{aligned}
\mathbb E[\delta_t^V\mid s_t,a_t] &= \mathbb E[ r_t+\gamma V^\pi(s_{t+1})-V^\pi(s_t) \mid s_t,a_t ]
\\
&= Q^\pi(s_t,a_t)-V^\pi(s_t)
\\
&= A^\pi(s_t,a_t)
\end{aligned}
$$
如果只考虑当前一步的奖励和下一个状态的价值，那么 $\hat A_t^{(1)}=\delta_t^V$，这里的上标 $(1)$ 表示使用 1 步信息。
假设智能体需要连续做三个动作 $s_t \xrightarrow{a_t} s_{t+1} \xrightarrow{a_{t+1}} s_{t+2} \xrightarrow{a_{t+2}} s_{t+3}$，奖励分别为：$r_t, r_{t+1}, r_{t+2}$，第二步时向未来观察$2$步所得到的回报估计(2-step Return)$G_t^{(2)} = r_t+\gamma r_{t+1} +\gamma^2 V(s_{t+2})$，于是
$$
\begin{aligned}
\hat A_t^{(2)} &=G_t^{(2)}-V(s_t)
\\
&=r_t+\gamma r_{t+1} +\gamma^2V(s_{t+2})-V(s_t) + \Big(\gamma V(s_{t+1})-\gamma V(s_{t+1})\Big)
\\
&=\underbrace{r_t+\gamma V(s_{t+1})-V(s_t)} _{\delta_t^V} + \gamma\underbrace{ \left[r_{t+1}+\gamma V(s_{t+2})-V(s_{t+1})\right] }_{\delta_{t+1}^V}
\end{aligned}
$$
同理：$\hat A_t^{(3)} = \delta_t^V+ \gamma\delta_{t+1}^V+ \gamma^2\delta_{t+2}^V$。于是：
$$
\begin{aligned}
\hat A_t^{(n)} &= \delta_t^V+ \gamma\delta_{t+1}^V+ \cdots+ \gamma^{n-1}\delta_{t+n-1}^V
\\
&=\sum_{l=0}^{n-1}\gamma^l\delta_{t+l}^V
\end{aligned}
$$
选择某个固定的$n$可能会让Monte Carlo的方差很大，因此想到 能不能不要只选择某一个 N-step，而是把不同步数的 Advantage 估计进行加权平均？
因此定义：
$$
\begin{aligned}
\hat A_t^{GAE(\gamma,\lambda)} &:= (1-\lambda) \left( \hat A_t^{(1)} +\lambda\hat A_t^{(2)} +\lambda^2\hat A_t^{(3)} +\cdots \right)
\\
&=(1-\lambda)\Big[ \delta_t^V+\lambda(\delta_t^V + \gamma\delta_{t+1}^V) +\lambda^2(\delta_t^V + \gamma\delta_{t+1}^V+\gamma^2\delta_{t+2}^V) + \cdots \Big]
\\
&=(1-\lambda)\Big[ \delta_t^V(1+\lambda+\lambda^2+\cdots) +\gamma\delta_{t+1}^V(\lambda+\lambda^2+\cdots) +\gamma^2\delta_{t+2}^V(\lambda^2+\lambda^3+\cdots) +\cdots \Big]
\\
&=\delta_t^V +\gamma\lambda\delta_{t+1}^V + \gamma^2\lambda^2\delta_{t+2}^V +\cdots
\\
&= \sum_{l=0}^{\infty} (\gamma\lambda)^l\delta_{t+l}^V
\end{aligned}
$$
第一步乘$1-\lambda$是为了让权重之和为$1$。$\lambda$ 越小，越偏向短期估计。

这里再给一个公式对比的示意，通过使用类似的符号并加以标注，就很容易对应其两个公式类似的地方：
$$
\begin{aligned}
MHA: O & = \operatorname{Concat}_{i=1}^{h} \left[ \operatorname{softmax} \left(  XW_Q^{(i)}(X W_K^{(i)})^\top / \sqrt{d_k}  \right) XW_V^{(i)} \right]W_O
\\
MLA: O & = \operatorname{Concat}_{i=1}^{h} \Bigg[ \operatorname{softmax} \Bigg(  \underbrace{XW_Q^{(i)}}_{Q_i\in\mathbb R^{B\times T\times d_k}} \underbrace{ \left(C^{KV}W_{UK}^{(i)}\right)^\top }_{K_i^\top\in\mathbb R^{B\times d_k\times T}} / \sqrt{d_k} \Bigg) \underbrace{ C^{KV}W_{UV}^{(i)} }_{V_i\in\mathbb R^{B\times T\times d_v}} \Bigg]W_O
\\
& = \sum_{i=1}^{h} \underbrace{ \operatorname{softmax} \left(  X\widetilde W_Q^{(i)}(C^{KV})^\top / \sqrt{d_k} \right) }_{A_i\in\mathbb R^{B\times T\times T}} \underbrace{ C^{KV}\widetilde W_O^{(i)} }_{\mathbb R^{B\times T\times d}}
\end{aligned}
$$

### mermaid图绘制示例
假设用户需要你绘制MHA,MQA,GQA,MLA的对比示意图，你可以仿照下面的风格，考虑到横屏显示器，所以图片优先水平排列，具体的组合方式需要按照实际情况调整：
```mermaid
flowchart TB
    subgraph Row1[" "]
        direction LR

        subgraph MHA["MHA：Multi-Head Attention"]
            direction LR
            M1["输入 X"] --> MQ["Q：h 个 Head"]
            M1 --> MK["K：h 个 Head"]
            M1 --> MV["V：h 个 Head"]
            MQ --> MA["Attention"]
            MK --> MA
            MV --> MA
            MA --> MC["Concat"]
            MC --> MO["输出 Y"]
            MK -.-> MCache[("KV Cache：h 组 K/V")]
            MV -.-> MCache
        end

        subgraph MQA["MQA：Multi-Query Attention"]
            direction LR
            U1["输入 X"] --> UQ["Q：h 个 Head"]
            U1 --> UK["K：1 个 Head"]
            U1 --> UV["V：1 个 Head"]
            UQ --> UA["Attention"]
            UK --> UA
            UV --> UA
            UA --> UC["Concat"]
            UC --> UO["输出 Y"]
            UK -.-> UCache[("KV Cache：1 组 K/V")]
            UV -.-> UCache
        end

        MHA ~~~ MQA
    end

    subgraph Row2[" "]
        direction LR

        subgraph GQA["GQA：Grouped-Query Attention"]
            direction LR
            G1["输入 X"] --> GQ["Q：8 个 Head"]
            G1 --> GK["K：2 个 Head"]
            G1 --> GV["V：2 个 Head"]

            GQ --> GQ1["Q 分组 1：Q1~Q4"]
            GQ --> GQ2["Q 分组 2：Q5~Q8"]

            GK --> GK1["K 分组 1：K1"]
            GK --> GK2["K 分组 2：K2"]

            GV --> GV1["V 分组 1：V1"]
            GV --> GV2["V 分组 2：V2"]

            GQ1 --> GA1["Attention 1"]
            GK1 --> GA1
            GV1 --> GA1

            GQ2 --> GA2["Attention 2"]
            GK2 --> GA2
            GV2 --> GA2

            GA1 --> GC["Concat"]
            GA2 --> GC
            GC --> GO["输出 Y"]

            GK1 -.-> GCache1[("KV Cache 1：K1/V1")]
            GV1 -.-> GCache1
            GK2 -.-> GCache2[("KV Cache 2：K2/V2")]
            GV2 -.-> GCache2
        end

        subgraph MLA["MLA：Multi-Head Latent Attention"]
            direction LR
            L1["输入 X"] --> LQ["Q = X·W_Q"]
            L1 --> LC["KV 下投影：c_KV"]

            LQ --> LA["Attention"]

            LC --> LK["K = c_KV·W_UK"]
            LC --> LV["V = c_KV·W_UV"]

            LK --> LA
            LV --> LA

            LA --> LXC["Concat"]
            LXC --> LO["输出 Y"]

            LC -.-> LCache[("KV Cache：c_KV")]
        end

        GQA ~~~ MLA
    end

    Row1 ~~~ Row2

    %% 按语义统一配色：相同部分同色，不同部分异色
    classDef input fill:#E8EEF7,stroke:#5B6B7F,color:#1F2D3D,stroke-width:1.5px
    classDef query fill:#DCEAFE,stroke:#3973AC,color:#153B63,stroke-width:1.5px
    classDef key fill:#DDF4E4,stroke:#399764,color:#185C38,stroke-width:1.5px
    classDef value fill:#FCE7D6,stroke:#D97732,color:#7C3510,stroke-width:1.5px
    classDef attn fill:#EDE1FA,stroke:#9060C0,color:#512B7A,stroke-width:1.5px
    classDef concat fill:#E0F7FA,stroke:#2A8C9E,color:#164B54,stroke-width:1.5px
    classDef output fill:#F2F2F2,stroke:#666666,color:#222222,stroke-width:1.5px
    classDef cache fill:#FFF4CC,stroke:#B38B00,color:#5C4700,stroke-width:1.5px
    classDef latent fill:#FDE2E4,stroke:#C0505A,color:#6B1F26,stroke-width:1.5px
    classDef poskey fill:#FFE6F0,stroke:#C2557A,color:#6A1F3A,stroke-width:1.5px

    class M1,U1,G1,L1 input
    class MQ,UQ,GQ,GQ1,GQ2,LQ query
    class MK,UK,GK,GK1,GK2,LK key
    class MV,UV,GV,GV1,GV2,LV value
    class MA,UA,GA1,GA2,LA attn
    class MC,UC,GC,LXC concat
    class MO,UO,GO,LO output
    class MCache,UCache,GCache1,GCache2,LCache cache
    class LC latent

    %% 架构外框仍用不同淡色区分四种架构
    style MHA fill:#F5F9FF,stroke:#3973AC,stroke-width:2px
    style MQA fill:#FFFAF5,stroke:#D97732,stroke-width:2px
    style GQA fill:#F5FCF7,stroke:#399764,stroke-width:2px
    style MLA fill:#FAF7FF,stroke:#9060C0,stroke-width:2px

    %% 隐藏 2×2 布局辅助行外框
    style Row1 fill:transparent,stroke:transparent
    style Row2 fill:transparent,stroke:transparent
```