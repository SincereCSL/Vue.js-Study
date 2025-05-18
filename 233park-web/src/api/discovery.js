import request from './request'

/**
 * 获取发现页数据
 * @param {Object} params 
 * @param {string} params.type - 数据类型：recommend(推荐) / game(游戏)
 * @param {number} params.page - 页码
 * @param {number} params.pageSize - 每页数量
 */
export function getDiscoveryList(params) {
  return request({
    url: '/api/discovery',
    method: 'get',
    params
  })
} 