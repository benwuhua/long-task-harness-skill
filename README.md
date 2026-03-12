# Long-Task Harness Skill

`long-task-harness-skill` 是一个独立可发布的 long-task 工作流仓库，面向 Claude Code、OpenCode、Codex 三个平台提供统一的多会话软件工程流程。

对外暴露的产品名保持为 `long-task`，因此用户命令、技能名和安装后的命名空间都继续使用 `long-task`。

## 快速安装

### Claude Code

先添加 marketplace：

```bash
/plugin marketplace add benwuhua/long-task-harness-skill
```

再安装插件：

```bash
/plugin install long-task@long-task-harness-skill
```

### OpenCode

macOS / Linux:

```bash
curl -fsSL https://raw.githubusercontent.com/benwuhua/long-task-harness-skill/main/install.sh | bash
```

Windows PowerShell:

```powershell
irm https://raw.githubusercontent.com/benwuhua/long-task-harness-skill/main/install.ps1 | iex
```

### Codex

直接告诉 Codex：

```text
Fetch and follow instructions from https://raw.githubusercontent.com/benwuhua/long-task-harness-skill/main/.codex/INSTALL.md
```

## Harness Engineering

`long-task-harness-skill` 不是只分发技能文件的仓库。它把 repo-local harness 当成一等产物，让 agent 的工作依赖仓库里的命令、runbook、evidence 和模板，而不是口头上下文。

仓库表层直接提供这些入口：

- [Harness Engineering 说明](docs/HARNESS_ENGINEERING.md)
- `docs/templates/env-guide-template.md`
- `docs/templates/long-task-guide-template.md`
- `docs/templates/runbook-template.md`
- `docs/templates/artifacts-readme-template.md`
- `docs/runbooks/README.md`
- `artifacts/README.md`

这套结构的目标是让用户打开仓库就能看见：如何启动环境、如何恢复故障、证据放在哪里、worker 会依赖哪些 repo-local 资产继续工作。

## 使用方式

安装完成后，直接告诉 agent 你想构建什么，或显式提到 `long-task`。

示例：

```text
我想构建一个天气查询小程序，使用 long-task。
```

工作流会自动路由到对应阶段：

```text
需求 → UCD（如有 UI）→ 设计 → 初始化 → 功能循环 → 系统测试
```

Claude Code 还支持快捷命令：

```text
/long-task:requirements
/long-task:ucd
/long-task:design
/long-task:init
/long-task:work
/long-task:st
/long-task:increment
/long-task:status
```

## 仓库内容

- `skills/`：12 个 long-task 核心技能
- `commands/`：Claude Code 命令入口
- `scripts/`：校验、初始化、自动循环等脚本
- `hooks/`：Claude Code hook
- `.claude-plugin/`：Claude marketplace 元数据
- `.opencode/plugins/`：OpenCode 插件
- `.codex/INSTALL.md`：Codex 安装入口
- `docs/`：平台说明、Harness Engineering 文档与模板
- `docs/runbooks/`：诊断与恢复 runbook
- `artifacts/`：日志、截图、trace、测试证据的约定位置
- `tests/`：Python 验证测试

## 核心能力

- 多会话持久化项目状态
- SRS / UCD / Design / Init / Work / ST 六阶段流程
- 严格 TDD、覆盖率门禁、变异测试门禁
- 每功能黑盒验收测试与系统级测试
- 增量需求变更与影响分析
- 跨 Claude Code、OpenCode、Codex 的统一技能分发

## 开发与验证

运行测试：

```bash
python3 -m pytest tests -q
```

检查关键脚本：

```bash
python3 scripts/validate_features.py feature-list.json
python3 scripts/get_tool_commands.py feature-list.json --json
```

平台文档：

- [OpenCode 安装说明](docs/README.opencode.md)
- [Codex 安装说明](docs/README.codex.md)

## 发布目标

本仓库面向公开 GitHub 仓库 `benwuhua/long-task-harness-skill` 发布，安装和文档都以该仓库为唯一来源。
