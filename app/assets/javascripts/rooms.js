document.addEventListener('DOMContentLoaded', function() {

  // Check that we are on a room page
  if (document.getElementById('ytplayer') != null) {

    /* ------------------------------
    /*  Tabs
     * ------------------------------ */
    var tabs = document.querySelector('.tab-header');
    tabs.addEventListener('click', function(e) {
      if (e.target.classList.contains('tablinks')) {
        openTab(e, e.target.innerText);
      }
    });
    document.getElementById('defaultOpen').click();

    function openTab(evt, tabName) {
      var i, tabcontent, tablinks;
      // Hide all tabs
      tabcontent = document.querySelectorAll('.tab-content');
      for (i = 0; i < tabcontent.length; i++) {
          tabcontent[i].style.display = 'none';
      }
      // Remove the class "active" from tablinks
      tablinks = document.querySelectorAll('.tablinks');
      for (i = 0; i < tablinks.length; i++) {
          tablinks[i].classList.remove('active');
      }
      // Show current tab and add "active" class to the button that opened the tab
      document.getElementById(tabName).style.display = 'block';
      evt.target.classList.add('active');
    }


    /* ------------------------------
    /*  Reload page when changing room and changing language to render the YT player
     * ------------------------------ */
    var yourRooms = document.querySelector('.rooms-list');
    yourRooms.addEventListener('click', function(e) {
      location.reload();
    });
    var languages = document.querySelector('.languages');
    languages.addEventListener('click', function(e) {
      location.reload();
    });


    /* ------------------------------
    /*  Send messages
     * ------------------------------ */
    var roomId = document.querySelector("[data-behavior='messages']").getAttribute('data-room-id');
    var sendMessage = document.querySelector('#new_message');
    sendMessage.addEventListener('submit', function(e) {
      e.preventDefault();
      var content = document.querySelector('#message_content');
      if (content.value != '') {
        App.rooms.send_message(roomId, content.value);
        content.value = '';
      }
    });
    var messagesContainer = document.querySelector('.messages');
    messagesContainer.scrollTop = messagesContainer.scrollHeight; // Scroll to last messages


    /* ------------------------------
    /*  Volume slider on click
     * ------------------------------ */
    var volumeSlider = document.querySelector('.volume');
    var volumeContainer = document.querySelector('.volume-container');
    volumeContainer.addEventListener('click', function(e) {
      var offset = this.getBoundingClientRect().left;
      var volume = (e.pageX - offset) * 100 / this.offsetWidth;
      player.setVolume(volume)
      volumeSlider = document.querySelector('.volume');
      volume += 1; // to fix animation with border radius
      volumeSlider.setAttribute("style", "flex-grow: " + volume / 100);
    });


    /* ------------------------------
    /*  Click on volume icon to mute
     * ------------------------------ */
    var volumeIcon = document.querySelector('.volume-icon');
    volumeIcon.addEventListener('click', function(e) {
      if (this.classList.contains('fa-volume-up')) {
        volumeIconClick(this, 0, 'fa-volume-up', 'fa-volume-off');
      } else {
        volumeIconClick(this, 100, 'fa-volume-off', 'fa-volume-up');
      }
    });

    function volumeIconClick(elem, volume, toRemove, toAdd) {
      player.setVolume(volume);
      volumeSlider.setAttribute("style", "flex-grow: " + volume / 100);
      elem.classList.remove(toRemove);
      elem.classList.add(toAdd);
    }


    /* ------------------------------
    /*  Play button
     * ------------------------------ */
    var playButton = document.querySelector('#play');
    playButton.addEventListener('click', function(e) {
      App.rooms.video_controllers(roomId, 'play');
    });


    /* ------------------------------
    /*  Pause button
     * ------------------------------ */
    var pauseButton = document.querySelector('#pause');
    pauseButton.addEventListener('click', function(e) {
      App.rooms.video_controllers(roomId, 'pause');
    });


    /* ------------------------------
    /*  Sync button
     * ------------------------------ */
    var syncButton = document.querySelector('#sync');
    syncButton.addEventListener('click', function(e) {
      App.rooms.video_controllers(roomId, 'pause');
      setTimeout(() => {
        App.rooms.video_controllers(roomId, 'sync');
      }, 50);
      setTimeout(() => {
        App.rooms.video_controllers(roomId, 'play');
      }, 50);
    });

    /* ------------------------------
    /*  Video progress slider on click
     * ------------------------------ */
    var videoProgress = document.querySelector('.progress-container');
    videoProgress.addEventListener('click', function(e) {
      offset = this.getBoundingClientRect().left;
      App.rooms.video_controllers(roomId, (e.pageX - offset).toString());
    });


    /* ------------------------------
    /*  Change URL of video
     * ------------------------------ */
    var changeURL = document.querySelector('#change-url');
    changeURL.addEventListener('submit', function(e) {
      e.preventDefault();
      var content = document.querySelector('#url');
      console.log(content.value);

      regExp = /^.*(youtu\.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
      match = content.value.match(regExp);
      if (match && match[2].length == 11) {
        console.log("url:" + match[2]);
        App.rooms.video_controllers(roomId, "url:" + match[2]);
        content.value = '';
      } else {
        console.log("error in regex");
        var error = document.querySelector('#errors');
        error.style.visibility = 'visible';
        //error.classList.remove('hidden');
        setTimeout(() => error.style.visibility = 'hidden', 3000);
        //setTimeout(() => error.classList.add('hidden'), 3000);

        // $errors = $('#errors')
        // $errors.slideDown()
        // setTimeout((-> $errors.slideUp()), 3000)
      }

    });





  } // End check room page



});
