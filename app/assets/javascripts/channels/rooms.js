App.rooms = App.cable.subscriptions.create("RoomsChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    var playerId = document.querySelector('#ytplayer').getAttribute('data-room-id');
    if (playerId == data.room_id && data.control != undefined) {
      if (data.control == 'play') {
        player.playVideo();
      } else if (data.control == 'pause') {
        player.pauseVideo();
      } else if (data.control == 'sync') {
        player.seekTo(0);
        var syncInfo = document.querySelector('#is-sync');
        syncInfo.innerHTML = '<i class="fa fa-check"></i> Sync!';
        syncInfo.className = 'btn--primary';
      } else if (data.control.includes("url:")) {
        player.loadVideoById(data.control.substr(4));
      } else {
        var progressBar = document.querySelector('.progress-container');
        player.seekTo(parseFloat(data.control) * player.getDuration() / progressBar.offsetWidth);
      }
      return;
    } // End of video controllers

    var activeRoom = document.querySelector("[data-behavior='messages'][data-room-id='" + data.room_id + "']");
    if(activeRoom != null) {
      activeRoom.innerHTML += data.message;
      var messagesContainer = document.querySelector('.messages');
      messagesContainer.scrollTop = messagesContainer.scrollHeight; // scroll to last messages
    } else {
      var otherRoom = document.querySelector("[data-behavior='room-link'][data-room-id='" + data.room_id + "']");
      otherRoom.style.fontWeight = 'bold';
      if (!window.star) {
        otherRoom.innerText += '*';
        window.star = true;
      }
    }

  },

  send_message: function(room_id, message) {
    return this.perform("send_message", {
      room_id: room_id,
      content: message
    });
  },

  video_controllers: function(room_id, message) {
    return this.perform("video_controllers", {
      room_id: room_id,
      control: message
    });
  }

});
