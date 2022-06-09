import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static values = { userId: Number }
  static targets = ["popup"]

  connect() {

    // const video = document.querySelector('canvas');
    // console.log(video);
    // video.style = "width: 10vw !important;"
    // // A video's MediaStream object is available through its srcObject attribute
    // const mediaStream = video.captureStream();
    // console.log(mediaStream);
    // // Through the MediaStream, you can get the MediaStreamTracks with getTracks():
    // const tracks = mediaStream.getVideoTracks();
    // console.log(tracks);
    // // Tracks are returned as an array, so if you know you only have one, you can stop it with:

    // // Or stop all like so:
    // tracks.forEach(track => track.stop())

      // this.element.querySelector('iframe').setAttribute("height", "300")
      // this.element.querySelector('iframe').setAttribute("width", "300")
  }
}
