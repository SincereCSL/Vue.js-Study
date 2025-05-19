#!/bin/bash
set -e

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}开始部署到GitHub Pages...${NC}"

# 构建233park-web项目
echo -e "${BLUE}1. 构建项目...${NC}"
cd 233park-web
npm ci
npm run build
cd ..

# 准备部署目录
echo -e "${BLUE}2. 准备部署文件...${NC}"
rm -rf deploy_temp
mkdir -p deploy_temp/233park-web

# 复制dist目录内容到部署目录
cp -r 233park-web/dist/* deploy_temp/233park-web/
cp 233park-web/vite.svg deploy_temp/233park-web/
touch deploy_temp/233park-web/.nojekyll

# 复制根目录重定向文件
cp index.html deploy_temp/
cp 404.html deploy_temp/ 2>/dev/null || :
touch deploy_temp/.nojekyll

# 在部署目录创建临时git仓库
echo -e "${BLUE}3. 准备Git仓库...${NC}"
cd deploy_temp
git init
git config user.name "GitHub Actions"
git config user.email "github-actions@github.com"
git add .
git commit -m "部署网站 $(date +'%Y-%m-%d %H:%M:%S')"

# 推送到gh-pages分支
echo -e "${BLUE}4. 推送到gh-pages分支...${NC}"
git push -f git@github.com:SincereCSL/Vue.js-Study.git master:gh-pages

# 清理
echo -e "${BLUE}5. 清理临时文件...${NC}"
cd ..
rm -rf deploy_temp

echo -e "${GREEN}部署完成！访问 https://sincerecsl.github.io/Vue.js-Study/ 查看网站${NC}" 