import { WS_ADDRESS } from "../configs";
export function useWebSocket() {
  const ws = new WebSocket(WS_ADDRESS)

  const init = () =>{
    bindEvent();
  }

  function bindEvent(){
    ws.addEventListener('open',handleOpen,false)
    ws.addEventListener('close',handleClose,false)
    ws.addEventListener('error',handleError,false)
    ws.addEventListener('message ',handleMessage,false)
  }

  function handleOpen(event:any){
    console.log("WebSocket is open now.",event);
  }
  function handleClose(event:any){
    console.log("WebSocket is close now.",event);
  }
  function handleError(event:any){
    console.log("WebSocket is error now.",event);
  }
  function handleMessage(event:any){
    console.log("WebSocket is message now.",event);
  }
  init();
  return ws;
}
