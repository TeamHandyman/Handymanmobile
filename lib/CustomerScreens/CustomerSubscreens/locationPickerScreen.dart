import 'dart:async';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:handyman/CustomerScreens/CustomerSubscreens/customerPostedJobs.dart';
import 'package:handyman/CustomerScreens/PostJob.dart';
import 'package:map_pin_picker/map_pin_picker.dart';
import 'package:flutter/material.dart';

class locationPickerScreen extends StatefulWidget {
  static const routeName = '/locationPicker';

  @override
  State<locationPickerScreen> createState() => _locationPickerScreenState();
}

class _locationPickerScreenState extends State<locationPickerScreen> {
  Position _currentPosition;
  CameraPosition cameraPosition;
  double lat, long;

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      _currentPosition = position;
      cameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 14.4746,
      );
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  void initState() {
    super.initState();

    _handleLocationPermission();
  }

  Completer<GoogleMapController> _controller = Completer();
  MapPickerController mapPickerController = MapPickerController();

  List<Placemark> address;

  var textController = TextEditingController();
  List<Placemark> add;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var data = ModalRoute.of(context).settings.arguments as List;
    return FutureBuilder(
        future: _getCurrentPosition(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return new Scaffold(
              body: Column(
                children: [
                  Expanded(
                    child: MapPicker(
                        // pass icon widget
                        iconWidget: Icon(
                          Icons.location_on_sharp,
                          size: 50,
                        ),
                        //add map picker controller
                        mapPickerController: mapPickerController,
                        child: Stack(
                          children: [
                            GoogleMap(
                              zoomControlsEnabled: false,
                              // hide location button
                              myLocationButtonEnabled: false,
                              mapType: MapType.normal,
                              //  camera position
                              initialCameraPosition: cameraPosition,
                              onMapCreated: (GoogleMapController controller) {
                                if (!_controller.isCompleted) {
                                  _controller.complete(controller);
                                }
                              },
                              onCameraMoveStarted: () {
                                // notify map is moving
                                mapPickerController.mapMoving();
                              },
                              onCameraMove: (cameraPosition) {
                                this.cameraPosition = cameraPosition;
                              },
                              onCameraIdle: () async {
                                // notify map stopped moving
                                mapPickerController.mapFinishedMoving();
                                //get address name from camera position
                                List<Placemark> addresses =
                                    await placemarkFromCoordinates(
                                        cameraPosition.target.latitude,
                                        cameraPosition.target.longitude);
                                add = addresses;
                                // update the ui with the address
                                textController.text =
                                    '${addresses.first?.street + ', ' + addresses.first?.subLocality + ', ' + addresses.first?.subAdministrativeArea}';
                              },
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 100),
                                child: Container(
                                  height: 70,
                                  width: 70,
                                  child: FloatingActionButton(
                                    child:
                                        Icon(Icons.location_searching_outlined),
                                    backgroundColor: Colors.blue,
                                    onPressed: () {
                                      _getCurrentPosition();
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 35),
                                child: Container(
                                  height: 50,
                                  width: width * 0.8,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(255, 255, 255, 0.8),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.zero,
                                        border: InputBorder.none),
                                    controller: textController,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 35),
                                child: GestureDetector(
                                  onTap: () {
                                    String latLong = cameraPosition
                                            .target.latitude
                                            .toString() +
                                        " " +
                                        cameraPosition.target.longitude
                                            .toString();
                                    Navigator.pop(context, latLong);
                                  },
                                  child: Container(
                                      height: 50,
                                      width: width * 0.8,
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Center(
                                        child: Text(
                                          'Pick Location',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      )),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
              // bottomNavigationBar: BottomAppBar(
              //   color: Colors.transparent,
              //   elevation: 0,
              //   child: Container(
              //     padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              //     color: Colors.blue,
              //     child: TextFormField(
              //       readOnly: true,
              //       decoration: InputDecoration(
              //           contentPadding: EdgeInsets.zero,
              //           border: InputBorder.none),
              //       controller: textController,
              //       style: TextStyle(fontSize: 12, color: Colors.white),
              //     ),
              //     // icon: Icon(Icons.directions_boat),
              //   ),
              // ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).buttonColor,
              ),
            );
          }
        }));
  }
}
