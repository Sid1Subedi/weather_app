import 'package:location/location.dart';
import 'package:weather_app/custom_widgets/toast_message_widget/toast_message_widget.dart';

class LocationServices {
  static Future<LocationData?> getLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        ToastMessages().showErrorToastMessage(
          message: 'Location services are disabled.',
        );
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        ToastMessages().showErrorToastMessage(
          message: 'Location permissions are denied.',
        );
        return null;
      }
    }

    LocationData locationData = await location.getLocation();
    return locationData;
  }
}
