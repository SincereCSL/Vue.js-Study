#!/bin/bash

# 进入233park-web目录
cd 233park-web

# 安装依赖
npm ci

# 构建项目
npm run build

# 返回根目录
cd ..

# 确保有.nojekyll文件
touch .nojekyll
touch 233park-web/dist/.nojekyll

# 输出成功信息
echo "构建完成，现在可以部署到GitHub Pages了" 