import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ['form', 'latitude', 'longitude']
  static values = {
    userid: String
  }

  connect() {
    this.getGeoloc()
    let duration
    if (window.location.pathname.toString().includes("/hugs/")) {
        duration = 3000
        return setTimeout(this.getGeoloc.bind(this) , duration);
      } else {
        duration = 30000
      }
      setInterval(this.getGeoloc.bind(this) , duration);
  }

  getGeoloc() {

    navigator.geolocation.getCurrentPosition((position) => {
      const lat = position.coords.latitude;
      const long = position.coords.longitude;
    this.latitudeTarget.value = lat
    this.longitudeTarget.value = long
    this.formTarget.submit()
    })
  }
}
