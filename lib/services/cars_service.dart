import 'package:bar2_banzeen/services/storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/Car.dart';

class CarsService {
  final CollectionReference _carsReference =
      FirebaseFirestore.instance.collection("cars");

  Future<void> addCar(Car car) async {
    DocumentReference carDocument = await _carsReference.add({
      "brand": car.brand,
      "model": car.model,
      "year": int.parse(car.year),
      "transmission": car.transmission,
      "engine_capacity": car.engineCapacity,
      "mileage": car.mileage,
      "color": car.color,
      "location": car.location,
      "starting_price": car.startingPrice,
      "description": car.description,
      "deadline": Timestamp.fromDate(car.deadline
          .add(const Duration(days: 1))
          .subtract(const Duration(seconds: 1))),
      "seller_id": car.sellerId,
      "sold": false,
      "creation_time": Timestamp.fromDate(DateTime.now()),
      "bids_count": 0
    });

    String carId = carDocument.id;
    List<String> uploadedPhotos = await Future.wait(car.localPhotos!.map(
        (localPhoto) async =>
            await StorageService().uploadCarPhoto(carId, localPhoto!)));
    await _carsReference.doc(carId).update({"photos": uploadedPhotos});
  }
}