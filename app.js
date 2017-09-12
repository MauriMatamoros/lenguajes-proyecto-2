let fs = require('fs');
let stream = fs.createWriteStream("knowledgeBase.pl");

let places = [
  'tegucigalpa',
  'tokyo',
  'washington',
  'berlin',
  'toronto',
  'amsterdam',
  'beijing',
  'rome',
  'havanna',
  'chicago',
  'houston',
  'roatan',
  'london',
  'paris',
  'munich',
  'moscow',
  'warsaw',
  'istanbul',
  'madrid',
  'barcelona'
];

let days = [
  'sunday',
  'monday',
  'tuesday',
  'wednesday',
  'thursday',
  'friday',
  'saturday'
];

let airlines = [
  'taca',
  'spirit',
  'continental',
  'delta',
  'lufthansa',
  'united',
  'emirates',
  'avianca',
  'luxair',
  'finnair'
];

let flights = [];
let randomPlaceOfDepartureNumber;
let randomPlaceOfArrivalNumber;
let randomDepartureTime;
let randomArrivalTime
let randomDayNumber;
let randomAirlineNumber;
let randomFlightNumber;
let price;

let differentNumber = (x, y, z) => {
  while (x === y) {
    y = Math.floor(Math.random() * z);
  }
  return y;
};

stream.once('open', (fd) => {
  for (let i = 0; i < 1000; i++) {
    randomPlaceOfDepartureNumber = Math.floor(Math.random() * 20);
    randomPlaceOfArrivalNumber = Math.floor(Math.random() * 20);
    randomDepartureTime = Math.floor(Math.random() * 24);
    randomArrivalTime = Math.floor(Math.random() * 24);
    randomDayNumber = Math.floor(Math.random() * 7);
    randomAirlineNumber = Math.floor(Math.random() * 10);
    randomFlightNumber = Math.floor(Math.random() * 3000);
    price = Math.floor(Math.random() * 2000);
    if (randomPlaceOfDepartureNumber === randomPlaceOfArrivalNumber) {
      randomPlaceOfArrivalNumber = differentNumber(randomPlaceOfArrivalNumber, randomPlaceOfDepartureNumber, 20)
    }
    if (randomArrivalTime === randomDepartureTime) {
      randomDepartureTime = differentNumber(randomArrivalTime, randomDepartureTime, 24)
    }
    stream.write(`flight(${places[randomPlaceOfDepartureNumber]}, ${places[randomPlaceOfArrivalNumber]}, ${randomDepartureTime}, ${randomArrivalTime}, ${days[randomDayNumber]}, ${airlines[randomAirlineNumber]}, ${randomFlightNumber}, ${price}).\n`);
  }
  stream.end();
  console.log('Knowledge Base Created');
});
