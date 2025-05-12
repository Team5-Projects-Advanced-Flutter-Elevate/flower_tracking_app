import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/core/bases/base_stateful_widget_state.dart';
import 'package:flower_tracking_app/core/entities/order/order_entity.dart';
import 'package:flower_tracking_app/core/models/order/order_dto.dart';
import 'package:flower_tracking_app/core/utilities/extensions/date_time_extension/date_time_extension.dart';
import 'package:flower_tracking_app/shared_layers/database/firestore/constants/firestore_constants.dart';
import 'package:flower_tracking_app/shared_layers/database/firestore/data_sources_abstracts/order/order_collection.dart';
import 'package:flutter/material.dart';
import '../../../core/di/injectable_initializer.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseStatefulWidgetState<HomeScreen> {
  Map<String, dynamic> testingOrder = {
    "_id": "68221af61433a666c8db98d7",
    "user": {
      "_id": "67e31460836ee8be7062e3db",
      "firstName": "Mohammed",
      "lastName": "Khalil",
      "email": "klilmohammed9@gmail.com",
      "gender": "male",
      "phone": "+201010518801",
      "photo": "730858d9-fec0-408d-b0e2-af65709c35e5-OIP_031819.jpg",
      "passwordChangedAt": "2025-04-18T18:17:06.967Z",
    },
    "orderItems": [
      {
        "product": {
          "_id": "673e1cd711599201718280fb",
          "title": "Wedding flowers",
          "slug": "wedding-flowers",
          "description": "This is a Pack of White Widding Flowers",
          "imgCover": "fefa790a-f0c1-42a0-8699-34e8fc065812-cover_image.png",
          "images": [
            "66c36d5d-c067-46d9-b339-d81be57e0149-image_one.png",
            "f27e1903-74cf-4ed6-a42c-e43e35b6dd14-image_three.png",
            "500fe197-0e16-4b01-9a0d-031ccb032714-image_two.png",
          ],
          "price": 440,
          "priceAfterDiscount": 100,
          "quantity": 345509,
          "category": "673c46fd1159920171827c85",
          "occasion": "673b34c21159920171827ae0",
          "createdAt": "2024-11-20T17:31:03.303Z",
          "updatedAt": "2025-05-12T16:02:24.973Z",
          "__v": 0,
          "discount": 50,
          "sold": 1726,
          "rateAvg": 3.5,
          "rateCount": 30,
        },
        "price": 440,
        "quantity": 1,
        "_id": "68221acb1433a666c8db98bb",
      },
      {
        "product": {
          "_id": "673e2bd91159920171828139",
          "title": "Red Wdding Flower",
          "slug": "red-wdding-flower",
          "description": "This is a Pack of Red Widding Flowers",
          "imgCover": "5452abf4-2040-43d7-bb3d-3ae8f53c4576-cover_image.png",
          "images": [
            "ba028e59-410f-43ac-aed5-f4f97c102b98-image_four.png",
            "f89bc954-eb0d-4efb-928f-6717f77b69ed-image_one.png",
            "5ed2d072-485b-4a53-a0fa-a41412791397-image_three.png",
            "c0992ec6-d3c0-4a54-b7ec-4cf000138367-image_two.png",
          ],
          "price": 250,
          "priceAfterDiscount": 150,
          "quantity": 49562,
          "category": "673c46fd1159920171827c85",
          "occasion": "673b34c21159920171827ae0",
          "createdAt": "2024-11-20T18:35:05.594Z",
          "updatedAt": "2025-05-12T16:02:24.973Z",
          "__v": 0,
          "sold": 674,
          "discount": 50,
        },
        "price": 250,
        "quantity": 1,
        "_id": "68221ad41433a666c8db98c4",
      },
    ],
    "totalPrice": 345,
    "paymentType": "cash",
    "isPaid": false,
    "isDelivered": false,
    "state": "pending",
    "createdAt": "2025-05-12T15:59:50.024Z",
    "updatedAt": "2025-05-12T15:59:50.024Z",
    "orderNumber": "#124815",
    "__v": 0,
    "store": {
      "name": "Elevate FlowerApp Store",
      "image": "https://www.elevateegy.com/elevate.png",
      "address": "123 Fixed Address, City, Country",
      "phoneNumber": "1234567890",
      "latLong": "37.7749,-122.4194",
    },
  };
  late OrderDto orderDto;
  late OrderCollection orderCollection;
  late String driverId;

  @override
  void initState() {
    super.initState();
    orderCollection = getIt.get<OrderCollection>();
    driverId = getIt.get(instanceName: FirestoreConstants.driverId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 15,
          children: [
            Center(
              child: Text("Home Screen", style: theme.textTheme.titleLarge),
            ),
            FilledButton(
              onPressed: () async {
                debugPrint("Loading");
                OrderEntity orderEntity = orderDto.convertIntoEntity();
                var result = await orderCollection.addOrder(
                  driverId: driverId,
                  orderEntity: orderEntity,
                );
                switch (result) {
                  case Success<void>():
                    debugPrint("Success");
                  case Error<void>():
                    debugPrint("Result: ${result.error}");
                }
              },
              child: const Text("Accept"),
            ),
            FilledButton(
              onPressed: () async {
                debugPrint("Loading");
                debugPrint("lkj ${DateTime.now().dateSinceEpoch()}");
                var result = await orderCollection.updateOrder(
                  driverId: driverId,
                  orderEntity: OrderEntity(
                    id: "68221af61433a666c8db98d7",
                    receivedUserOrderAt: DateTime.now().dateSinceEpoch(),
                  ),
                );
                switch (result) {
                  case Success<void>():
                    debugPrint("Success");
                  case Error<void>():
                    debugPrint("Result: ${result.error}");
                }
              },
              child: const Text("Arrived At Pickup Point"),
            ),
            FilledButton(onPressed: () async{
              debugPrint("Loading");
              var result = await orderCollection.updateOrder(
                driverId: driverId,
                orderEntity: OrderEntity(
                  id: "68221af61433a666c8db98d7",
                  preparedUserOrderAt: DateTime.now().dateSinceEpoch(),
                ),
              );
              switch (result) {
                case Success<void>():
                  debugPrint("Success");
                case Error<void>():
                  debugPrint("Result: ${result.error}");
              }
            }, child: const Text("Start Deliver")),
            FilledButton(
              onPressed: () async{
                debugPrint("Loading");
                var result = await orderCollection.updateOrder(
                  driverId: driverId,
                  orderEntity: OrderEntity(
                    id: "68221af61433a666c8db98d7",
                    outForDeliveryAt: DateTime.now().dateSinceEpoch(),
                  ),
                );
                switch (result) {
                  case Success<void>():
                    debugPrint("Success");
                  case Error<void>():
                    debugPrint("Result: ${result.error}");
                }
              },
              child: const Text("Arrived to the user"),
            ),
            FilledButton(
              onPressed: () async{
                debugPrint("Loading");
                var result = await orderCollection.updateOrder(
                  driverId: driverId,
                  orderEntity: OrderEntity(
                    id: "68221af61433a666c8db98d7",
                    deliveredAt: DateTime.now().dateSinceEpoch(),
                  ),
                );
                switch (result) {
                  case Success<void>():
                    debugPrint("Success");
                  case Error<void>():
                    debugPrint("Result: ${result.error}");
                }
              },
              child: const Text("Delivered to the user"),
            ),
          ],
        ),
      ),
    );
  }
}
