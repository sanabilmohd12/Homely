import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiSelectDropDown(),
    );
  }
}

class MultiSelectDropDown extends StatefulWidget {
  @override
  _MultiSelectDropDownState createState() => _MultiSelectDropDownState();
}

class _MultiSelectDropDownState extends State<MultiSelectDropDown> {
  List<String> _selectedItems = []; // Maintain the selected items here
  List<String> _items = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];

  void _onItemSelect(String selectedItem) {
    setState(() {
      if (_selectedItems.contains(selectedItem)) {
        _selectedItems.remove(selectedItem);
      } else {
        _selectedItems.add(selectedItem);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multi-Select Dropdown'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Selected Items: ${_selectedItems.join(', ')}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              isExpanded: true,
              hint: Text('Select items'),
              value: null, // Initially no value is selected
              items: _items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Row(
                    children: <Widget>[
                      Checkbox(
                        value: _selectedItems.contains(item),
                        onChanged: (bool? value) {
                          _onItemSelect(item);
                        },
                      ),
                      SizedBox(width: 10),
                      Text(item),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String? value) {
                // This is needed to handle the dropdown value change
                // If you want to do something when the dropdown value changes
              },
            ),
          ],
        ),
      ),
    );
  }
}
/////////////////////////////////////////////////////////////////////////////////

//import 'package:flutter/material.dart';

// Model class
class Item {
  final int id;
  final String itemName;

  Item(this.id, this.itemName);
}

// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   // Sample list of items
  final List<Item> items = [
    Item(1, 'Item 1'),
    Item(2, 'Item 2'),
    Item(3, 'Item 3'),
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dropdown Example'),
        ),
        body: Center(
          child: DropdownButton<int>(
            hint: Text('Select an item'),
            onChanged: (int? newValue) {
              // Perform actions based on the selected value
              if (newValue != null) {
                Item selectedItem = items.firstWhere((item) => item.id == newValue);
                print('Selected: ${selectedItem.itemName}');
                // Perform actions with selectedItem
              }
            },
            items: items.map<DropdownMenuItem<int>>((Item item) {
              return DropdownMenuItem<int>(
                value: item.id,
                child: Text(item.itemName),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
/////////////////////////////////////////////////////////////////////////



// Model class representing an item in the dropdown
// class DropdownItem {
//   final String itemName;
//
//   DropdownItem(this.itemName);
// }
//
// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (_) => DropdownProvider(),
//       child: MyApp(),
//     ),
//   );
// }
//
// class DropdownProvider with ChangeNotifier {
//   final List<DropdownItem> dropdownItems = [
//     DropdownItem('Item 1'),
//     DropdownItem('Item 2'),
//     DropdownItem('Item 3'),
//     // Add more items as needed
//   ];
//
//   // Map to store the checkbox state for each DropdownItem
//   final Map<DropdownItem, bool> checkboxState = {};
//
//   void updateCheckboxState(DropdownItem item, bool isChecked) {
//     checkboxState[item] = isChecked;
//     notifyListeners();
//   }
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Dropdown Example'),
//         ),
//         body: DropDownFieldWithCheckBox(),
//       ),
//     );
//   }
// }
//
// class DropDownFieldWithCheckBox extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final dropdownProvider = Provider.of<DropdownProvider>(context);
//
//     return Center(
//       child: DropdownButtonFormField<DropdownItem>(
//         hint: Text('Select an item'),
//         value: null,
//         onChanged: (DropdownItem? newValue) {
//           if (newValue != null) {
//             bool isChecked = dropdownProvider.checkboxState[newValue] ?? false;
//             dropdownProvider.updateCheckboxState(newValue, !isChecked);
//           }
//         },
//         items: dropdownProvider.dropdownItems.map((DropdownItem item) {
//           return DropdownMenuItem<DropdownItem>(
//             value: item,
//             child: Row(
//               children: <Widget>[
//                 Checkbox(
//                   value: dropdownProvider.checkboxState[item] ?? false,
//                   onChanged: (bool? value) {
//                     if (value != null) {
//                       dropdownProvider.updateCheckboxState(item, value);
//                     }
//                   },
//                 ),
//                 Text(item.itemName),
//               ],
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }




/////////////////////////////////////////////////////////////////////////////////

// //import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MultiSelectDropDown(),
//     );
//   }
// }
//
// class MultiSelectDropDown extends StatefulWidget {
//   @override
//   _MultiSelectDropDownState createState() => _MultiSelectDropDownState();
// }
//
// class _MultiSelectDropDownState extends State<MultiSelectDropDown> {
//   List<String> _selectedItems = [];
//   List<String> _items = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];
//
//   void _onItemSelect(String selectedItem) {
//     setState(() {
//       if (_selectedItems.contains(selectedItem)) {
//         _selectedItems.remove(selectedItem);
//       } else {
//         _selectedItems.add(selectedItem);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Multi-Select Dropdown'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               'Selected Items: ${_selectedItems.join(', ')}',
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 20),
//             MultiSelectDropdown(
//               items: _items,
//               selectedItems: _selectedItems,
//               onItemSelected: _onItemSelect,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class MultiSelectDropdown extends StatelessWidget {
//   final List<String> items;
//   final List<String> selectedItems;
//   final Function(String) onItemSelected;
//
//   const MultiSelectDropdown({
//     required this.items,
//     required this.selectedItems,
//     required this.onItemSelected,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField<String>(
//       isExpanded: true,
//       hint: Text('Select items'),
//       value: null,
//       items: items.map((String item) {
//         return DropdownMenuItem<String>(
//           value: item,
//           child: Row(
//             children: <Widget>[
//               Checkbox(
//                 value: selectedItems.contains(item),
//                 onChanged: (bool? value) {
//                   onItemSelected(item);
//                 },
//               ),
//               SizedBox(width: 10),
//               Text(item),
//             ],
//           ),
//         );
//       }).toList(),
//       onChanged: (String? value) {},
//     );
//   }
// }

