$(document).ready(function() {
  $(".play-btn").click(function(e) {
    $(".play-btn").not(this).show();
    $(".pause-btn").not(this).hide();
    var soundcloud = $(this).data("soundcloud");
    var id = $(this).data("id");
    $("#player-" + id).append('<iframe width="80%" height="0" scrolling="yes" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A%2F%2Fapi.soundcloud.com%2F' + soundcloud + '&amp;color=e73531&amp;auto_play=true&amp;hide_related=true&amp;show_comments=false&amp;show_user=false&amp;show_reposts=false&amp;show_artwork=false"></iframe>')
    $("#play-btn-" + id).toggle();
    $("#pause-btn-" + id).toggle();
    $('#bars-' + id).toggle();
    $('.bars').not($('#bars-' + id)).hide();
  });
  $(".pause-btn").click(function(e) {
    $('#bars-' + id).toggle();
    $(".pause-btn").not(this).hide();
    $(".play-btn").show();
    var id = $(this).data("id");
    $(".hidden-player").empty();
    $("#pause-btn-" + id).toggle();
    $('#bars-' + id).toggle();
  });
});
