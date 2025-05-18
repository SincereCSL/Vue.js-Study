# 233乐园项目GitHub Pages部署指南

本文档详细说明如何将233乐园项目部署到GitHub Pages以供在线访问。

## 前期准备

1. 拥有GitHub账号
2. 安装Git客户端
3. 本地项目已完成开发

## 部署步骤

### 1. 创建GitHub仓库

1. 登录GitHub账号
2. 点击右上角"+"图标 → "New repository"
3. 仓库名称填写"233Park"（或其他名称）
4. 设置为Public（公开）仓库
5. 点击"Create repository"创建仓库

### 2. 配置项目

1. 修改项目的vite.config.js文件，设置base为你的仓库名：
```js
export default defineConfig({
  base: '/233Park/',  // 如果仓库名不是233Park，请修改为你的仓库名
  // 其他配置...
})
```

2. 修改package.json中的homepage字段：
```json
{
  "homepage": "https://<YOUR_USERNAME>.github.io/233Park/", // 替换<YOUR_USERNAME>为你的GitHub用户名
  // 其他配置...
}
```

3. 确保已创建.github/workflows/deploy.yml文件，配置自动部署

### 3. 初始化Git仓库并推送代码

在项目根目录执行以下命令：

```bash
# 初始化Git仓库
git init

# 添加远程仓库
git remote add origin https://github.com/<YOUR_USERNAME>/233Park.git

# 添加所有文件到暂存区
git add .

# 提交更改
git commit -m "Initial commit"

# 推送到GitHub
git push -u origin main
```

### 4. 配置GitHub Pages

1. 在GitHub仓库页面，点击"Settings"
2. 在左侧菜单找到"Pages"
3. 在"Build and deployment"部分，选择"GitHub Actions"作为Source
4. GitHub Actions将自动构建和部署项目

### 5. 等待部署完成

1. 进入仓库的"Actions"选项卡查看部署进度
2. 部署完成后，你可以通过以下URL访问项目：
   - https://<YOUR_USERNAME>.github.io/233Park/
   - https://<YOUR_USERNAME>.github.io/233Park/?type=game

### 6. 验证部署

访问上面的URL，确保项目能正常运行：
- 能够正确显示发现页布局
- 能够进行上拉加载和下拉刷新
- 能够通过URL参数切换不同的数据类型

## 遇到问题和解决方法

### 问题1：样式丢失

如果访问部署后的网站发现样式丢失，请检查vite.config.js中的base配置是否与仓库名一致。

### 问题2：页面空白或404

检查部署的URL是否正确，确保仓库名大小写与配置一致。

### 问题3：无法显示图片或视频

检查资源路径是否使用了绝对路径，建议使用相对路径以适应GitHub Pages部署。

## 其他建议

- 为项目添加一个自定义域名，可以在GitHub Pages设置中配置
- 定期更新依赖以修复潜在的安全问题
- 将生产环境的mock数据替换为实际的API接口 