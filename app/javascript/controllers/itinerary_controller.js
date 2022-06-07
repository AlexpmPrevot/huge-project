import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    coordinates: Array,
    startPoint: String,
    endPoint: String,
    hugId: Number,
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })
    this.map.on('load', this.getRoute.bind(this))
    this.#addMarkersToMap()
    this.#fitMapToMarkers()
    this.getMarkersdata()
  }

  getRoute() {
    fetch(
      `https://api.mapbox.com/directions/v5/mapbox/walking/${this.startPointValue};${this.endPointValue}?radiuses=unlimited;unlimited&geometries=geojson&access_token=${this.apiKeyValue}`,
      { method: 'GET' }
    ).then((response) => {
      return response.json()
    }).then((data) => {
      console.log(data)
     return data.routes[0]

    }).then((route) => {
      this.displayInstructions(route)
      const coordinates = route.geometry.coordinates
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

    displayInstructions(route) {
      const instructions = document.getElementById('instructions');
      const steps = route.legs[0].steps;

      let tripInstructions = '';
      for (const step of steps) {
        tripInstructions += `<li>${step.maneuver.instruction}</li>`;
      }
      instructions.innerHTML = `<p style="color: black;"><strong>Trip duration: ${Math.floor(
        route.duration / 60
      )} min 🚶🏻</strong></p>`;
    }




    #addMarkersToMap = () => {

    this.markersValue.forEach((marker) => {
      const existingMarker = this.map._markers.find(m => m._element.id === `${marker.user_id}`  )
      if (existingMarker) {
        existingMarker.remove()
      }
      const popup = new mapboxgl.Popup().setHTML(marker.info_window)
      const customMarker = document.createElement("div")
      customMarker.className = "marker"
      customMarker.id = `${marker.user_id}`
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


    getMarkersdata() {
      fetch(`/hugs/${this.hugIdValue}`,
                    {headers: { "contentType": 'application/json',
                    "accept": 'application/json'}})
                    .then((response) => response.json())
                    .then((data) => {
                      this.markersValue = data
                      this.#addMarkersToMap()
                      setTimeout( this.getMarkersdata.bind(this)
                      , 2000);
                    })



    }
  }
