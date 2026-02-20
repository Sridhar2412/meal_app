import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_provider.g.dart';

class LocationState {
  final LatLng? selectedLocation;
  final String? selectedAddress;
  final bool isLoading;
  final String? error;

  LocationState({
    this.selectedLocation,
    this.selectedAddress,
    this.isLoading = false,
    this.error,
  });

  LocationState copyWith({
    LatLng? selectedLocation,
    String? selectedAddress,
    bool? isLoading,
    String? error,
  }) {
    return LocationState(
      selectedLocation: selectedLocation ?? this.selectedLocation,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

@riverpod
class LocationNotifier extends _$LocationNotifier {
  @override
  LocationState build() {
    return LocationState();
  }

  Future<void> getCurrentLocation() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        state = state.copyWith(
            isLoading: false, error: 'Location services are disabled.');
        return;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          state = state.copyWith(
              isLoading: false, error: 'Location permissions are denied');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        state = state.copyWith(
            isLoading: false,
            error:
                'Location permissions are permanently denied, we cannot request permissions.');
        return;
      }

      Position position = await Geolocator.getCurrentPosition();
      LatLng latLng = LatLng(position.latitude, position.longitude);

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      String address = '';
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        address = '${place.locality}, ${place.country}';
      }

      state = state.copyWith(
        selectedLocation: latLng,
        selectedAddress: address,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> setSelectedLocation(LatLng latLng) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );

      String address = '';
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        address = '${place.locality}, ${place.country}';
      }

      state = state.copyWith(
        selectedLocation: latLng,
        selectedAddress: address,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        selectedLocation: latLng,
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void updateAddress(String address) {
    state = state.copyWith(selectedAddress: address);
  }
}
