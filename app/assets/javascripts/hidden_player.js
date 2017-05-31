$(document).ready(function() {
  $(".play-btn").click(function(e) {
    var soundcloud = $(this).data("soundcloud");
    var id = $(this).data("id");
    $("#player-" + id).append('<iframe width="80%" height="0" scrolling="yes" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/users/' + soundcloud + '&amp;color=e73531&amp;auto_play=true&amp;hide_related=true&amp;show_comments=false&amp;show_user=false&amp;show_reposts=false&amp;show_artwork=false"></iframe>')
    $("#play-btn-" + id).toggle();
    $("#pause-btn-" + id).toggle();
  });
  $(".pause-btn").click(function(e) {
    var id = $(this).data("id");
    $(".hidden-player").empty();
    $("#pause-btn-" + id).toggle();
    $("#play-btn-" + id).toggle();
  });
});
