import 'package:decide/tabs/views/tab/following_tab.dart';
import 'package:decide/tabs/views/tab/trending_tab.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[800],
          automaticallyImplyLeading: false,
          centerTitle: true ,
          bottom: const TabBar(
            indicatorColor: Colors.red,
            tabs: [
              Tab(
                text: 'Em Alta',
                icon: Icon(Icons.trending_up,color: Colors.white,size: 32,),
              ),
              Tab(
                text: 'Seguindo',
                icon: Icon(Icons.follow_the_signs_sharp,color: Colors.white,size: 32,),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            TrendingTab(),
            FollowingTab()
          ],
        ),
      ),
    );
  }
}
