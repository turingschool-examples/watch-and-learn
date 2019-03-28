import { Controller } from 'stimulus'

export default class extends Controller {

  showPlaylistForm(event) {
    event.preventDefault();

    var elem = document.getElementById("new-playlist-form");
    var getHeight = function () {
      elem.style.display = 'block';
      var height = elem.scrollHeight + 'px';
      elem.style.display = '';
      return height;
    };

    var height = getHeight();
    elem.classList.add('is-visible');
    elem.style.height = height;

    window.setTimeout(function () {
      elem.style.height = '';
    }, 350);
  }

  showTutorialForm(event) {
    event.preventDefault();

    var elem = document.getElementById("new-tutorial-form");
    var getHeight = function () {
      elem.style.display = 'block';
      var height = elem.scrollHeight + 'px';
      elem.style.display = '';
      return height;
    };

    var height = getHeight();
    elem.classList.add('is-visible');
    elem.style.height = height;

    window.setTimeout(function () {
      elem.style.height = '';
    }, 350);
  }
}
