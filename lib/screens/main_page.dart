import 'package:bar2_banzeen/widgets/main_page_heading.dart';
import 'package:bar2_banzeen/widgets/horizontal_cars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/car_card.dart';
import '../widgets/view_more_button.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  static const routeName = '/mainPage';
  @override
  Widget build(BuildContext context) {
    final cars = FirebaseFirestore.instance.collection('cars');
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int count = 5;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "BeebBeeb",
            style: TextStyle(color: Color.fromARGB(255, 60, 64, 72)),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(20),
          child: FutureBuilder<QuerySnapshot>(
            future: cars.limit(5).get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView(children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MainHeading(text: "Trending"),
                          ViewMoreText(),
                        ],
                      ),
                      HorizontalCars(
                        width: 0.73 * width,
                        height: 0.4 * height,
                        carsToShow: cars
                            .orderBy("bids_count", descending: true)
                            .limit(5),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MainHeading(text: "What's new"),
                          ViewMoreText()
                        ],
                      ),
                      HorizontalCars(
                        width: 0.73 * width,
                        height: 0.4 * height,
                        carsToShow: cars
                            .orderBy("creation_time", descending: true)
                            .limit(5),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MainHeading(text: "All cars"),
                          ViewMoreText()
                        ],
                      ),
                    ],
                  ),
                  ...snapshot.data!.docs.map((doc) {
                    return CarCard(
                        width: 0.89 * width,
                        height: 0.4 * height,
                        rightMargin: 0,
                        carId: doc.id);
                  }).toList()
                ]);
              }
            },
          ),
        ));
  }
}
