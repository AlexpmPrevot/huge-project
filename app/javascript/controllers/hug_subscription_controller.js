import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static values = { userId: Number }
  static targets = ["popup"]

  connect() {
    // console.log(`Subscribe to the hug with the id ${this.userIdValue}.`)
    this.channel = consumer.subscriptions.create(
      { channel: "HugChannel", id: this.userIdValue },
      { received: (data) => {
        this.popupTarget.insertAdjacentHTML("beforeend", data)
        }
      }
    )
  }
}
