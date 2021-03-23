import 'package:exemplo/models/user.dart';
import 'package:exemplo/provider/users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/user_tiles.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Users users = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Death note'),
        actions: <Widget>[
          IconButton(
             icon: Icon(Icons.add, size: 32,),
              color: Colors.white,
              padding: const EdgeInsets.only(right: 40.0),
              onPressed: () {}),
        ],
      ),
      body: ListView.builder(
        itemCount: users.count,
        itemBuilder: (ctx, i) => UserTile(users.byIndex(i)),
      ),
    );
  }
}
