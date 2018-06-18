document.addEventListener("DOMContentLoaded", function() {
    var volumeSlider = document.querySelector('.volume');

    /* Volume slider on click */
    var volumeContainer = document.querySelector('.volume-container');
    volumeContainer.addEventListener("click", function(e) {
      var offset = this.getBoundingClientRect().left;
      var volume = (e.pageX - offset) * 100 / this.offsetWidth;
      player.setVolume(volume)
      volumeSlider = document.querySelector('.volume');
      volume += 1; // to fix animation with border radius
      volumeSlider.setAttribute("style", "flex-grow: " + volume / 100);
    });


    /* Click on volume icon to mute */
    var volumeIcon = document.querySelector('.volume-icon');
    volumeIcon.addEventListener("click", function(e) {
      if (this.classList.contains("fa-volume-up")) {
        volumeIconClick(this, 0, "fa-volume-up", "fa-volume-off");
      } else {
        volumeIconClick(this, 100, "fa-volume-off", "fa-volume-up");
      }
    });

    function volumeIconClick(elem, volume, toRemove, toAdd) {
      player.setVolume(volume);
      volumeSlider.setAttribute("style", "flex-grow: " + volume / 100);
      elem.classList.remove(toRemove);
      elem.classList.add(toAdd);
    }


});
