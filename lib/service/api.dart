import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dicoding_event/model/event.dart';

class EventService {
  final String baseUrl = "https://event-api.dicoding.dev/events";

  Future<List<EventModel>> upcomingEvent() async {
    final response = await http.get(Uri.parse("$baseUrl?active=1"));

    if(response.statusCode == 200){
      final jsonData = jsonDecode(response.body);
      final eventResponse = EventResponse.fromJson(jsonData);
      return eventResponse.listEvents;
    } else {
      throw Exception("Gagal mengambil data");
    }
  }

  Future<List<EventModel>> finishedEvent() async {
    final response = await http.get(Uri.parse("$baseUrl?active=0"));
    if(response.statusCode == 200){
      final jsonData = jsonDecode(response.body);
      final eventResponse = EventResponse.fromJson(jsonData);
      return eventResponse.listEvents;
    } else {
      throw Exception("Gagal mengambil data");
    }
  }
}