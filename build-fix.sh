#!/bin/bash
set -e

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}开始修复并部署到GitHub Pages...${NC}"

# 构建233park-web项目
echo -e "${BLUE}1. 构建项目...${NC}"
cd 233park-web
npm ci
npm run build

# 修复资源路径
echo -e "${BLUE}2. 修复资源路径...${NC}"
sed -i '' 's|/Vue.js-Study/233park-web/|./|g' dist/index.html
cd ..

# 创建根目录重定向页面
echo -e "${BLUE}3. 创建重定向页面...${NC}"
cat > redirect.html << EOF
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>233Park - Vue.js项目</title>
    <meta http-equiv="refresh" content="0; url=./233park-web/">
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, sans-serif;
            text-align: center;
            padding: 40px;
            max-width: 600px;
            margin: 0 auto;
            line-height: 1.6;
        }
        h1 { color: #333; }
        a {
            color: #42b983;
            text-decoration: none;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <h1>233Park - Vue.js项目</h1>
    <p>正在跳转到项目页面，如果没有自动跳转，请<a href="./233park-web/">点击这里</a>。</p>
</body>
</html>
EOF

# 准备部署目录
echo -e "${BLUE}4. 准备部署文件...${NC}"
rm -rf dist_deploy
mkdir -p dist_deploy/233park-web
cp -r 233park-web/dist/* dist_deploy/233park-web/
cp redirect.html dist_deploy/index.html
touch dist_deploy/.nojekyll

# 在部署目录创建临时git仓库
echo -e "${BLUE}5. 准备Git仓库...${NC}"
cd dist_deploy
git init
git config user.name "GitHub Manual Deploy"
git config user.email "manual-deploy@github.com"
git add .
git commit -m "手动部署修复版网站 $(date +'%Y-%m-%d %H:%M:%S')"

# 推送到gh-pages分支
echo -e "${BLUE}6. 推送到gh-pages分支...${NC}"
git push -f git@github.com:SincereCSL/Vue.js-Study.git HEAD:gh-pages

# 清理
echo -e "${BLUE}7. 清理临时文件...${NC}"
cd ..
rm -rf dist_deploy

echo -e "${GREEN}部署完成！访问 https://sincerecsl.github.io/Vue.js-Study/ 查看网站${NC}" 