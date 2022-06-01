import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ['form', 'latitude', 'longitude']
  static values = {
    userid: String
  }

  connect() {



    this.getGeoloc()



}

  getGeoloc() {

    navigator.geolocation.getCurrentPosition((position) => {
      const lat = position.coords.latitude;
      const long = position.coords.longitude;
      console.log(lat)
      console.log(long)
    this.latitudeTarget.value = lat
    this.longitudeTarget.value = long
    console.log(this.formTarget);
    this.formTarget.submit()

  })

  setTimeout(this.getGeoloc.bind(this) , 30000);


  }

}





// controller stimulus
// connect avec une fontion qui appel
// getCurrentPosition()
// fetch les coordonnées en db POST
// inserer toutes les 10 sec (timeout)
