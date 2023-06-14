import '../weather/models/crop.dart';

class CropData {
  List<Crop> crops = [
    //Dodoma
    Crop(
      name: "Maize",
      location: "Dodoma",
      prices: {
        "2022-11-25 00:00:00": 59700.0,
        "2022-07-23 00:00:00": 60000.0,
        "2022-03-10 00:00:00": 59000.0,
        "2022-01-25 00:00:00": 59300.0,
      },
    ),
    Crop(
      name: "Rice",
      location: "Dodoma",
      prices: {
        "2019-11-25 00:00:00": 197500.0,
        "2022-07-23 00:00:00": 200000.0,
      },
    ),
    Crop(
      name: "Beans",
      location: "Dodoma",
      prices: {"2019-11-25 00:00:00": 198800.0},
    ),
    Crop(
      name: "Tomatos",
      location: "Dodoma",
      prices: {"2019-11-25 00:00:00": 40000.0},
    ),
    Crop(
      name: "Potatoes",
      location: "Dodoma",
      prices: {"2019-11-25 00:00:00": 63600.0},
    ),

    //Morogoro
    Crop(
      name: "Maize",
      location: "Morogoro",
      prices: {"2019-11-25 00:00:00": 64500.0},
    ),
    Crop(
      name: "Rice",
      location: "Morogoro",
      prices: {
        "2019-11-25 00:00:00": 177500.0,
        "2019-01-03 00:00:00": 177500.0,
        "2019-07-12 00:00:00": 177500.0,
      },
    ),
    Crop(
      name: "Beans",
      location: "Morogoro",
      prices: {"2019-11-25 00:00:00": 187500.0},
    ),
    Crop(
      name: "Tomatos",
      location: "Morogoro",
      prices: {"2019-11-25 00:00:00": 55000.0},
    ),
    Crop(
      name: "Potatoes",
      location: "Morogoro",
      prices: {"2019-11-25 00:00:00": 81000.0},
    ),

    //Arusha
    Crop(
      name: "Maize",
      location: "Arusha",
      prices: {"2019-11-25 00:00:00": 65500.0},
    ),
    Crop(
      name: "Rice",
      location: "Arusha",
      prices: {"2019-11-25 00:00:00": 205000.0},
    ),
    Crop(
      name: "Beans",
      location: "Arusha",
      prices: {"2019-11-25 00:00:00": 157500.0},
    ),
    Crop(
      name: "Tomatos",
      location: "Arusha",
      prices: {"2019-11-25 00:00:00": 41000.0},
    ),
    Crop(
      name: "Potatoes",
      location: "Arusha",
      prices: {"2019-11-25 00:00:00": 72500.0},
    ),
  ];
}
