document.addEventListener("DOMContentLoaded", function() {
    var volumeSlider = document.querySelector('.volume');
    document.getElementById("defaultOpen").click();

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


    /* Tabs */
    var tabs = document.querySelector('.tab-header');
    tabs.addEventListener("click", function(e) {
      if (e.target.classList.contains("tablinks")) {
        openTab(e, e.target.innerText);
      }
    });
    document.getElementById("defaultOpen").click();

    function openTab(evt, tabName) {
      var i, tabcontent, tablinks;

      // Hide all tabs
      tabcontent = document.querySelectorAll(".tab-content");
      for (i = 0; i < tabcontent.length; i++) {
          tabcontent[i].style.display = "none";
      }

      // Remove the class "active" from tablinks
      tablinks = document.querySelectorAll(".tablinks");
      for (i = 0; i < tablinks.length; i++) {
          tablinks[i].classList.remove("active");
      }

      // Show current tab and add "active" class to the button that opened the tab
      document.getElementById(tabName).style.display = "block";
      evt.target.classList.add("active");
    }


});
