# 界面 CSS 颜色设计方案

## 总体结论

当前项目UI设计方向：

1. 这是知识工作台，还是控制台/作战台？
2. 这是普通结构页，还是智能交互页？
3. 颜色是要承担品牌强调，还是承担事件编码？

## 统一基础规则

### 1. 全局底色原则

都遵循深色底的统一前提：

- 页面底色使用深灰或深黑
- 容器通过明度差建立层级
- 强调色只出现在交互点、状态点、标题头、标签、气泡、时间线节点

不建议：

- 做浅色主页面
- 用大面积高饱和颜色铺底
- 同时引入多个竞争性的主按钮颜色

### 2. 文本层级原则

建议统一保留 4 级文本层级：

| 层级     | 作用                        | 常见颜色                          |
| -------- | --------------------------- | --------------------------------- |
| 一级文字 | 标题、核心内容              | `#e8e8e8` / `#ededed` / `#e2e8f0` |
| 二级文字 | 描述、说明、副标题          | `#b0b0b0` / `#94a3b8` / `#a1a1aa` |
| 三级文字 | 标签、时间、辅助信息        | `#888` / `#64748b` / `#52525b`    |
| 四级文字 | placeholder、禁用、极弱信息 | `#666` / `#475569` / `#404040`    |

原则：

- 不用纯白大面积正文
- 深色底上的正文保持柔和对比
- 状态色只负责强调，不承担长段正文

### 3. 容器层级原则

建议沿用统一层级：

1. 页面层
2. 主面板层
3. 次级面板层
4. 输入 / 代码 / 嵌入区

典型映射：

- 页面层：`#141414`、`#0a0a0a`、深蓝渐变背景
- 主面板层：`#1e1e1e`、`#171717`、`rgba(15, 23, 42, 0.6 ~ 0.8)`
- 次级面板层：`#252525`、`#262626`、`rgba(30, 41, 59, 0.5 ~ 0.8)`
- 内容嵌入层：`#1a1a1a`、`rgba(0, 0, 0, 0.2 ~ 0.4)`

### 4. 交互反馈原则

当前项目的 hover / active / focus 都比较克制，推荐统一延续：

- hover：轻微提亮背景或提高边框强度
- active：提升强调色透明度或切换到实色
- focus：使用低透明外发光 ring
- selected：轻底色 + 语义边框，或直接使用实色主按钮

不建议：

- 同时叠很重的边框和阴影
- 做过亮、过厚、过饱和的 focus 效果

## 设计方案总览

整理后，建议把当前风格归纳为 4 套主方案 + 1 套通用语义体系。

### 方案 A: 工作台方案

适用场景：

- 数据概览
- 历史记录
- 配置页
- 列表页
- 表单页
- 普通后台型辅助界面

视觉特征：

- 中性深灰为主
- 信息块边界清楚
- 内容密度高但不压迫
- 蓝色承担工具类操作强调

推荐颜色：

```css
--scheme-a-bg-base: #141414;
--scheme-a-bg-panel: #1e1e1e;
--scheme-a-bg-subtle: #252525;
--scheme-a-bg-deep: #1a1a1a;
--scheme-a-border-base: #2d2d2d;
--scheme-a-border-strong: #3d3d3d;
--scheme-a-border-hover: #4d4d4d;

--scheme-a-text-primary: #e8e8e8;
--scheme-a-text-secondary: #b0b0b0;
--scheme-a-text-muted: #888;
--scheme-a-text-disabled: #666;

--scheme-a-accent: #3b82f6;
--scheme-a-accent-hover: #2563eb;
```

使用建议：

- 这是最稳妥的“默认后台页”方案
- 如果页面核心是结构管理、数据管理、配置操作，优先用它
- 不要在这个方案里再引入绿色和蓝色同时做主按钮

### 方案 B: 智能交互方案

适用场景：

- AI 对话
- 知识检索
- 智能推荐
- 线程选择
- 思考过程
- 引用来源

视觉特征：

- 深蓝渐变背景
- 半透明面板
- 绿色作为智能交互主色
- 整体更沉浸、更有“系统智能感”

推荐颜色：

```css
--scheme-b-bg-start: #0f172a;
--scheme-b-bg-end: #1e293b;
--scheme-b-panel: rgba(15, 23, 42, 0.8);
--scheme-b-subtle: rgba(30, 41, 59, 0.8);
--scheme-b-embed: rgba(0, 0, 0, 0.25);

--scheme-b-text-primary: #e8e8e8;
--scheme-b-text-secondary: #94a3b8;
--scheme-b-text-muted: #64748b;
--scheme-b-text-disabled: #475569;

--scheme-b-accent: #4ade80;
--scheme-b-accent-hover: #22c55e;
--scheme-b-accent-text: #86efac;
--scheme-b-on-accent: #0f172a;
```

使用建议：

- 与 AI、知识、智能、推荐相关的页面都优先使用这套
- hover / selected 建议使用绿色低透明背景
- 如果主操作已经用绿色，输入 focus 就不要再切回蓝色

### 方案 C: C2 控制台方案

适用场景：

- 客户端列表
- 资源浏览器
- 控制台主页
- 日志抽屉
- 终端辅助面板
- 系统工具栏

视觉特征：

- 更偏终端和控制台
- 深黑底更明显
- 蓝色 / 青色承担系统主色
- 信息传达比“美观装饰”优先级更高

推荐颜色：

