import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:decide/tabs/models/chart_model.dart';
import 'package:decide/tabs/models/chart_option.dart';
import 'package:decide/tabs/models/profile_model.dart';
import 'package:decide/tabs/stores/following_store.dart';
import 'package:decide/tabs/views/modal/on_comment_sent.dart';
import 'package:decide/tabs/views/tab/create_tab.dart';
import 'package:decide/tabs/views/widgets/chart_widget.dart';
import 'package:decide/tabs/views/widgets/on_chart_option_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class FollowingTab extends StatefulWidget {
  const FollowingTab({Key? key}) : super(key: key);

  @override
  State<FollowingTab> createState() => _FollowingTabState();
}

class _FollowingTabState extends ModularState<FollowingTab,FollowingStore> with AfterLayoutMixin implements OnChartOptionSelect, OnCommentSent{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Observer(
          builder: (context) {
            final charts = store.charts;
            return ListView.builder(
              itemCount: charts.length,
              itemBuilder: (context, index) {
                final chart = charts[index];
                return  ChartWidget(chartModel: chart,isVotingMode: true,onChartOptionSelect: this,onCommentSent: this,currentUser: store.getProfileModel(),);
              },
            );
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormModal(context);
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showFormModal(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => const CreateTab(),
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    store.getCharts();
  }

  @override
  void onChartOptionSelect(ChartModel chart, ChartOption option) {
    store.vote(chart,option);
    store.getCharts();
  }

  @override
  void onCommentSent(ChartModel chartModel, String comment) {
    store.saveComment(chartModel,comment);
        store.getCharts();
  }

  @override
  void onFollowUser(ProfileModel currentUser, ProfileModel followedUser) {
    store.followUser(currentUser,followedUser);
  }
}
