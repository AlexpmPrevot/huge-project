import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ['form', 'latitude', 'longitude', 'navbar']
  static values = {
    userid: String
  }

  connect() {



    this.getGeoloc()
    let duration
    if (window.location.pathname.toString().includes("/hugs/")) {
        duration = 2000
      } else {
        duration = 30000
      }

    setInterval(this.getGeoloc.bind(this) , duration);
    // if (window.location.pathname.toString().includes("/camera")) {
    //   this.navbarTarget.classList.add('d-none')
    //   setTimeout(window.location.reload(), 1000);
    // }


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
