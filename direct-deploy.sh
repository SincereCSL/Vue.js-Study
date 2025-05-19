#!/bin/bash
set -e

# 颜色输出
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}开始创建纯静态部署文件...${NC}"

# 创建纯静态站点结构
echo -e "${BLUE}1. 创建基本目录结构...${NC}"
rm -rf static_site
mkdir -p static_site/233park-web/assets

# 创建最简单的Vue应用页面
echo -e "${BLUE}2. 创建应用文件...${NC}"
cat > static_site/233park-web/index.html << EOF
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>233乐园 - Vue.js项目</title>
  <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
  <style>
    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
      max-width: 800px;
      margin: 0 auto;
      padding: 20px;
      text-align: center;
    }
    .app {
      border: 1px solid #eee;
      border-radius: 8px;
      padding: 20px;
      margin-top: 20px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    .success-icon {
      color: #42b883;
      font-size: 48px;
      margin-bottom: 20px;
    }
    h1 { color: #42b883; }
    p { line-height: 1.6; }
  </style>
</head>
<body>
  <div id="app" class="app">
    <h1>{{ title }}</h1>
    <div class="success-icon">✓</div>
    <p>{{ message }}</p>
    <p>当前时间: {{ currentTime }}</p>
    <button @click="updateTime">刷新时间</button>
  </div>

  <script>
    const { createApp, ref } = Vue;
    
    createApp({
      setup() {
        const title = ref('233乐园 - Vue.js应用');
        const message = ref('部署成功！Vue.js应用已成功加载。');
        const currentTime = ref(new Date().toLocaleString());
        
        function updateTime() {
          currentTime.value = new Date().toLocaleString();
        }
        
        return {
          title,
          message,
          currentTime,
          updateTime
        };
      }
    }).mount('#app');
  </script>
</body>
</html>
EOF

# 创建根目录重定向页面
echo -e "${BLUE}3. 创建重定向页面...${NC}"
cat > static_site/index.html << EOF
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

# 添加.nojekyll文件
touch static_site/.nojekyll

echo -e "${GREEN}静态站点文件已创建完成！${NC}"
echo -e "${GREEN}请将static_site目录中的所有文件上传到GitHub的gh-pages分支${NC}" 