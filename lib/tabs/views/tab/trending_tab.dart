import 'package:decide/tabs/views/tab/create_tab.dart';
import 'package:decide/tabs/views/widgets/chart_widget.dart';
import 'package:flutter/material.dart';

class TrendingTab extends StatefulWidget {
  const TrendingTab({Key? key}) : super(key: key);

  @override
  State<TrendingTab> createState() => _TrendingTabState();
}

class _TrendingTabState extends State<TrendingTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: SafeArea(
      //   child: ListView.builder(
      //     itemBuilder: (context, index) {
      //       return  ChartWidget();
      //     },
      //   ),
      // ),
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
}
