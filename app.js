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
let destinations = [];
for (let i = 0; i < places.length; i++) {
  if (i < 15 ) {
    destinations.push(
      {
        from: places[i],
        to: [places[i+1], places[i+2], places[i+3], places[i+4], places[i+5]]
      }
    );
  }else {
    if (i === 15) {
      destinations.push(
        {
          from: places[i],
          to: [places[i+1], places[i+2], places[i+3], places[i+4], places[0]]
        }
      );
    }else if (i === 16) {
      destinations.push(
        {
          from: places[i],
          to: [places[i+1], places[i+2], places[i+3], places[0], places[1]]
        }
      );
    }else if (i === 17) {
      destinations.push(
        {
          from: places[i],
          to: [places[i+1], places[i+2], places[0], places[1], places[2]]
        }
      );
    }else if (i === 18) {
      destinations.push(
        {
          from: places[i],
          to: [places[i+1], places[0], places[1], places[2], places[3]]
        }
      );
    }else if (i === 19) {
      destinations.push(
        {
          from: places[i],
          to: [places[0], places[1], places[2], places[3], places[4]]
        }
      );
    }else{
      destinations.push(
        {
          from: places[i],
          to: [places[0], places[1], places[2], places[3], places[4]]
        }
      );
    }
  }
}
let counter = 0;
destinations.forEach((destination) => {
  console.log(counter);
  console.log(destination.from);
  for (let i = 0; i < destination.to.length; i++) {
    counter++;
    console.log(destination.to[i]);
  }
});

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
let usedFlightNumbers = [];

let differentFlightNumbers = (a, b) => {
  b.forEach((c) => {
    while (a === c) {
      a = Math.floor(Math.random() * 3000);
    }
  });
  return a;
};

let differentNumber = (x, y, z) => {
  while (x === y) {
    y = Math.floor(Math.random() * z);
  }
  return y;
};

stream.once('open', (fd) => {
  for (let i = 0; i < 1000; i++) {
    randomPlaceOfDepartureNumber = Math.floor(Math.random() * 20);
    randomPlaceOfArrivalNumber = Math.floor(Math.random() * 5);
    randomDepartureTime = Math.floor(Math.random() * 24);
    randomArrivalTime = Math.floor(Math.random() * 24);
    randomDayNumber = Math.floor(Math.random() * 7);
    randomAirlineNumber = Math.floor(Math.random() * 10);
    randomFlightNumber = Math.floor(Math.random() * 3000);
    price = (Math.floor(Math.random() * 2000)) + 1;
    if (usedFlightNumbers.length === 0) {
      usedFlightNumbers.push(randomFlightNumber);
    }else {
      randomFlightNumber = differentFlightNumbers(randomFlightNumber, usedFlightNumbers);
      usedFlightNumbers.push(randomFlightNumber);
    }
    if (randomArrivalTime === randomDepartureTime) {
      randomDepartureTime = differentNumber(randomArrivalTime, randomDepartureTime, 24)
    }
    stream.write(`flight(${destinations[randomPlaceOfDepartureNumber].from}, ${destinations[randomPlaceOfDepartureNumber].to[randomPlaceOfArrivalNumber]}, ${randomDepartureTime}, ${randomArrivalTime}, ${days[randomDayNumber]}, ${airlines[randomAirlineNumber]}, ${randomFlightNumber}, ${price}).\n`);
  }
  stream.end();
  console.log('Knowledge Base Created');
});
