<script setup lang="ts">
import { reactive, onMounted, toRefs} from "vue";
import { useRouter } from "vue-router";
import { useWebSocket } from "../hooks/websocket";
const router = useRouter();
const ws = useWebSocket(handleMessage)
interface State {
  message: string,
  messageList: Array<any>,
}
const state: State = reactive({
  message: "",
  messageList: [],
});
const {message,messageList}  = toRefs(state)
// const [messageList] = toRefs(state.messageList)
let userName:string = '' ;
onMounted(() =>{
  userName = localStorage.getItem('userName') || "";
  if(!userName){
    router.push('/login');
    return;
  }
})
const sendMessage = () =>{
  const _message = state.message;
  if(!state.message.trim().length){
    return
  }
  state.messageList.push({
    id: Math.random(),
    user: userName,
    dateTime:new Date().getTime(),
    message:_message,
  })
  state.message = '';
}
function handleMessage(){

}
</script>
<template>
  <main>
    <ul v-for="item in state.messageList"
    :key="item.id">
      <li>
        <p>
          <span>{{item.user}}</span>
          <span>{{new Date(item.dateTime)}}</span>
        </p>
        <p>
          消息：{{item.message}}
        </p>
      </li>
    </ul>
    <el-input v-model="message"/>
    <el-button type="primary" @click="sendMessage()">发送</el-button>
  </main>
</template>
