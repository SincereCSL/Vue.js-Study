# 233乐园社区发现页

基于Vue 3 + Vite实现的仿233乐园社区发现页面，实现了上拉加载、下拉刷新和瀑布流布局效果。

## 功能特点

- 上拉加载更多
- 下拉刷新
- 瀑布流布局（双列自适应）
- 视频内容支持播放
- 支持不同数据类型切换（通过URL参数）

## 在线体验

可以通过GitHub Pages访问此项目：

1. 推荐数据（默认）: `https://<你的用户名>.github.io/233Park/`
2. 游戏圈数据: `https://<你的用户名>.github.io/233Park/?type=game`

## 安装和运行

1. 安装依赖
```bash
npm install
```

2. 开发模式运行
```bash
npm run dev
```

3. 打包
```bash
npm run build
```

## 部署方式

项目已配置GitHub Actions自动部署到GitHub Pages：

1. Fork本仓库到你的GitHub账号下
2. 在仓库设置中启用GitHub Pages，选择GitHub Actions作为源
3. 推送代码到main分支，GitHub Actions将自动构建并部署

## 技术栈

- Vue 3 (Composition API)
- Vant UI
- Axios
- Mock.js
- PostCSS (移动端适配)

# Vue 3 + Vite

This template should help get you started developing with Vue 3 in Vite. The template uses Vue 3 `<script setup>` SFCs, check out the [script setup docs](https://v3.vuejs.org/api/sfc-script-setup.html#sfc-script-setup) to learn more.

Learn more about IDE Support for Vue in the [Vue Docs Scaling up Guide](https://vuejs.org/guide/scaling-up/tooling.html#ide-support).
