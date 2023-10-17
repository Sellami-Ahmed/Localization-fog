import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

Future<http.Response> addOrUpdateMarkers(
    int id, double longitude, double latitude, String addressHost) {
  return http.put(
    Uri.parse('http://$addressHost/api/v1/devices'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
    }),
  );
}

Future<http.Response> signIn(String name, String password, String addressHost) {
  return http.post(
    Uri.parse('http://$addressHost/api/v1/devices/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'name': name, 'password': password}),
  );
}

Future<http.Response> signUp(String name, String password, String addressHost) {
  return http.post(
    Uri.parse('http://$addressHost/api/v1/devices/register'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'name': name, 'password': password}),
  );
}

Future<List<Marker>> fetchMarkers(String addressHost) async {
  final response =
      await http.get(Uri.parse('http://$addressHost/api/v1/devices'));

  if (response.statusCode == 200) {
    List<Marker> markers;
    List data = jsonDecode(response.body);
    markers = data.map((jsonMark) => CustomMark.fromJson(jsonMark)).toList();
    return markers;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Markers');
  }
}

class CustomMark extends Marker {
  const CustomMark(
      {required super.markerId,
      required super.infoWindow,
      required super.position});
  factory CustomMark.fromJson(Map<String, dynamic> json) {
    return CustomMark(
      markerId: MarkerId(json['id'].toString()),
      position: LatLng(json['latitude'], json['longitude']),
      infoWindow: InfoWindow(title: json['name']),
    );
  }
}
