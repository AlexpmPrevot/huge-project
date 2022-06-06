import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ['form', 'latitude', 'longitude']
  static values = {
    userid: String
  }

  connect() {
    this.getGeoloc()
    if (window.location.pathname.toString().includes("/hugs/")) {
        const duration = 3000
        return setTimeout(this.getGeoloc.bind(this) , duration);
      } else {
        const duration = 30000
      }
      setTimeout(this.getGeoloc.bind(this) , duration);

  }

  getGeoloc() {

    navigator.geolocation.getCurrentPosition((position) => {
      const lat = position.coords.latitude;
      const long = position.coords.longitude;
    this.latitudeTarget.value = lat
    this.longitudeTarget.value = long
    this.formTarget.submit()
    console.log('send coords');

    })
  }
}
