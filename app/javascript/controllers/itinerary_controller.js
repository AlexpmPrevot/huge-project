import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    coordinates: Array,
    startPoint: String,
    endPoint: String,
  }



  connect() {
    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })



    this.#addMarkersToMap()
    this.#fitMapToMarkers()
    if (this.map.loaded()) {
      this.getRoute()
    }

  }


  getRoute() {
    // make a directions request using cycling profile
    // an arbitrary start will always be the same
    // only the end or destination will change
    fetch(
      `https://api.mapbox.com/directions/v5/mapbox/walking/${this.startPointValue};${this.endPointValue}?radiuses=unlimited;unlimited&geometries=geojson&access_token=${this.apiKeyValue}`,
      { method: 'GET' }
    ).then((response) => {
      return response.json()
    }).then((data) => {

     return data.routes[0].geometry.coordinates
    }).then((coordinates) => {
      this.displayItinerary(coordinates)
    })

  }

  displayItinerary(coordinates) {

    const geojson = {
      type: 'Feature',
      properties: {},
      geometry: {
        type: 'LineString',
        coordinates: coordinates
      }
    };
    // if the route already exists on the map, we'll reset it using setData
    if (this.map.getSource(geojson)) {
      this.map.getSource(geojson).setData(json);
    }

    else {

      this.map.addLayer({
        id: 'route',
        type: 'line',
        source: {
          type: 'geojson',
          data: geojson
        },
        layout: {
          'line-join': 'round',
          'line-cap': 'round'
        },
        paint: {
          'line-color': '#3887be',
          'line-width': 5,
          'line-opacity': 0.75
        }
      });
    }
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
