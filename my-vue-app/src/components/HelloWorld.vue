<template>
  <h1>{{ count }}</h1>
  <h1>{{ showCount }}</h1>
  <comp></comp>
  <button @click="increase">👍🏻+1</button>
  <button @click="onClick">emit</button>
  <el-button type="primary">Primary</el-button>
  <el-button type="success">Success</el-button>
  <el-button type="info">Info</el-button>
  <el-button type="warning">Warning</el-button>
</template>
<script setup lang="ts">
//1、直接导入组件
import comp from "@/components/comp.vue";
import {
  defineProps,
  computed,
  ref,
  defineEmits,
  useAttrs,
  useSlots,
  defineExpose,
} from "vue";
import { useStore } from "@/store";
const store = useStore();

//2、属性定义
const props = defineProps({
  msg: String,
});
console.log(props);

//3、获取上下文

// const attrs  = useAttrs()
// console.log(attrs)

// const slots  = useSlots()
// console.log(slots)

defineExpose({
  someMethod() {
    console.log("子组件信息");
  },
});

//4、定义事件
const emit = defineEmits(["myClick"]);
const onClick = () => {
  emit("myClick");
};

const count = ref(0);
const showCount = computed(() => {
  return store.getters["getCount"];
});
const increase = () => {
  store.commit("setCount", count.value++);
};
</script>
<style scoped>
a {
  color: #42b983;
}

label {
  margin: 0 0.5em;
  font-weight: bold;
}

code {
  background-color: #eee;
  padding: 2px 4px;
  border-radius: 4px;
  color: #304455;
}
</style>
