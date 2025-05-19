#!/bin/bash
set -e

# 颜色输出
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}开始部署静态文件到GitHub Pages...${NC}"

# 检查static_site目录是否存在
if [ ! -d "static_site" ]; then
    echo -e "${YELLOW}未找到static_site目录，请先运行direct-deploy.sh创建静态文件${NC}"
    exit 1
fi

# 进入static_site目录
cd static_site

# 初始化git仓库
echo -e "${BLUE}1. 初始化Git仓库...${NC}"
git init
git checkout -b temp-deploy

# 配置git
echo -e "${BLUE}2. 配置Git...${NC}"
git config user.name "GitHub Pages Deployment"
git config user.email "deploy@example.com"

# 添加所有文件
echo -e "${BLUE}3. 添加文件...${NC}"
git add .
git commit -m "Deploy static site $(date)"

# 推送到GitHub
echo -e "${BLUE}4. 推送到GitHub...${NC}"
echo -e "${YELLOW}注意：需要GitHub访问权限${NC}"
git push -f https://github.com/SincereCSL/Vue.js-Study.git temp-deploy:gh-pages

# 清理
echo -e "${BLUE}5. 清理临时文件...${NC}"
cd ..
rm -rf static_site/.git

echo -e "${GREEN}部署完成！${NC}"
echo -e "${GREEN}请访问 https://sincerecsl.github.io/Vue.js-Study/ 查看部署结果${NC}"
echo -e "${YELLOW}如果访问失败，请检查GitHub Pages设置${NC}" 