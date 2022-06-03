import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
  }



  connect() {
    mapboxgl.accessToken = this.apiKeyValue
    var map
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })

    this.getItinerary()

    this.#addMarkersToMap()
    this.#fitMapToMarkers()


    this.map.addControl(
      new mapboxgl.GeolocateControl({
      positionOptions: {
      enableHighAccuracy: true
      },
      // When active the map will receive updates to the device's location as it changes.
      trackUserLocation: true,
      // Draw an arrow next to the location dot to indicate which direction the device is heading.
      showUserHeading: true
      })
      );

  }

  getItinerary() {

    const url = `https://api.mapbox.com/directions/v5/mapbox/walking/-0.5658%2C44.85%3B-0.5678%2C44.838?alternatives=true&continue_straight=true&geometries=geojson&language=en&overview=simplified&steps=true&access_token=${this.apiKeyValue}`
    fetch(url).then((response) => {
      response.json()
    })        .then((data) => {
      console.log(data)
    })




  }


  #addMarkersToMap = () => {

    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window)
      const customMarker = document.createElement("div")
      customMarker.className = "marker"
      customMarker.style.backgroundImage = `url('${marker.image_url}')`
      customMarker.style.backgroundSize = "cover"
      customMarker.style.borderRadius = "50%"
      customMarker.style.border = "2px solid #e1e1e1"
      customMarker.style.width = "35px"
      customMarker.style.height = "35px"

      if (marker.logged_in === true) {
        customMarker.style.boxShadow = "0px 0px 10px var(--bs-success)"
      }

      new mapboxgl.Marker(customMarker)
      .setLngLat([ marker.lng, marker.lat ])
      .setPopup(popup)
      .addTo(this.map)

    });
  }



  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }

}
