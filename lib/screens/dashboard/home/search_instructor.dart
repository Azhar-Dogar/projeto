import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:projeto/extras/app_assets.dart';
import 'package:projeto/extras/extensions.dart';
import 'package:projeto/widgets/button_widget.dart';
import 'package:projeto/widgets/margin_widget.dart';
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
  bool showInstructor = false;
  final Set<Marker> _markers = {};
  void _addCustomMarker() async {
    final Uint8List markIcons = await getImages('assets/icons/car.png', 100);
    const LatLng markerLocation =
        LatLng(31.4749, 74.3734); // Replace with your marker's coordinates
    _markers.add(Marker(
      onTap: () {
        setState(() {
          showInstructor = !showInstructor;
        });
      },
      markerId: const MarkerId('customMarker'),
      position: markerLocation,
      icon: BitmapDescriptor.fromBytes(markIcons),
      infoWindow: const InfoWindow(title: 'Custom Marker'),
    ));

    setState(() {});
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
            Positioned(bottom: 0, left: 0, right: 0, child: distanceBox())
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

  Widget instructorInfo() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          color: CColors.white),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(AppImages.instructor_1),
                      radius: 25,
                    ),
                    const MarginWidget(
                      factor: 0.5,
                    ),
                    RatingBar.builder(
                      itemSize: 10,
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        size: 7,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    )
                  ],
                ),
                const MarginWidget(
                  isHorizontal: true,
                  factor: 3,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Jacob Jones",
                        style: AppTextStyles.subTitleMedium(),
                      ),
                      Text(
                        "Celta, 2018",
                        style: AppTextStyles.subTitleRegular(),
                      ),
                      Text(
                        "R\$ 80,00 Hora / Aula",
                        style: AppTextStyles.subTitleRegular(),
                      )
                    ],
                  ),
                ),
                Icon(
                  Icons.messenger_outline,
                  color: CColors.primary,
                )
              ],
            ),
            const MarginWidget(),
            ButtonWidget(name: "Agendar", onPressed: () {
              setState(() {
                showInstructor = false;
              });
              showDialog(context: context, builder: (BuildContext context)=>noInstructorAlert(context));
            })
          ],
        ),
      ),
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

  Future<Uint8List> getImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
  Widget noInstructorAlert(BuildContext context){
    return AlertDialog(
      content:Column(
        mainAxisSize: MainAxisSize.min,
        children: [
           Align(
              alignment: Alignment.topRight,
              child: IconButton(icon: const Icon(Icons.close),onPressed: (){
                context.pop();
              },)),
          const MarginWidget(factor: 0.5,),
          Text("Por enquanto, não há instrutores por perto",style: AppTextStyles.subTitleMedium(),textAlign: TextAlign.center,),
        const MarginWidget(),
        Text("O instrutor mais próximo entrará em contato para agendamento",style: AppTextStyles.subTitleRegular(),textAlign: TextAlign.center,),
         const  MarginWidget(),
          Text("Procurar instrutor por nome",style: AppTextStyles.captionMedium(size: 12,color: CColors.primary),textAlign: TextAlign.center,)
      ],),
    );
  }
  Widget distanceBox() {
    return Column(
      children: [
        InkWell(
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(e),
                              ),
                            )
                        ],
                      ),
                    ));
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
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
        ),
        const MarginWidget(),
        if (showInstructor) ...[instructorInfo()]
      ],
    );
  }
}
