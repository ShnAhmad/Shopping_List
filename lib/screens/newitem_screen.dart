import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/category.dart';
import 'package:shopping_list/models/grocery_item.dart';

class NewItemsScreen extends StatefulWidget {
  const NewItemsScreen({super.key});

  @override
  State<NewItemsScreen> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemsScreen> {
  var enteredName = '';
  var enteredQuantity = 1;
  var selectedCategory = categories[Categories.fruit];

  final _formkey = GlobalKey<FormState>();

  void saveItems() {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      Navigator.of(context).pop(GroceryItem(
          id: DateTime.now().toString(),
          name: enteredName,
          quantity: enteredQuantity,
          category: selectedCategory!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Items'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4),
        child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  maxLength: 50,
                  decoration: const InputDecoration(label: Text('Name')),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 1 ||
                        value.trim().length >= 50) {
                      return ('Name must be between 1 and 50 characters');
                    }
                    return null;
                  },
                  onSaved: (value) => enteredName = value!,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          label: Text('Quanitity'),
                        ),
                        initialValue: enteredQuantity.toString(),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              int.tryParse(value) == null ||
                              int.tryParse(value)! <= 0) {
                            return ('Must be a positive number');
                          }
                          return null;
                        },
                        onSaved: (value) => enteredQuantity = int.parse(value!),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: DropdownButtonFormField(
                          value: selectedCategory,
                          items: [
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
                          ],
                          onChanged: (value) {
                            selectedCategory = value;
                          }),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: saveItems,
                      child: const Text('add items'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButton(
                      onPressed: () {
                        _formkey.currentState!.reset();
                      },
                      child: const Text('reset'),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
