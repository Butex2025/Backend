import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/cubit/cart_cubit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  final Set<Marker> markers;
  const MapPage({
    super.key,
    required this.markers,
  });

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? mapController;
  late final LatLng _initialPosition = const LatLng(52.23, 21.011);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    print('${widget.markers}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        leading: IconButton(
          onPressed: () => moveBack(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          'Map',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        scrolledUnderElevation: 3,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 400,
              height: 500,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _initialPosition,
                  zoom: 6.0,
                ),
                markers: widget.markers,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

moveBack(BuildContext context) {
  final cartCubit = BlocProvider.of<CartCubit>(context);
  cartCubit.loadCart();
}
