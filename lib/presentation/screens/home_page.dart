import 'package:flutter/material.dart';
import 'package:searching_list_with_json/data/data_model.dart';
import 'package:searching_list_with_json/domain/repository.dart';
import 'package:searching_list_with_json/presentation/components/loading_widget.dart';
import 'package:searching_list_with_json/presentation/components/item_tile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Item> _users = <Item>[];
  List<Item> _usersDisplay = <Item>[];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchItems().then((value) {
      setState(() {
        _isLoading = false;
        _users.addAll(value);
        _usersDisplay = _users;
        print(_usersDisplay.length);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Items List'),
      ),
      body: SafeArea(
        child: Container(
          child: ListView.builder(
            itemBuilder: (context, index) {
              if (!_isLoading) {
                return index == 0
                    ? _searchBar()
                    : ItemTile(user: this._usersDisplay[index - 1]);
              } else {
                return LoadingView();
              }
            },
            itemCount: _usersDisplay.length + 1,
          ),
        ),
      ),
    );
  }

  _searchBar() {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: TextField(
        autofocus: false,
        onChanged: (searchText) {
          searchText = searchText.toLowerCase();
          setState(() {
            _usersDisplay = _users.where((u) {
              var fName = u.title?.toLowerCase();
              var lName = u.category?.toLowerCase();
              var job = u.description?.toLowerCase();
              return fName!.contains(searchText) ||
                  lName!.contains(searchText) ||
                  job!.contains(searchText);
            }).toList();
          });
        },
        // controller: _textController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
          hintText: 'Search',
        ),
      ),
    );
  }
}
