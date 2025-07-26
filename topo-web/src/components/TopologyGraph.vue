<template>
  <div class="topology-container">
    <div id="topology-graph" class="graph-container"></div>
  </div>
</template>

<script setup>
import { onMounted, onUnmounted } from 'vue'
import { Graph, iconfont } from '@antv/g6'

let graph = null
let currentData = null // 存储当前数据

onMounted(() => {
  const container = document.getElementById('topology-graph')
  if (!container) return
  container.innerHTML = ''

  // 1. 加载 iconfont
  const style = document.createElement('style')
  style.innerHTML = `@import url('${iconfont.css}');`
  document.head.appendChild(style)

  const width = container.scrollWidth || 1200
  const height = container.scrollHeight || 900

  // 2. 准备数据 - 只有主节点，子节点动态添加
  currentData = {
    nodes: [
      {
        id: 'ISBG-Node',
        type: 'hexagon',
        x: width / 2,
        y: height / 2,
        style: {
          size: 80,
          labelText: 'ISBG',
          labelPosition: 'bottom',
          labelOffset: 20,
          labelFill: '#fff',
          labelFontSize: 16,
          labelFontWeight: 'bold',
          fill: 'l(90) 0:#87CEEB 0.5:#3498DB 1:#1F4E79',
          stroke: '#4A90E2',
          lineWidth: 3,
          shadowColor: 'rgba(0,0,0,0.5)',
          shadowBlur: 15,
          shadowOffsetX: 8,
          shadowOffsetY: 8,
          iconFontFamily: 'iconfont',
          iconText: '\ue602',
          iconFill: 'rgba(255,255,255,0.8)',
          iconFontSize: 32,
        },
      },
    ],
    edges: [],
  }

  // 3. 创建图形的函数
  function createGraph() {
    if (graph) {
      graph.destroy()
    }

    graph = new Graph({
      container,
      width,
      height,
      data: currentData,
      node: {
        type: 'hexagon',
        style: {
          labelText: (d) => d.style?.labelText || d.id,
          labelPosition: 'bottom',
          labelOffset: (d) => d.style?.labelOffset || 15,
          labelFill: (d) => d.style?.labelFill || '#fff',
          labelFontSize: (d) => d.style?.labelFontSize || 12,
          labelFontWeight: (d) => d.style?.labelFontWeight || 'normal',
          size: (d) => d.style?.size || 50,
          fill: (d) => d.style?.fill || '#87CEEB',
          stroke: (d) => d.style?.stroke || '#4A90E2',
          lineWidth: (d) => d.style?.lineWidth || 2,
          shadowColor: (d) => d.style?.shadowColor || 'rgba(0,0,0,0.3)',
          shadowBlur: (d) => d.style?.shadowBlur || 10,
          shadowOffsetX: (d) => d.style?.shadowOffsetX || 5,
          shadowOffsetY: (d) => d.style?.shadowOffsetY || 5,
          iconFontFamily: (d) => d.style?.iconFontFamily || 'iconfont',
          iconText: (d) => d.style?.iconText || '\ue602',
          iconFill: (d) => d.style?.iconFill || 'rgba(255,255,255,0.8)',
          iconFontSize: (d) => d.style?.iconFontSize || 20,
          opacity: (d) => (d.style?.opacity !== undefined ? d.style.opacity : 1),
        },
        state: {
          hover: {
            fill: 'l(90) 0:#9FD3E7 0.5:#4AA3D8 1:#25619B',
            shadowBlur: 20,
          },
          selected: {
            stroke: '#E74C3C',
            lineWidth: 4,
          },
        },
      },
      edge: {
        style: {
          stroke: (d) => d.style?.stroke || '#4A90E2',
          lineWidth: (d) => d.style?.lineWidth || 2,
          endArrow: (d) => d.style?.endArrow !== false,
        },
      },
      behaviors: ['drag-canvas', 'zoom-canvas', 'click-select'],
      layout: {
        type: 'preset',
      },
    })

    // 4. 实现点击展开/收起功能
    let isExpanded = false

    graph.on('node:click', (e) => {
      try {
        console.log('🖱️ 节点被点击:', e)

        // 获取节点ID
        const nodeId = e.itemId || (e.item && e.item.id) || (e.target && e.target.id)
        console.log('🎯 节点ID:', nodeId)

        // 只处理主节点的点击事件
        if (nodeId !== 'ISBG-Node') {
          console.log('ℹ️ 非主节点点击，忽略')
          return
        }

        console.log('📊 当前展开状态:', isExpanded)

        if (isExpanded) {
          // 收起：删除子节点和连接线
          try {
            console.log('🔄 开始收起操作...')

            // 获取当前数据
            const graphData = graph.getData()

            // 重置数据到初始状态
            const resetData = {
              nodes: [
                {
                  id: 'ISBG-Node',
                  type: 'hexagon',
                  x: width / 2,
                  y: height / 2,
                  style: {
                    size: 80,
                    labelText: 'ISBG',
                    labelPosition: 'bottom',
                    labelOffset: 20,
                    labelFill: '#fff',
                    labelFontSize: 16,
                    labelFontWeight: 'bold',
                    fill: 'l(90) 0:#87CEEB 0.5:#3498DB 1:#1F4E79',
                    stroke: '#4A90E2',
                    lineWidth: 3,
                    shadowColor: 'rgba(0,0,0,0.5)',
                    shadowBlur: 15,
                    shadowOffsetX: 8,
                    shadowOffsetY: 8,
                    iconFontFamily: 'iconfont',
                    iconText: '\ue602',
                    iconFill: 'rgba(255,255,255,0.8)',
                    iconFontSize: 32,
                  },
                },
              ],
              edges: [],
            }

            // 更新currentData引用
            currentData.nodes = resetData.nodes
            currentData.edges = resetData.edges

            // 重新创建图形
            createGraph()

            isExpanded = false
            console.log('✅ 收起完成')
          } catch (error) {
            console.error('❌ 收起操作失败:', error)
          }
        } else {
          // 展开：添加子节点和连接线
          try {
            console.log('🔄 开始展开操作...')

            // 获取当前数据
            const graphData = graph.getData()

            // 先清理可能存在的子节点，防止重复添加
            currentData.nodes = currentData.nodes.filter((n) => n.id === 'ISBG-Node')
            currentData.edges = []

            // 修改主节点为半透明
            const mainNode = currentData.nodes.find((n) => n.id === 'ISBG-Node')
            if (mainNode) {
              mainNode.style = {
                ...mainNode.style,
                opacity: 0.3,
              }
            }

            // 添加子节点
            const subNodes = [
              {
                id: 'sub-1',
                type: 'hexagon',
                x: width / 2 + 300, // 右侧，距离主节点300像素
                y: height / 2,
                style: {
                  size: 50,
                  labelText: '节点1',
                  labelPosition: 'bottom',
                  labelFill: '#fff',
                  labelFontSize: 12,
                  fill: '#87CEEB',
                  stroke: '#4A90E2',
                  lineWidth: 2,
                  iconFontFamily: 'iconfont',
                  iconText: '\ue602',
                  iconFill: '#fff',
                  iconFontSize: 20,
                },
              },
              {
                id: 'sub-2',
                type: 'hexagon',
                x: width / 2,
                y: height / 2 - 250, // 上方，距离主节点250像素
                style: {
                  size: 50,
                  labelText: '节点2',
                  labelPosition: 'bottom',
                  labelFill: '#fff',
                  labelFontSize: 12,
                  fill: '#87CEEB',
                  stroke: '#4A90E2',
                  lineWidth: 2,
                  iconFontFamily: 'iconfont',
                  iconText: '\ue602',
                  iconFill: '#fff',
                  iconFontSize: 20,
                },
              },
              {
                id: 'sub-3',
                type: 'hexagon',
                x: width / 2 - 300, // 左侧，距离主节点300像素
                y: height / 2,
                style: {
                  size: 50,
                  labelText: '节点3',
                  labelPosition: 'bottom',
                  labelFill: '#fff',
                  labelFontSize: 12,
                  fill: '#87CEEB',
                  stroke: '#4A90E2',
                  lineWidth: 2,
                  iconFontFamily: 'iconfont',
                  iconText: '\ue602',
                  iconFill: '#fff',
                  iconFontSize: 20,
                },
              },
              {
                id: 'sub-4',
                type: 'hexagon',
                x: width / 2,
                y: height / 2 + 250, // 下方，距离主节点250像素
                style: {
                  size: 50,
                  labelText: '节点4',
                  labelPosition: 'bottom',
                  labelFill: '#fff',
                  labelFontSize: 12,
                  fill: '#87CEEB',
                  stroke: '#4A90E2',
                  lineWidth: 2,
                  iconFontFamily: 'iconfont',
                  iconText: '\ue602',
                  iconFill: '#fff',
                  iconFontSize: 20,
                },
              },
            ]

            // 添加连接线
            const subEdges = [
              {
                id: 'edge-1',
                source: 'ISBG-Node',
                target: 'sub-1',
                style: {
                  stroke: '#4A90E2',
                  lineWidth: 2,
                  endArrow: true,
                },
              },
              {
                id: 'edge-2',
                source: 'ISBG-Node',
                target: 'sub-2',
                style: {
                  stroke: '#4A90E2',
                  lineWidth: 2,
                  endArrow: true,
                },
              },
              {
                id: 'edge-3',
                source: 'ISBG-Node',
                target: 'sub-3',
                style: {
                  stroke: '#4A90E2',
                  lineWidth: 2,
                  endArrow: true,
                },
              },
              {
                id: 'edge-4',
                source: 'ISBG-Node',
                target: 'sub-4',
                style: {
                  stroke: '#4A90E2',
                  lineWidth: 2,
                  endArrow: true,
                },
              },
            ]

            // 更新currentData
            currentData.nodes = [...currentData.nodes, ...subNodes]
            currentData.edges = [...currentData.edges, ...subEdges]

            // 重新创建图形
            createGraph()

            isExpanded = true
            console.log('✅ 展开完成')
          } catch (error) {
            console.error('❌ 展开操作失败:', error)
          }
        }
      } catch (error) {
        console.error('❌ 点击处理出错:', error)
      }
    })

    graph.render()
    console.log('✅ 图形渲染完成')
  }

  // 初始创建图形
  createGraph()
})

onUnmounted(() => {
  if (graph) {
    graph.destroy()
    graph = null
  }
})
</script>

<style scoped>
.topology-container {
  width: 100vw;
  height: 100vh;
  background: linear-gradient(135deg, #0a1628 0%, #1a2a3a 100%);
  display: flex;
  justify-content: center;
  align-items: center;
}
.graph-container {
  width: 1200px;
  height: 900px;
  border: 2px solid #00d4ff;
  border-radius: 10px;
  box-shadow: 0 0 20px rgba(0, 212, 255, 0.3);
  background: rgba(255, 255, 255, 0.05);
}
</style>
