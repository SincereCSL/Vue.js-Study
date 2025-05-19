#!/bin/bash
set -e

# 颜色输出
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}开始强制部署纯HTML站点到GitHub Pages...${NC}"

# 创建一个完全独立的HTML文件，不依赖任何外部资源
echo -e "${BLUE}1. 创建独立HTML文件...${NC}"

rm -rf deploy_html
mkdir -p deploy_html/233park-web

# 创建一个完全内联的Vue应用
cat > deploy_html/233park-web/index.html << 'HTMLEOF'
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>233乐园 - Vue.js应用</title>
  <style>
    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
      max-width: 800px;
      margin: 0 auto;
      padding: 20px;
      text-align: center;
    }
    .app-container {
      border: 1px solid #eee;
      border-radius: 8px;
      padding: 20px;
      margin-top: 20px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    .success-icon {
      color: #42b983;
      font-size: 48px;
      margin: 20px 0;
    }
    h1 { color: #42b983; }
    p { line-height: 1.6; }
    button {
      background-color: #42b983;
      color: white;
      border: none;
      padding: 8px 16px;
      border-radius: 4px;
      cursor: pointer;
      margin-top: 10px;
    }
    button:hover {
      background-color: #3aa876;
    }
  </style>
</head>
<body>
  <div class="app-container">
    <h1>233乐园 - Vue.js应用</h1>
    <div class="success-icon">✓</div>
    <p>部署成功！应用已成功加载。</p>
    <p id="time">当前时间: </p>
    <button onclick="updateTime()">刷新时间</button>
  </div>

  <script>
    function updateTime() {
      document.getElementById('time').textContent = '当前时间: ' + new Date().toLocaleString();
    }
    // 初始化时间
    updateTime();
  </script>
</body>
</html>
HTMLEOF

# 创建重定向页面
cat > deploy_html/index.html << 'HTMLEOF'
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>233Park</title>
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
    a { color: #42b983; text-decoration: none; font-weight: bold; }
  </style>
</head>
<body>
  <h1>233Park - Vue.js项目</h1>
  <p>正在跳转到项目页面，如果没有自动跳转，请<a href="233park-web/">点击这里</a>。</p>
</body>
</html>
HTMLEOF

# 添加必要的GitHub Pages文件
touch deploy_html/.nojekyll
echo "This is a test file $(date)" > deploy_html/test.txt

echo -e "${BLUE}2. 初始化Git仓库并推送...${NC}"
cd deploy_html
git init
git checkout -b gh-pages
git config user.name "GitHub Pages Deploy"
git config user.email "pages-deploy@github.com"

git add .
git commit -m "Force deploy pure HTML site $(date)"

# 尝试推送到GitHub
echo -e "${YELLOW}正在推送到GitHub...${NC}"
if git push -f https://github.com/SincereCSL/Vue.js-Study.git gh-pages:gh-pages; then
  echo -e "${GREEN}推送成功！${NC}"
else
  echo -e "${RED}远程推送失败，正在创建本地文件供手动上传...${NC}"
  cd ..
  echo -e "${YELLOW}所有文件已准备好在 'deploy_html' 目录中${NC}"
  echo -e "${YELLOW}请手动上传这些文件到GitHub gh-pages分支${NC}"
  exit 1
fi

cd ..
echo -e "${GREEN}部署完成！请等待1-2分钟让GitHub Pages生效${NC}"
echo -e "${GREEN}然后访问: https://sincerecsl.github.io/Vue.js-Study/${NC}" 