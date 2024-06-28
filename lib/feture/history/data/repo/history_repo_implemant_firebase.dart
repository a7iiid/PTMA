// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:ptma/feture/history/data/model/history_model.dart';
// import 'package:ptma/feture/history/data/repo/history_repo.dart';

// class HistoryRepoImplemantFireBase extends HistoryRepo {
//   @override
//   Future<Either<Widget, List<HistoryModel>>> getHistory() {
//     // TODO: implement getHistory
//     throw UnimplementedError();
//   }

//   Future<void> loadPassengerHistory() async {
//     try {
//       // Access the Firestore instance
//       FirebaseFirestore firestore = FirebaseFirestore.instance;

//       // Query all trips
//       QuerySnapshot tripsSnapshot = await firestore.collection('Trips').get();

//       // Iterate through each trip
//       for (QueryDocumentSnapshot trip in tripsSnapshot.docs) {
//         // Get the trip ID
//         String tripId = trip.id;

//         // Query passengers for this trip
//         QuerySnapshot passengersSnapshot = await firestore
//             .collection('Trips')
//             .doc(tripId)
//             .collection('passengers')
//             .get();

//         // Iterate through passengers of this trip
//         passengersSnapshot.docs.forEach((passenger) {
//           // Access passenger data
//           Map<String, dynamic> passengerData = passenger.data();

//           // Here you can process each passenger's data as needed
//           String passengerName = passengerData['name'];
//           DateTime passengerDate = passengerData['date']
//               .toDate(); // Assuming 'date' is a Firestore Timestamp
//           // Process or store the passenger data as per your requirements
//         });
//       }

//       // Success handling (optional)
//       print('Passenger history loaded successfully.');
//     } catch (e) {
//       // Error handling
//       print('Error loading passenger history: $e');
//     }
//   }
// }
