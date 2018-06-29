var player;

document.addEventListener("DOMContentLoaded", function() {

  // Check that we are on a room page
  if (document.getElementById('ytplayer') != null) {

    // Load the IFrame Player API code asynchronously.
    var tag = document.createElement('script');
    tag.src = "https://www.youtube.com/player_api";
    var firstScriptTag = document.getElementsByTagName('script')[0];
    firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

    var duration;
    var vidClock;

    var url = document.querySelector('#video-url').innerText.substr(4);
    if (!url) {
      url = 'cVzkJFZEv78';
    }

    window.onYouTubePlayerAPIReady = function() {
      player = new YT.Player('ytplayer', {
        height: '360',
        width: '640',
        videoId: url,
        playerVars: {
          controls: 0,
          disablekb: 1,
          rel: 0
        },
        events: {
          'onReady': onPlayerReady,
          'onStateChange': onPlayerStateChange
        }
      });

      // 4. The API will call this function when the video player is ready.
      function onPlayerReady(event) {
        player.addEventListener('onStateChange', function(state) {
          handleState(state.data);
        });
        document.getElementById( "title" ).innerText = player.getVideoData().title;
      }

      // 5. The API calls this function when the player's state changes.
      //    The function indicates that when playing a video (state=1),
      //    the player should play for six seconds and then stop.
      function onPlayerStateChange(event) {
        document.getElementById( "title" ).innerText = player.getVideoData().title;
      }
    };

    function handleState(state) {
      var seekSlider = document.querySelector('.progress');
      var seekContainer = document.querySelector('.progress-container');
      if (state == 1) {
        duration = player.getDuration();
        var prevTime = 0;
        var elapsed = 0;
        vidClock = setInterval(function() {
          elapsed += 0.05;
          if (state == 1) {
            var time = player.getCurrentTime();
            if (time != prevTime) {
              elapsed = time;
              prevTime = time;
              var timer = document.querySelector('#time');
              timer.innerHTML = getTime(time);
            }
            var percent = (elapsed / duration);
            seekSlider.setAttribute("style", "flex-grow: " + (percent + 0.011)); // to fix animation with border radius
          }
        }, 50);
      } else {
        clearInterval(vidClock);
      }
    }

    function getTime(time) {
        var hours = ~~(time / 3600);
        var mins = ~~((time % 3600) / 60);
        var secs = ~~(time % 60);

        var output = "";

        if (hours > 0) {
            output += "" + hours + ":" + (mins < 10 ? "0" : "");
        }

        output += "" + mins + ":" + (secs < 10 ? "0" : "");
        output += "" + secs;
        return output;
    }

  } // end check room page

}); // end DOMContentLoaded
