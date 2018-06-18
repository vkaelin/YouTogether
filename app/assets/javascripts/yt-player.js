var player;

document.addEventListener("DOMContentLoaded", function() {

  // Load the IFrame Player API code asynchronously.
  var tag = document.createElement('script');
  tag.src = "https://www.youtube.com/player_api";
  var firstScriptTag = document.getElementsByTagName('script')[0];
  firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

  // Replace the 'ytplayer' element with an <iframe> and
  // YouTube player after the API code downloads.

  var duration;
  var vidClock;
  // var url = $('#video-url').text().substr(4);
  // console.log("URL BEFORE CHECK : " + url);
  // if (!url) {
    url = 'JTCinZpPeOU';
  // }
  // console.log("URL FINAL : " + url);

  window.onYouTubePlayerAPIReady = function() {
    player = new YT.Player('ytplayer', {
      height: '360',
      width: '640',
      videoId: url,
      playerVars: {
        controls: 0,
        disablekb: 1
      },
      events: {
        'onReady': onPlayerReady,
        'onStateChange': onPlayerStateChange
      }
    });

    // 4. The API will call this function when the video player is ready.
    function onPlayerReady(event) {
      // event.target.playVideo();
      player.addEventListener('onStateChange', function(state) {
        handleState(state.data);
      });
      document.getElementById( "title" ).innerText = player.getVideoData().title;
    }

    // 5. The API calls this function when the player's state changes.
    //    The function indicates that when playing a video (state=1),
    //    the player should play for six seconds and then stop.
    var done = false;
    function onPlayerStateChange(event) {
      // if (event.data == YT.PlayerState.PLAYING && !done) {
      //   setTimeout(stopVideo, 6000);
      //   done = true;
      // }
      document.getElementById( "title" ).innerText = player.getVideoData().title;
    }
    function stopVideo() {
      player.stopVideo();
    }

    // var pauseButton = document.querySelector('#pause');
    // pauseButton.addEventListener('click', function() {
    //   player.pauseVideo();
    // });
    //
    // var playButton = document.querySelector('#play');
    // playButton.addEventListener('click', function() {
    //   player.playVideo();
    // });

    // var progressBar = document.querySelector('.progress-container');
    // progressBar.addEventListener('click', function(e) {
    //   console.log(e.pageX);
    //   console.log("TOTAL:" + progressBar.offsetWidth);
    //   player.seekTo(e.pageX * player.getDuration() / progressBar.offsetWidth);
    // });
  }

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
          seekSlider.setAttribute("style", "transform: scaleX(" + percent + ")");
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

});
