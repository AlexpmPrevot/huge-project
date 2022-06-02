import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static values = { userId: Number }
  static targets = ["popup"]

  displayPopup(event) {
    console.log("test popup")
  }

  connect() {
    console.log(`Subscribe to the hug with the id ${this.userIdValue}.`)
    this.channel = consumer.subscriptions.create(
      { channel: "HugChannel", id: this.userIdValue },
      { received: (data) => {
        console.log(this.popupTarget)
        this.popupTarget.insertAdjacentHTML("beforeend", data)
        }
      }
    )
  }
}
