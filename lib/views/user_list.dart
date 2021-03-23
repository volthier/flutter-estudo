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
        title: Text('Death note'),
        actions: <Widget>[
          IconButton(
              color: Colors.white, icon: Icon(Icons.add), onPressed: () {}),
        ],
      ),
      body: ListView.builder(
        itemCount: users.count,
        itemBuilder: (ctx, i) => UserTile(users.byIndex(i)),
      ),
    );
  }
}
