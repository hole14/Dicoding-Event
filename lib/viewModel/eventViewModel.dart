import 'package:flutter/material.dart';
import 'package:dicoding_event/model/event.dart';
import 'package:dicoding_event/service/api.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../component/notifikasi.dart';
import '../component/theme_notifier.dart';


class EventViewModel extends ChangeNotifier{
  final EventService _eventService = EventService();

  List<EventModel> _upcomingEvents = [];
  List<EventModel> get upcomingEvents => _upcomingEvents;

  List<EventModel> _finishedEvents = [];

  final List<EventModel> _favorite = [];
  List<EventModel> get favorite => _favorite;

  static const String _prefFavorite = "favorite";

  EventViewModel() {
    _loadFavorite();
  }

  bool isFavorite(EventModel event) =>
    _favorite.any((e) => e.id == event.id);

  void toggleFavorite(EventModel event) {
    if (isFavorite(event)) {
      _favorite.removeWhere((e) => e.id == event.id);
    } else {
      _favorite.add(event);
    }
    _saveFavorite();
    notifyListeners();
  }

  Future<void> _saveFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(_prefFavorite, _favorite.map((e) => e.id).toList());
  }

  Future<void> _loadFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = prefs.getStringList(_prefFavorite) ?? [];
    List<EventModel> favoriteEvents = [];
    favoriteEvents.addAll(_upcomingEvents);
    favoriteEvents.addAll(_finishedEvents);
    _favorite.clear();

    for (var id in favoriteIds) {
      try {
        final event = favoriteEvents.firstWhere((e) => e.id == id);
        _favorite.add(event);
      } catch (e) {
        print(e);
      }
      notifyListeners();
    }
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

  Future<void> fetchUpcomingEvents({required bool isNotificationOn}) async {
    _isLoading = true;
    notifyListeners();
    try{
      _upcomingEvents = await _eventService.upcomingEvent();
      _isLoading = false;
      notifyListeners();
      await _loadFavorite();

      for (var event in _upcomingEvents) {
        await NotificationService.schedulePreEventNotification(
          id: int.parse(event.id),
          title: event.title,
          body: "Event '${event.title}' akan segera dimulai!",
          beginTime: DateTime.parse(event.tanggalAwal),
          isNotificationOn: isNotificationOn,
        );
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> fetchFinishedEvents() async {
    try{
      _finishedEvents = await _eventService.finishedEvent();
      notifyListeners();
      await _loadFavorite();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> cancelAllNotifications() async {
    final allEventIds = [
      ..._upcomingEvents.map((e) => int.tryParse(e.id)).whereType<int>(),
      ..._finishedEvents.map((e) => int.tryParse(e.id)).whereType<int>(),
    ];
    for (var eventId in allEventIds) {
      await NotificationService.cancelNotification(eventId);
    }
  }
}

