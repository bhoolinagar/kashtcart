import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

//import 'package:latlng/latlng.dart' as Latlng;
//import 'package:latlng/latlng.dart';
class d_service_d extends StatefulWidget {
  @override
  d_sevices createState() => d_sevices();
}

class d_sevices extends State<d_service_d> {
  List<Marker> allMarker = [];
  setMarkers() {
    return allMarker;
  }

  Future<Widget> getLoadMap() async {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Markers').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Text("Please WAit");
        for (int i = 0; i < snapshot.data.documents.length; i++) {
          allMarker.add(new Marker(
              width: 34,
              height: 45,
              point: LatLng(snapshot.data.documents[i]['coords'].latitude,
                  snapshot.data.documents[i]['coords'].longitude),
              builder: (context) => new Container(
                    child: IconButton(
                      icon: Icon(Icons.location_searching),
                      iconSize: 45,
                      onPressed: () {
                        print(snapshot.data.documents[i]['coords']);
                      },
                    ),
                  )));
        }
        return new FlutterMap(
          options:
              new MapOptions(center: LatLng(23.5911281, 77.06508150), zoom: 23),
          layers: [
            new TileLayerOptions(urlTemplate: 'assets/ram1.png'),
            new MarkerLayerOptions(markers: allMarker)
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container();
  }
}

const String _svg_fpk4yv =
    '<svg viewBox="231.4 222.0 1.0 1.0" ><path transform="translate(-121.55, 222.04)" d="M 353 0" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_asctdw =
    '<svg viewBox="55.5 772.0 293.2 64.0" ><path transform="matrix(1.0, 0.0, 0.0, 1.0, 55.5, 772.0)" d="M 28.39491271972656 0 L 264.7633972167969 0 C 280.4454650878906 0 293.1583251953125 14.32672309875488 293.1583251953125 31.99963569641113 C 293.1583251953125 49.67254638671875 280.4454650878906 63.99927139282227 264.7633972167969 63.99927139282227 L 28.39491271972656 63.99927139282227 C 12.71283531188965 63.99927139282227 0 49.67254638671875 0 31.99963569641113 C 0 14.32672309875488 12.71283531188965 0 28.39491271972656 0 Z" fill="#ec8246" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_5c5wak =
    '<svg viewBox="3.1 26.9 33.8 60.8" ><path transform="matrix(0.707107, 0.707107, -0.707107, 0.707107, 20.0, 49.06)" d="M 4.141646862030029 4.141646385192871 L 23.25960159301758 23.25959396362305 C 24.19123649597168 24.19123077392578 25.70171356201172 25.70170593261719 26.63334846496582 26.63334274291992 C 27.56498908996582 27.56497955322266 27.56498527526855 27.56497955322266 26.63334846496582 26.63334274291992 L 7.515402317047119 7.515403747558594 C 6.583764553070068 6.583765983581543 5.07328462600708 5.073287010192871 4.141647815704346 4.14164924621582 C 3.210009098052979 3.210009574890137 3.210010051727295 3.210010528564453 4.141646862030029 4.141646385192871 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.707107, -0.707107, 0.707107, 0.707107, -1.76, 35.59)" d="M 1.686877727508545 29.08811569213867 L 20.8048152923584 9.970184326171875 C 21.7364559173584 9.038545608520508 21.73645401000977 9.038547515869141 20.80481910705566 9.970184326171875 C 19.8731861114502 10.90181350708008 18.36270523071289 12.41229820251465 17.43106460571289 13.34393692016602 L -1.686879515647888 32.46187591552734 C -2.618517398834229 33.39351272583008 -2.618515014648438 33.39350891113281 -1.686878800392151 32.46187210083008 C -0.7552433013916016 31.53023719787598 0.7552394866943359 30.01975440979004 1.686877727508545 29.08811569213867 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
