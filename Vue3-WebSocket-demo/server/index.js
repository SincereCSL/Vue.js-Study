const WebSocket = require('ws');

;((Ws) => {
  const server = new Ws.Server({ port: 8000 });
  const init = () => {
    bindEvent();
  };

  function bindEvent() {
    server.on('open', handleOpen);
    server.on('close', handleClose);
    server.on('error', handleError);
    server.on('connection', handleConnection);
  }

  function handleOpen() {
    console.log('-------')
    console.log('WebSocket Open');
  }

  function handleClose() {
    console.log('WebSocket Close');
  }

  function handleError() {
    console.log('WebSocket Error');
  }

  function handleConnection(ws) {
    console.log('WebSocket Connection');
    ws.on('message', handleMessage);
  }

  function handleMessage(msg) {
    console.log(msg);
  }

  init();

})(WebSocket);

