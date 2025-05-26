import 'package:dicoding_event/component/constrains.dart';
import 'package:dicoding_event/viewModel/eventViewModel.dart';
import 'package:flutter/material.dart';
import 'package:dicoding_event/component/upcoming.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(()=>
    Provider.of<EventViewModel>(context, listen: false).fetchUpcomingEvents());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Consumer<EventViewModel>(
        builder: (context, vm, child) {
          if (vm.isLoading) {
            return CircularProgressIndicator();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Active Events',
                style: kTitleUpcoming,
              ),
              SizedBox(
                height: 8.0,
              ),
              UpcomingEvent(upcomingEvents: vm.upcomingEvents),
              SizedBox(
                height: 8.0,
              ),
              Text(
                'Finished Events',
                style: kTitleUpcoming,
              ),
              SizedBox(
                height: 8.0,
              ),
              SizedBox(
                height: 45,
                child: TextField(
                  decoration: kDecorationText,
                  onChanged: (value) {
                  print(value);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
