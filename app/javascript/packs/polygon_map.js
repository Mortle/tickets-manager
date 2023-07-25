import { map as createMap, tileLayer, polygon } from 'leaflet';

document.addEventListener('turbo:load', () => {
  console.log('active');
  const mapElement = document.getElementById('map');

  if (mapElement) {
    // Get the polygon data from the data attribute
    const polygonData = JSON.parse(mapElement.dataset.polygon);
    const polygonCoordinates = polygonData.map(point => [point[1], point[0]]); // Leaflet expects [lat, lng]

    // Calculate the center of the polygon to center the map
    const latSum = polygonCoordinates.reduce((sum, coords) => sum + coords[0], 0);
    const lngSum = polygonCoordinates.reduce((sum, coords) => sum + coords[1], 0);
    const center = [latSum / polygonCoordinates.length, lngSum / polygonCoordinates.length];

    const map = createMap(mapElement).setView(center, 13);

    tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(map);

    polygon(polygonCoordinates).addTo(map);
  }
});
