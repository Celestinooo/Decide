import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:decide/tabs/models/search_user_model.dart';
import 'package:decide/tabs/stores/search_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends ModularState<SearchTab, SearchStore>
    with AfterLayoutMixin {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: () => FocusScope.of(context).unfocus(),
      child: DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[800],
            automaticallyImplyLeading: false,
            centerTitle: true,
            bottom: TabBar(
              indicatorColor: Colors.red,
              tabs: [
                Tab(
                  icon: Row(
                    children: [
                      Expanded(
                        child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                  primaryColor: Colors.white,
                                  // Define a cor primária como branca
                                  hintColor: Colors.white,
                                  // Define a cor da dica como branca
                                  focusColor: Colors.white),
                              child: TextField(
                                controller: store.inputController,
                                decoration: const InputDecoration(
                                  labelText: 'Digite para buscar',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  // Define a dica como não flutuante

                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .white), // Define a cor da borda inativa como branca
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .white), // Define a cor da borda quando o campo está em foco como branca
                                  ),
                                  filled: true,
                                ),
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      ),
                      IconButton(
                        icon: Icon(Icons.search, color: Colors.white),
                        onPressed: () {
                          store.searchUsers();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: Observer(builder: (context) {
                  return ListView.builder(
                    itemCount: store.users.length,
                    itemBuilder: (context, index) {
                      final user = store.users[index];
                      return ListTile(
                        leading: user.imageUrl.isNotEmpty
                            ? CircleAvatar(
                                backgroundImage: AssetImage(user.imageUrl),
                                backgroundColor: Colors.transparent,
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.person),
                                ],
                              ),
                        title: Text(user.name),
                        subtitle: Text(user.login),
                        trailing: _getFollowWidget(user),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getFollowWidget(SearchUserModel userFound) {
    var following = store.isFollowing(userFound.id);
    if(following == null) return const SizedBox();
    if (following) {
      return ElevatedButton(
        onPressed: () {
          store.unfollow(userFound);
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.grey[700],
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: Text('Deixar de Seguir'),
      );
    } else {
      return ElevatedButton(
        child: Text('Seguir'),
        onPressed: () {
          store.follow(userFound);
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      );
    }
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {}
}
