import 'package:dicoding_event/model/event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'constrains.dart';

class FinishedEvent extends StatefulWidget {
  final List<EventModel> finishedEvents;
  
  FinishedEvent({required this.finishedEvents});
  
  @override
  State<FinishedEvent> createState() => _FinishedEventState();
}

class _FinishedEventState extends State<FinishedEvent> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.finishedEvents.length,
      itemBuilder: (context, index){
        final event = widget.finishedEvents[index];
        return Card(
          color: secondColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          elevation: 2.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 85,
                width: 85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(event.logo),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        event.title,
                        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '📆 ${formatDate(event.tanggalAwal)}',
                        style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.normal),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        '⏰ ${formatTime(event.tanggalAwal)} - ${formatTime(event.tanggalAkhir)}',
                        style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.normal),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
    });
  }
}

String formatDate(String dateString) {
  final date = DateTime.parse(dateString);
  final formatter = DateFormat('dd MMMM yyyy');
  return formatter.format(date);
}

String formatTime(String timeString) {
  final time = DateTime.parse(timeString);
  final formatter = DateFormat('HH:mm');
  return formatter.format(time);
}

