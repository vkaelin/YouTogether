document.addEventListener("DOMContentLoaded", function() {

  window.addEventListener('scroll', function() {
    var header = document.querySelector('.banner');
    if (window.scrollY > 50) {
      header.firstElementChild.className = 'global-header-animated';
    } else {
      header.firstElementChild.className = 'global-header-basic';
    }
  });

});
