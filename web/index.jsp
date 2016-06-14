
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>Websocket connection test</title>
  </head>
  <script type="text/javascript">
    var websocket;

    function isConnected() {
      return (websocket != undefined && (websocket.readyState == 1 || websocket.readyState == 2));
    }

    function connect() {
      if(isConnected()) {
        console.log('already connected');
        return;
      }

      websocket = new WebSocket('ws://' + document.location.host + '/webs/channel');

      websocket.onopen = function() {
        console.log('connection established');
        document.getElementById('closeconn').style.display = 'block';
        document.getElementById('openconn').style.display = 'none';
      }

      websocket.onerror = function (evt) {
        console.log('websocket error');
        console.log(evt.data);
      }

      websocket.onmessage = function(evt) {
        alert(evt.data);
      };

    }

    function terminateWebsocketConnection() {
        if(websocket != undefined) {
          websocket.close();
          document.getElementById('openconn').style.display = 'block';
          document.getElementById('closeconn').style.display = 'none';
        }
    }

    function sendmessage(data) {
      if(isConnected()) {
        websocket.send(data);
      } else {
        console.log('could not send message. websocket connection is not ready.')
      }
    }


  </script>


  <body>
  <a href="#" onclick="connect()" id="openconn">click to open websocket connection</a>
  <a href="#" onclick="terminateWebsocketConnection()" id="closeconn" style="display:none">click to terminate websocket connection</a>

  <br/>

  <input type="button" onclick="sendmessage('asd')" value="send a message"/>
  </body>
</html>
