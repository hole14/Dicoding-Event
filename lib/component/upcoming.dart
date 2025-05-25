import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dicoding_event/model/event.dart';

class UpcomingEvent extends StatefulWidget {
  final List<EventModel> upcomingEvents;

  UpcomingEvent({required this.upcomingEvents});

  @override
  State<UpcomingEvent> createState() => _UpcomingEventState();
}

class _UpcomingEventState extends State<UpcomingEvent> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9);

    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if(_currentPage < widget.upcomingEvents.length - 1){
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220.0,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.upcomingEvents.length,
        itemBuilder: (context, index) {
          final event = widget.upcomingEvents[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              elevation: 4.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Image.network(
                      event.cover,
                      height: 120.0,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(event.title, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                  ],
                )
              ),
            ),
          );
        },
      ),
    );
  }
}
