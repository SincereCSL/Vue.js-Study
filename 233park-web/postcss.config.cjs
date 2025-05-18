module.exports = {
  plugins: {
    'postcss-pxtorem': {
      rootValue: 37.5, // 根据设计稿的宽度除以10来设置
      propList: ['*'],
      selectorBlackList: ['.norem'] // 过滤掉.norem-开头的class，不进行rem转换
    }
  }
}; 