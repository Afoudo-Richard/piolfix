import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:poilfix/poilfix.dart';
import 'package:latlong2/latlong.dart';

class UserMapPage extends StatelessWidget {
  const UserMapPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const UserMapPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Map',
      ),
      body: Container(
          child: FlutterMap(
        options: MapOptions(
          center: LatLng(7.3697, 12.3547),
          zoom: 9.2,
        ),
        nonRotatedChildren: [
          AttributionWidget.defaultWidget(
            source: 'OpenStreetMap contributors',
            onSourceTapped: null,
          ),
        ],
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
        ],
      )),
    );
  }
}
