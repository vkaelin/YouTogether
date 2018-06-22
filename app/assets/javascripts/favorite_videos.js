FavoriteVideos = {};

FavoriteVideos.removeFavorite = function(favoriteId) {
  document.getElementById("favorite-" + favoriteId).parentElement.remove();
};
