import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewModel/eventViewModel.dart';
import 'package:dicoding_event/component/finished.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favModel = context.watch<EventViewModel>();
    final favorite = favModel.favorite;
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: FinishedEvent(finishedEvents: favorite),
    );
  }
}
