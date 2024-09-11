import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/screens/newitem_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<GroceryItem> _addeditems = [];
  void addItems() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
        MaterialPageRoute(builder: (ctx) => const NewItemsScreen()));
    if (newItem == null) {
      return;
    }

    setState(() {
      _addeditems.add(newItem);
    });
  }

  void removeitem(GroceryItem item) {
    setState(() {
      _addeditems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text('No Item added yet'),
    );
    if (_addeditems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _addeditems.length,
        itemBuilder: (ctx, index) => Dismissible(
          onDismissed: (direction) => removeitem(_addeditems[index]),
          key: ValueKey(_addeditems[index].id),
          child: ListTile(
            title: Text(_addeditems[index].name),
            leading: Container(
              height: 25,
              width: 25,
              color: _addeditems[index].category.color,
            ),
            trailing: Text(_addeditems[index].quantity.toString()),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Grocey Items'),
        actions: [IconButton(onPressed: addItems, icon: const Icon(Icons.add))],
      ),
      body: content,
    );
  }
}
