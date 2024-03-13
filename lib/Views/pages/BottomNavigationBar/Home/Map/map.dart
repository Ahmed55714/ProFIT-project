import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:profit1/Views/widgets/AppBar/custom_appbar.dart';
import 'package:profit1/Views/widgets/customTextFeild.dart';
import '../../../../../controllers/map_controller.dart';
import '../../../../../utils/colors.dart';
import '../../../../widgets/customBotton.dart';

class GymMapScreen extends StatefulWidget {
  const GymMapScreen({Key? key}) : super(key: key);

  @override
  State<GymMapScreen> createState() => _GymMapScreenState();
}

class _GymMapScreenState extends State<GymMapScreen> {
  late GoogleMapController mapController;
  final Location location = Location();
  LatLng _currentPosition = LatLng(37.7749, -122.4194);
  bool _showBottomSheet = false;
  List<Gym> gyms = [];
  final TextEditingController _searchController = TextEditingController();
  final GymSearchController _gymSearchController = GymSearchController();

  Set<Marker> _markers = {};

  void _onSearch() async {
    final results =
        await _gymSearchController.searchGyms(_searchController.text);
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _getCurrentLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    setState(() {
      _currentPosition =
          LatLng(_locationData.latitude!, _locationData.longitude!);
    });

    mapController.animateCamera(CameraUpdate.newLatLng(_currentPosition));
  }

  void _toggleBottomSheet() {
    setState(() {
      _showBottomSheet = !_showBottomSheet;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: 'Nearest Gym Map'),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _currentPosition,
              zoom: 15.0,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: false,
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      Container(
                        width: 59,
                        height: 5,
                        decoration: BoxDecoration(
                          color: grey600,
                          borderRadius: BorderRadius.circular(2.5),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: CustomTextField(
                          labelText: 'Find Nearest gym',
                          isShowSearch: true,
                          onChange: (value) {
                            _onSearch();
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              width: 343,
                              padding: const EdgeInsets.all(16),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: grey200,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Leader Gym - Loran',
                                    style: TextStyle(
                                      color: colorBlue,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Open ',
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '09:00 AM - 11:00 PM',
                                          style: TextStyle(
                                            color: grey500,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '213 Abd El-Salam Aref, San Stefano, Alexandria',
                                    style: TextStyle(
                                      color: colorDarkBlue,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Container(
                                    width: double.infinity,
                                    child: CustomButton(
                                      text: 'Get Direction',
                                      isShowIcon: true,
                                      icon: 'assets/svgs/location-med-2.svg',
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class Gym {
  final String name;
  final String hours;
  final String address;

  Gym(this.name, this.hours, this.address);
}
