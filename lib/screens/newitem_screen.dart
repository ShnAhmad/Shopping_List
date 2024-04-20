import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopping_list/data/categories.dart';

class NewItemsScreen extends StatefulWidget {
  const NewItemsScreen({super.key});

  @override
  State<NewItemsScreen> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Items'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4),
        child: Form(
            child: Column(
          children: [
            TextFormField(
              maxLength: 50,
              decoration: const InputDecoration(label: Text('Name')),
              validator: (value) {
                return 'demo';
              },
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Quanitity'),
                    ),
                    initialValue: '1',
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: DropdownButtonFormField(items: [
                    //! entries convert map into list
                    for (final category in categories.entries)
                      DropdownMenuItem(
                          value: category.value,
                          child: Row(
                            children: [
                              Container(
                                height: 15,
                                width: 15,
                                color: category.value.color,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(category.value.title),
                            ],
                          ))
                  ], onChanged: (onChanged) {}),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                TextButton(onPressed: () {}, child: const Text('reset')),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(onPressed: () {}, child: const Text('add items'))
              ],
            )
          ],
        )),
      ),
    );
  }
}
