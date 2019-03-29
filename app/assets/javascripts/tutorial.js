var player;
var position;
function onYouTubePlayerAPIReady() {
  player = new YT.Player('player', {
    width: '640',
    height: '390',
    videoId: '<%= @presenter.current_video.video_id %>',
    events: {
      onReady: onPlayerReady,
      onStateChange: onPlayerStateChange
    }
  });
}

// autoplay video
function onPlayerReady(event) {
  event.target.playVideo();
}

// when video ends
function onPlayerStateChange(event) {
  if(event.data === 0 && <%= @presenter.play_video %>) {
    window.location = "/tutorials/<%=@presenter.id%>?video_id=<%=@presenter.next_video%>";
  } else if(event.data === 0 && <%= @presenter.play_video == false %>) {
    const message = document.querySelector(`#message`);
    message.innerHTML = "You watched them all. Bask in the glory of your new skills."
  }
}


function showFormForPlayListId() {
  console.log('hello world!')
  document.querySelector('.playlist-id').style.display = 'block';
}