```css
--scheme-c-bg-base: #0a0a0a;
--scheme-c-bg-panel: #171717;
--scheme-c-bg-subtle: #262626;
--scheme-c-bg-strong: #404040;

--scheme-c-text-primary: #ededed;
--scheme-c-text-secondary: #a1a1aa;
--scheme-c-text-muted: #52525b;
--scheme-c-text-disabled: #404040;

--scheme-c-border-base: #262626;
--scheme-c-border-strong: #404040;

--scheme-c-accent-primary: #3b82f6;
--scheme-c-accent-primary-hover: #2563eb;
--scheme-c-accent-secondary: #0ea5e9;
--scheme-c-accent-secondary-soft: rgba(14, 165, 233, 0.12);
```

使用建议：

- 适合结构型系统界面，不适合直接拿去做攻击/危险交互主界面
- 蓝和青可以共存，但应该保持“一个主按钮色 + 一个辅助高亮色”的关系

### 方案 D: 对抗 / 攻击交互方案

适用场景：

- 攻击对话
- 风险操作面板
- MCP 命令交互
- 红区动作确认
- 高风险命令输入区

视觉特征：

- 深色底不变
- 红橙渐变成为视觉锚点
- 危险感更强
- 明确区分“普通系统操作”和“对抗式交互”

推荐颜色：

```css
--scheme-d-bg-panel: rgba(0, 0, 0, 0.3);
--scheme-d-bg-input: rgba(0, 0, 0, 0.4);

--scheme-d-accent-danger: #ef4444;
--scheme-d-accent-danger-hover: #dc2626;
--scheme-d-accent-warm: #f97316;
--scheme-d-danger-soft: rgba(239, 68, 68, 0.08);
--scheme-d-danger-mid: rgba(239, 68, 68, 0.15);
--scheme-d-danger-border: rgba(239, 68, 68, 0.3);
--scheme-d-danger-text: #fca5a5;
--scheme-d-danger-text-strong: #fecaca;
```

使用建议：

- 只在高风险、攻击、危险、对抗、阻断、停止类界面使用
- 不要把这套红橙方案扩散到普通后台页
- 红色应该承担“动作性质”表达，不应用来做普通功能区装饰

## 通用语义状态体系

上面 4 套方案都可以共享同一套语义色，只是落在不同容器上。

### 成功

用途：

- 完成
- 已连接
- 已执行
- 已缓存
- 已通过

推荐颜色：

```css
--status-success: #22c55e;
--status-success-strong: #10b981;
--status-success-soft: rgba(34, 197, 94, 0.08);
--status-success-border: rgba(34, 197, 94, 0.3);
```

### 危险 / 错误

用途：

- 删除
- 停止
- 失败
- 高风险操作
- 对抗动作

推荐颜色：

```css
--status-danger: #ef4444;
--status-danger-hover: #dc2626;
--status-danger-soft: rgba(239, 68, 68, 0.1);
--status-danger-border: rgba(239, 68, 68, 0.3);
--status-danger-text: #fca5a5;
```

### 警告 / 思考 / 待处理

用途：

- 思考中
- 等待中
- 待审批
- 提醒
- 中间态

推荐颜色：

```css
--status-warning: #f59e0b;
--status-warning-soft: #fbbf24;
--status-warning-bg: rgba(251, 191, 36, 0.08);
--status-warning-border: rgba(251, 191, 36, 0.3);
```

### 信息 / 智能 / 分析

用途：

- AI 输出
- reasoning
- 智能流程
- 系统主操作

推荐颜色：

```css
--status-info: #0ea5e9;
--status-info-bright: #00d4ff;
--status-info-soft: rgba(34, 211, 238, 0.08);
--status-info-border: rgba(34, 211, 238, 0.3);
```

### 特殊流程 / 审批 / 远程调用

用途：

- remote call
- pending approval
- 特殊节点
- 附加能力态

推荐颜色：

```css
--status-special: #a855f7;
--status-special-soft: #a78bfa;
--status-special-bg: rgba(168, 85, 247, 0.08);
--status-special-border: rgba(168, 85, 247, 0.3);
```

## 方案选择建议

后续新增界面时，建议按下面规则选方案。

### 场景 1: 普通产品工作台

优先使用：`方案 A`

典型页面：

- 数据统计
- 配置中心
- 后台列表
- 资源管理

### 场景 2: AI / 知识 / 推荐交互

优先使用：`方案 B`

典型页面：

- AI 助理
- 检索结果
- 引用来源
- 智能摘要

### 场景 3: 控制台 / 终端 / 运维系统

优先使用：`方案 C`

典型页面：

- 客户端管理
- 文件浏览器
- 工具面板
- 日志中心

### 场景 4: 风险 / 攻击 / 对抗 / 停止操作

优先使用：`方案 D`

典型页面：

- 攻击指令输入
- MCP 对话区
- 高风险审批
- 紧急停止区

## 不建议的做法

- 不要在同一页面里同时让蓝、绿、红都成为主按钮色
- 不要把状态色当成大面积背景主色
- 不要脱离深色层级，单独堆很多彩色卡片

## 推荐统一 Token

如果后续要继续统一样式，建议将这份文档抽象为三层 token。

### 1. 基础层 Token

```css
--app-bg-base;
--app-bg-panel;
--app-bg-subtle;
--app-bg-deep;

--app-text-primary;
--app-text-secondary;
--app-text-muted;
--app-text-disabled;

--app-border-base;
--app-border-strong;
```

### 2. 方案层 Token

```css
--scheme-accent-primary;
--scheme-accent-primary-hover;
--scheme-accent-secondary;
--scheme-accent-soft;
--scheme-accent-border;
--scheme-on-accent;
```

### 3. 语义层 Token

```css
--status-success;
--status-danger;
--status-warning;
--status-info;
--status-special;
```

## 建议

后续设计时可以直接做如下决策：

- 普通后台页默认用 `方案 A`
- AI 与知识交互默认用 `方案 B`
- 控制台与系统页默认用 `方案 C`
- 危险、攻击、对抗式交互默认用 `方案 D`
- 所有方案共享统一语义色体系

