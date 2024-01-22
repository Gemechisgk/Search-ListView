import 'package:flutter/material.dart';
import 'package:searching_list_with_json/data/data_model.dart';
import 'package:searching_list_with_json/presentation/screens/item_details_page.dart';

class ItemTile extends StatelessWidget {
  final Item user;

  ItemTile({required this.user});

  String userTitle() {
    String title = "";

    return title;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          ListTile(
            leading: Hero(
              tag: user.id.toString(),
              child: CircleAvatar(
                backgroundImage: NetworkImage(user.image.toString()),
              ),
            ),
            title: Text('${userTitle()} ${user.title} ${user.category}'),
            subtitle: Text(user.price.toString()),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ItemDetailsPage(user: user)));
            },
          ),
          Divider(
            thickness: 2.0,
          ),
        ],
      ),
    );
  }
}
