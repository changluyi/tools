#!/bin/bash

# 检查参数
if [ $# -lt 2 ]; then
    echo "Usage: $0 <start_commit> <end_commit> [top_n]"
    echo "Example: $0 85ceed7c7893de73196f02ae8ec766ccd528fc69 4a2c90ad81e055d472b2d8973d72b47364a9f9b5 50"
    echo ""
    echo "Parameters:"
    echo "  start_commit: Starting commit hash"
    echo "  end_commit: Ending commit hash"
    echo "  top_n: Number of top items to show (default: 50)"
    exit 1
fi

START_COMMIT=$1
END_COMMIT=$2
TOP_N=${3:-50}  # 默认显示50个

# 验证commit是否存在
if ! git rev-parse --quiet --verify $START_COMMIT >/dev/null; then
    echo "❌ Error: Start commit '$START_COMMIT' not found"
    exit 1
fi

if ! git rev-parse --quiet --verify $END_COMMIT >/dev/null; then
    echo "❌ Error: End commit '$END_COMMIT' not found"
    exit 1
fi

echo "=========================================="
echo "OVS Commit Summary Report"
echo "=========================================="
echo "From: $START_COMMIT"
echo "To: $END_COMMIT"
echo "Top N: $TOP_N"
echo ""

# 总commit数
TOTAL_COMMITS=$(git log --oneline $START_COMMIT..$END_COMMIT | wc -l)
echo "📊 Total commits: $TOTAL_COMMITS"
echo ""

# 按类型统计
echo "🔍 Commit Type Analysis:"
FIX_COMMITS=$(git log --oneline $START_COMMIT..$END_COMMIT | grep -i "fix" | wc -l)
BUG_COMMITS=$(git log --oneline $START_COMMIT..$END_COMMIT | grep -i "bug" | wc -l)
ADD_COMMITS=$(git log --oneline $START_COMMIT..$END_COMMIT | grep -i "add" | wc -l)
UPDATE_COMMITS=$(git log --oneline $START_COMMIT..$END_COMMIT | grep -i "update" | wc -l)
SECURITY_COMMITS=$(git log --oneline $START_COMMIT..$END_COMMIT | grep -i "security\|cve\|vulnerability" | wc -l)

echo "  🐛 Bug fixes: $FIX_COMMITS"
echo "  🐛 Bug related: $BUG_COMMITS"
echo "  ➕ New features: $ADD_COMMITS"
echo "  🔄 Updates: $UPDATE_COMMITS"
echo "  🔒 Security: $SECURITY_COMMITS"
echo ""

# 时间范围
echo "📅 Time Range:"
FIRST_DATE=$(git log --pretty=format:"%ad" --date=short $START_COMMIT..$END_COMMIT | tail -1)
LAST_DATE=$(git log --pretty=format:"%ad" --date=short $START_COMMIT..$END_COMMIT | head -1)
echo "  From: $FIRST_DATE"
echo "  To: $LAST_DATE"
echo ""

# 主要贡献者
echo "👥 Top Contributors:"
git log --oneline $START_COMMIT..$END_COMMIT --pretty=format:"%an" | sort | uniq -c | sort -nr | head -$TOP_N
echo ""

# 按模块统计
echo "📁 Module Changes:"
git log --oneline $START_COMMIT..$END_COMMIT --name-only | grep -v "^$" | cut -d'/' -f1 | sort | uniq -c | sort -nr | head -$TOP_N
echo ""

# 重要bug修复
echo "🔧 Important Bug Fixes (Top $TOP_N):"
git log --oneline $START_COMMIT..$END_COMMIT | grep -i "fix" | head -$TOP_N
echo ""

# 新功能
echo "✨ New Features (Top $TOP_N):"
git log --oneline $START_COMMIT..$END_COMMIT | grep -i "add\|implement\|support" | head -$TOP_N
echo ""

# 安全相关
if [ $SECURITY_COMMITS -gt 0 ]; then
    echo "🔒 Security Related Commits:"
    git log --oneline $START_COMMIT..$END_COMMIT | grep -i "security\|cve\|vulnerability"
    echo ""
fi

# 按月份统计
echo "📊 Monthly Commit Distribution:"
git log --oneline $START_COMMIT..$END_COMMIT --pretty=format:"%ad" --date=short | cut -d'-' -f1,2 | sort | uniq -c | sort -k2
echo ""

# 其他重要关键词
echo "🔍 Other Important Keywords:"
echo "  Performance improvements: $(git log --oneline $START_COMMIT..$END_COMMIT | grep -i "performance" | wc -l)"
echo "  Memory related: $(git log --oneline $START_COMMIT..$END_COMMIT | grep -i "memory\|leak" | wc -l)"
echo "  Documentation: $(git log --oneline $START_COMMIT..$END_COMMIT | grep -i "doc" | wc -l)"
echo "  Test related: $(git log --oneline $START_COMMIT..$END_COMMIT | grep -i "test" | wc -l)"
echo ""

echo "=========================================="
echo "Summary completed!"
echo "==========================================" 