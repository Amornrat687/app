import 'package:flutter/material.dart';

// Model for a Restaurant
class Restaurant {
  final String name;
  final double point;
  final double distance;

  Restaurant({
    required this.name,
    required this.point,
    required this.distance,
  });
}

// Repository to manage restaurant data
class RestaurantRepository {
  static List<Restaurant> restaurant = [
    Restaurant(name: 'Restaurant 1', point: 4.5, distance: 1.2),
    Restaurant(name: 'Restaurant 2', point: 3.8, distance: 0.8),
  // Add more initial restaurant here
  ];
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _restaurantNameController = TextEditingController();
  final _restaurantPointController = TextEditingController();
  final _restaurantDistanceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: RestaurantRepository.restaurant.length,
              itemBuilder: (ctx, i) {
                Restaurant restaurant = RestaurantRepository.restaurant[i];

                return ListTile(
                  title: Text(restaurant.name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RestaurantDetailsPage(restaurant: restaurant),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _restaurantNameController,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.greenAccent,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _restaurantPointController,
                        decoration: InputDecoration(
                          hintText: 'Star',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 3,
                              color: Colors.greenAccent,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      var restaurantName = _restaurantNameController.text;
                      var restaurantPoint =
                      double.parse(_restaurantPointController.text);
                      var restaurant = Restaurant(
                        name: restaurantName,
                        point: restaurantPoint,
                        distance: 0.0,
                      );

                      setState(() {
                        RestaurantRepository.restaurant.add(restaurant);
                      });

                      _restaurantNameController.clear();
                      _restaurantPointController.clear();
                    },
                    child: Text('ADD'),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class RestaurantDetailsPage extends StatelessWidget {
  final Restaurant restaurant;

  RestaurantDetailsPage({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Restaurant Name: ${restaurant.name}',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Star: ${restaurant.point}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Distance: ${restaurant.distance}',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
