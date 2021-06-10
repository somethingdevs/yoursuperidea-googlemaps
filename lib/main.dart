import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_core/firebase_core.dart';

import './details_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yoursuperidea Task',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Marker> allMarkers = [Marker(markerId: MarkerId('Cart 1'))];

  Completer<GoogleMapController> _controller = Completer();

  LatLng _center = LatLng(28.6139, 77.2090);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 15,
                    child: Icon(Icons.menu_rounded),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'All Vendors',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(width: 80),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 15,
                    onPressed: () {},
                    child: Text(
                      'Shop Now',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: Colors.lightGreen[500],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Stack(
                fit: StackFit.loose,
                overflow: Overflow.visible,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 5, 5, 50),
                    height: double.infinity,
                    // color: Colors.blue,
                    child: GoogleMap(
                      compassEnabled: false,
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: _center,
                        zoom: 11.0,
                      ),
                      markers: {
                        Marker(
                          infoWindow: InfoWindow(
                            title: 'Cart 1',
                            snippet: 'View Stock',
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsScreen(),
                                  ));
                            },
                          ),
                          markerId: MarkerId('Cart 1'),
                          draggable: false,
                          onTap: () {
                            print('Marker Tapped');
                            Container(
                              height: 60,
                              width: 60,
                              color: Colors.blue,
                            );
                          },
                          position: LatLng(_center.latitude, _center.longitude),
                        ),
                      },
                    ),
                  ),
                  Positioned(
                    left: 25,
                    top: 530,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: 300,
                        height: 120,
                        child: Row(
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 5,
                              child: Container(
                                width: 30,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(
                                      Icons.location_pin,
                                      size: 20,
                                    ),
                                    Icon(
                                      Icons.store_mall_directory_outlined,
                                      size: 20,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            Container(
                              width: 220,
                              // color: Colors.amber,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Your Location',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  Text(
                                    'Sindh Vihar, Lashkar',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Divider(
                                    thickness: 2,
                                  ),
                                  Text(
                                    'Cart Location',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  Text(
                                    'Durban Hall, Sindh Vihar ',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
