App.rooms = App.cable.subscriptions.create("RoomsChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {

    console.log("RECIEVED");

    var activeRoom = document.querySelector("[data-behavior='messages'][data-room-id='" + data.room_id + "']");
    console.log(activeRoom);

    if(activeRoom != null) {
      console.log("APPEND");
      activeRoom.innerHTML += data.message;
      var messagesContainer = document.querySelector('.messages');
      messagesContainer.scrollTop = messagesContainer.scrollHeight; // scroll to last messages
    } else {
      var otherRoom = document.querySelector("[data-behavior='room-link'][data-room-id='" + data.room_id + "']");
      otherRoom.style.fontWeight = 'bold';
    }

  },

  send_message: function(room_id, message) {
    return this.perform("send_message", {
      room_id: room_id,
      content: message
    });
  }

});
