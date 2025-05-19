#!/bin/bash
set -e

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}开始准备部署到GitHub Pages...${NC}"

# 安装gh-pages工具
echo -e "${BLUE}1. 安装gh-pages工具...${NC}"
npm install -g gh-pages

# 构建233park-web项目
echo -e "${BLUE}2. 构建项目...${NC}"
cd 233park-web
npm ci
npm run build
cd ..

# 创建发布目录
echo -e "${BLUE}3. 准备发布目录...${NC}"
rm -rf public
mkdir -p public/233park-web

# 复制文件
echo -e "${BLUE}4. 复制文件到发布目录...${NC}"
cp -r 233park-web/dist/* public/233park-web/

# 创建根目录索引文件
echo -e "${BLUE}5. 创建根目录索引...${NC}"
cat > public/index.html << EOF
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>233Park - Vue.js项目</title>
    <meta http-equiv="refresh" content="0; url=233park-web/">
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
    <p>正在跳转到项目页面，如果没有自动跳转，请<a href="233park-web/">点击这里</a>。</p>
</body>
</html>
EOF

# 确保.nojekyll文件存在
touch public/.nojekyll

# 创建一个测试文件验证部署
echo "部署测试文件 - $(date)" > public/deployed.txt

# 部署到GitHub Pages
echo -e "${BLUE}6. 部署到GitHub Pages...${NC}"
echo -e "${YELLOW}注意: 将使用gh-pages工具部署，这可能需要GitHub凭据${NC}"
gh-pages -d public --dotfiles

echo -e "${GREEN}部署命令已执行！${NC}"
echo -e "${GREEN}请稍后访问 https://sincerecsl.github.io/Vue.js-Study/ 查看您的网站${NC}"
echo -e "${YELLOW}如果仍有问题，请检查gh-pages工具的日志输出${NC}" 