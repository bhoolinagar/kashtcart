import "dart:async";

import 'package:geolocator/geolocator.dart';
import 'package:kisan/Driver/Auth/assistants/requiestAssitants.dart';
import 'package:kisan/owner/configMap.dart';

class AssistantsMethod {
  static Future<String> searchCoordinatesAddres(Position position) async {
    String placeAddress = " ";
    String url =
        "http://maps.googleapis.com/maps/api/geoocde/json?latlng=${position.latitude},"
        "${position.longitude}&key=$mapKey";
    var response = await RequestAssigtant.getRequest(url);

    if (response != "Failed") {
      placeAddress = response['results'][0]['formatted_address'];
    }
    return placeAddress;
  }
}
