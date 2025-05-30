import 'package:dicoding_event/component/constrains.dart';
import 'package:dicoding_event/viewModel/eventViewModel.dart';
import 'package:flutter/material.dart';
import 'package:dicoding_event/component/upcoming.dart';
import 'package:provider/provider.dart';

import '../component/finished.dart';
import '../component/theme_notifier.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(()=>
    Provider.of<EventViewModel>(context, listen: false).fetchUpcomingEvents(isNotificationOn: Provider.of<ThemeNotifier>(context, listen: false).isNotificationOn));
    Future.microtask(()=>
    Provider.of<EventViewModel>(context, listen: false).fetchFinishedEvents());
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
          return SingleChildScrollView(
            child: Column(
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
                  child: DecorationSearch(
                    onPressed: (){
                      _searchController.clear();
                      vm.setSearchQuery('');
                    },
                    controller: _searchController,
                    onChanged: (value) => vm.setSearchQuery(value),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                FinishedEvent(finishedEvents: vm.filteredEvents),
              ],
            ),
          );
        },
      ),
    );
  }
}
