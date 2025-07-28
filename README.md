# Developer Tools

这是一个开发者工具集合，提供各种实用的脚本和工具来帮助开发工作。

## 📁 项目结构

```
.
├── README.md              # 项目说明文档
├── generate_summary.sh    # Git提交摘要生成工具
└── .specstory/           # 项目配置目录
```

## 🛠️ 工具列表

### 1. Git提交摘要生成器 (`generate_summary.sh`)

一个强大的Git提交分析工具，可以生成详细的提交摘要报告。

#### 功能特性

- 📊 **统计分析**: 统计总提交数、按类型分类的提交
- 👥 **贡献者分析**: 识别主要贡献者
- 📁 **模块变更**: 按模块统计文件变更
- 🔍 **关键词分析**: 分析bug修复、新功能、安全相关提交
- 📅 **时间分布**: 按月份统计提交分布
- 🔧 **重要修复**: 突出显示重要的bug修复

#### 使用方法

```bash
./generate_summary.sh <start_commit> <end_commit> [top_n]
```

**参数说明:**
- `start_commit`: 起始提交的哈希值
- `end_commit`: 结束提交的哈希值  
- `top_n`: 显示前N个结果（可选，默认为50）

**使用示例:**
```bash
# 分析指定范围的提交
./generate_summary.sh 85ceed7c7893de73196f02ae8ec766ccd528fc69 4a2c90ad81e055d472b2d8973d72b47364a9f9b5

# 显示前20个结果
./generate_summary.sh 85ceed7c7893de73196f02ae8ec766ccd528fc69 4a2c90ad81e055d472b2d8973d72b47364a9f9b5 20
```

#### 输出内容

生成的报告包含以下信息：

- 📊 **总体统计**: 总提交数
- 🔍 **提交类型分析**: Bug修复、新功能、更新、安全相关
- 📅 **时间范围**: 提交的时间跨度
- 👥 **主要贡献者**: 按提交数量排序的贡献者列表
- 📁 **模块变更**: 按目录/模块统计的变更
- 🔧 **重要修复**: 包含"fix"关键词的提交
- ✨ **新功能**: 包含"add"、"implement"、"support"关键词的提交
- 🔒 **安全相关**: 安全相关的提交（如果存在）
- 📊 **月度分布**: 按月份统计的提交分布
- 🔍 **其他关键词**: 性能、内存、文档、测试相关的提交统计

## 🚀 快速开始

1. **克隆项目**
   ```bash
   git clone <repository-url>
   cd tools
   ```

2. **设置执行权限**
   ```bash
   chmod +x generate_summary.sh
   ```

3. **使用工具**
   ```bash
   ./generate_summary.sh <start_commit> <end_commit>
   ```

## 📋 系统要求

- Linux/macOS 系统
- Git 已安装并配置
- Bash shell

## 🤝 贡献

欢迎提交Issue和Pull Request来改进这些工具！

## 📄 许可证

[在此添加许可证信息]

---

**注意**: 使用前请确保在Git仓库中运行这些工具，并且指定的提交哈希值存在。
