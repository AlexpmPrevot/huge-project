import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "output" ]

  connect() {
    this.outputTarget.textContent = 'Hello, Stimulus!'
  }
}





// controller stimulus
// connect avec une fontion qui appel
// getCurrentPosition()
// fetch les coordonnées en db POST
// inserer toutes les 10 sec (timeout)
