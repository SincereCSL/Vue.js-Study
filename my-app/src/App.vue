<template>
  <div id="app">
    {{msg}}
    <div>
      <input type="text" v-model="info">
      <button @click="handleClick">添加</button>
    </div>
    <ul>
      <!--<li v-for="item in list">{{item}}</li>-->
      <todo-item v-for="item in list" :key="item">
        <!--vue.js 2.6语法
         插槽
         具名插槽
        -->
        <template v-slot:item="itemProps"><!--作用域插槽-->
          <span :style="{fontSize:'20px',color:itemProps.checked ? 'red' : 'blue'}">{{item}}</span>
        </template>
        <!--vu.s 2.5语法-->
        <!--<span slot="item" style="font-size: 20px">{{item}}</span>-->
      </todo-item>
    </ul>
  </div>
</template>

<script>
    import TodoItem from './components/TodoItem.vue'

    export default {
        name: 'app',
        data() {
            return {
                msg: "this is vue",
                info: '',
                list: [],
            }
        },
        methods: {
            handleClick() {
                this.list.push(this.info);
                this.info = ''
            }
        },
        components: {
            TodoItem,
        }
    }
</script>

<style>
  /*#app {*/
  /*font-family: 'Avenir', Helvetica, Arial, sans-serif;*/
  /*-webkit-font-smoothing: antialiased;*/
  /*-moz-osx-font-smoothing: grayscale;*/
  /*text-align: center;*/
  /*color: #2c3e50;*/
  /*margin-top: 60px;*/
  /*}*/
</style>
