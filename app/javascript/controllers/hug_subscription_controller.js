import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static values = { hugId: Number }
  static targets = ["messages"]

  connect() {
    console.log(`Subscribe to the chatroom with the id ${this.chatroomIdValue}.`)
  }
}
