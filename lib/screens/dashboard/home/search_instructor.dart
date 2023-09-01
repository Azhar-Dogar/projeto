import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:projeto/extras/extensions.dart';
import '../../../extras/app_textstyles.dart';
import '../../../extras/colors.dart';

class SearchInstructor extends StatefulWidget {
  const SearchInstructor({super.key});

  @override
  State<SearchInstructor> createState() => _SearchInstructorState();
}

class _SearchInstructorState extends State<SearchInstructor> {
  late double width, height;
  String distance = "2 km";
  List<String> distanceList = [
    "2 km",
    "5 km",
    "10 km",
  ];
  final Set<Marker> _markers = {};
  Future<BitmapDescriptor> _createCustomMarker() async {
    final ImageProperties properties =
    await FlutterNativeImage.getImageProperties('assets/icons/car.png');

    final File compressedFile = await FlutterNativeImage.compressImage(
      'assets/icons/car.png',
      quality: 100,
      targetWidth: 48, // Adjust the size as needed
      targetHeight: 48,
    );

    final Uint8List markerImageData = await compressedFile.readAsBytes();

    return BitmapDescriptor.fromBytes(markerImageData);
  }
  void _addCustomMarker() async {
    final Uint8List markIcons = await getImages('assets/icons/car.png', 100);
    final LatLng markerLocation = const LatLng(31.4749, 74.3734); // Replace with your marker's coordinates
    // final BitmapDescriptor markerImage = await _createCustomMarker();
     _markers.add(Marker(
      markerId: MarkerId('customMarker'),
      position: markerLocation,
      icon: BitmapDescriptor.fromBytes(markIcons),
      infoWindow: InfoWindow(title: 'Custom Marker'),
    ));

    setState(() {
    });
    print("markers");
    print(_markers.length);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addCustomMarker();
  }
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CColors.white,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: CColors.black,
          ),
          onPressed: () {
            context.pop();
          },
        ),
        title: Text(
          "Pesquisa",
          style: AppTextStyles.captionMedium(size: 14),
        ),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Credit",
                style: AppTextStyles.captionMedium(),
              ),
              Text(
                "R\$ 800,00",
                style: AppTextStyles.captionMedium(color: CColors.primary),
              )
            ],
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: Stack(children: [
            googleMap(),
            Positioned(top: 15, left: 15, right: 15, child: currentLocation()),
            Positioned(bottom: 15, left: 15, right: 15, child: distanceBox())
          ]))
        ],
      ),
    );
  }

  Widget googleMap() {
    return GoogleMap(
      initialCameraPosition: const CameraPosition(
        zoom: 25,
        target: LatLng(31.4749, 74.3734),
      ),
      onMapCreated: (GoogleMapController controller) {
        print('changes');
        // _controller = controller;
        // _setMyLocation();
      },
      // myLocationEnabled: true,
      markers: _markers,
    );
  }

  Widget currentLocation() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: CColors.white),
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(
                Icons.location_on_outlined,
                color: Color(0xffE67676),
              ),
            ),
            Text(
              "Localização atual",
              style: AppTextStyles.captionRegular(),
            )
          ],
        ),
      ),
    );
  }
  Future<Uint8List> getImages(String path, int width) async{
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return(await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();

  }
  Widget distanceBox() {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (var e in distanceList)
                        InkWell(
                          onTap: () {
                            setState(() {
                              distance = e;
                            });
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(e),
                          ),
                        )
                    ],
                  ),
                ));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: CColors.white),
        width: width,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Center(
              child: Text(
            distance,
            style: AppTextStyles.subTitleMedium(),
          )),
        ),
      ),
    );
  }
}
