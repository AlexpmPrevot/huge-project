import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  // static values = { userId: Number }
  static targets = ["navbarcam"]

  connect() {
    console.log('coucou');

   if (window.location.pathname.toString().includes("camera")) {
      this.navbarcamTarget.classList.add('d-none')

    }

  }
}
