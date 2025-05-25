import 'package:flutter/material.dart';
import 'package:dicoding_event/model/event.dart';
import 'package:dicoding_event/service/api.dart';

class EventViewModel extends ChangeNotifier{
  final EventService _eventService = EventService();

  List<EventModel> _upcomingEvents = [];
  List<EventModel> get upcomingEvents => _upcomingEvents;

  List<EventModel> _finishedEvents = [];
  List<EventModel> get finishedEvents => _finishedEvents;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchUpcomingEvents() async {
    _isLoading = true;
    notifyListeners();

    try{
      _upcomingEvents = await _eventService.upcomingEvent();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchFinishedEvents() async {
    _isLoading = true;
    notifyListeners();

    try{
      _finishedEvents = await _eventService.finishedEvent();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}