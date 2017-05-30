$(document).ready(function() {
  $(".play-btn").click(function(e) {
    $(".hidden-player").append('<iframe class="smpadded" width="80%" height="0" scrolling="yes" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/users/207967430&amp;color=e73531&amp;auto_play=true&amp;hide_related=true&amp;show_comments=false&amp;show_user=false&amp;show_reposts=false&amp;show_artwork=false"></iframe>')
    $(this).hide();
    $(".pause-btn").show();
  });
  $(".pause-btn").click(function(e) {
    $(".hidden-player").empty();
    $(this).hide();
    $(".play-btn").show();
  });
});
