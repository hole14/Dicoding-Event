import 'package:flutter/material.dart';
import 'package:dicoding_event/model/event.dart';
import 'package:dicoding_event/service/api.dart';

class EventViewModel extends ChangeNotifier{
  final EventService _eventService = EventService();

  List<EventModel> _upcomingEvents = [];
  List<EventModel> get upcomingEvents => _upcomingEvents;

  List<EventModel> _finishedEvents = [];

  final List<EventModel> _favorite = [];
  List<EventModel> get favorite => _favorite;

  bool isFavorite(EventModel event) =>
    _favorite.any((e) => e.id == event.id);

  void toggleFavorite(EventModel event) {
    if (isFavorite(event)) {
      _favorite.removeWhere((e) => e.id == event.id);
    } else {
      _favorite.add(event);
    }
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String _searchQuery = '';

  List<EventModel> get filteredEvents {
    if (_searchQuery.isEmpty) return _finishedEvents;
    return _finishedEvents.where((event) {
      return event.title.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

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