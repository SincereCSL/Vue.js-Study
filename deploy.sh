#!/bin/bash
set -e

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
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
echo -e "${BLUE}复制dist目录内容...${NC}"
cp -r 233park-web/dist/* deploy_temp/233park-web/

# 检查并复制vite.svg（如果存在）
if [ -f "233park-web/vite.svg" ]; then
  echo -e "${GREEN}找到vite.svg文件，正在复制...${NC}"
  cp 233park-web/vite.svg deploy_temp/233park-web/
elif [ -f "233park-web/dist/vite.svg" ]; then
  echo -e "${YELLOW}在dist目录找到vite.svg文件，正在复制...${NC}"
  cp 233park-web/dist/vite.svg deploy_temp/233park-web/
else
  echo -e "${YELLOW}警告: 找不到vite.svg文件，跳过复制${NC}"
  # 创建一个空的favicon以避免404错误
  echo -e "${YELLOW}创建一个空的favicon.ico文件...${NC}"
  touch deploy_temp/233park-web/favicon.ico
fi

# 添加.nojekyll文件
touch deploy_temp/233park-web/.nojekyll

# 复制根目录重定向文件
echo -e "${BLUE}复制重定向文件...${NC}"
cp index.html deploy_temp/
# 尝试复制404文件，如果存在的话
if [ -f "404.html" ]; then
  cp 404.html deploy_temp/
fi
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