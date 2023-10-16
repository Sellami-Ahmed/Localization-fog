import 'dart:convert';
import 'dart:ffi';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

Future<http.Response> addOrUpdateMarkers(
    String name, double longitude, double latitude) {
  return http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
    }),
  );
}

Future<http.Response> createAlbum(String name) {
  return http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
    }),
  );
}

Future<List<Marker>> fetchMarkers() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    List<Marker> markers;
    List data = jsonDecode(response.body);
    markers = data.map((jsonMark) => CustomMark.fromJson(jsonMark)).toList();
    return markers;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class CustomMark extends Marker {
  const CustomMark(
      {required super.markerId,
      required super.infoWindow,
      required super.position});
  factory CustomMark.fromJson(Map<String, dynamic> json) {
    return CustomMark(
      markerId: json['name'],
      position: LatLng(
          double.parse((json['latitude'])), double.parse((json['longitude']))),
      infoWindow: InfoWindow(title: json['name']),
    );
  }
}
