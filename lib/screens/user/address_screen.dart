import 'package:flutter/material.dart';
import 'package:watches_project/models/user.dart';
import 'package:watches_project/widgets/app_bar.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key, required this.user});
  final User user;

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController _addressController = TextEditingController();

  void _deleteAddress(int index) {
    setState(() {
      widget.user.deleteAddress(index);
    });
  }

  void _showAddressDialog({int? index}) {
    if (index != null) {
      _addressController.text = widget.user.address[index];
    } else {
      _addressController.clear();
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(index == null ? "Add Address" : "Edit Address"),
        content: TextField(
          controller: _addressController,
          decoration: const InputDecoration(labelText: "Input Address"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (_addressController.text.trim().isEmpty) return;
              setState(() {
                if (index == null) {
                  widget.user.addAddress(_addressController.text);
                } else {
                  widget.user.editAddress(index, _addressController.text);
                }
              });
              Navigator.of(context).pop();
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("Address"),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.user.address.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: ValueKey(widget.user.address[index]),
                  direction: DismissDirection.endToStart,
                  onDismissed: (_) {
                    _deleteAddress(index);
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ListTile(
                    tileColor: Colors.grey[100],
                    title: Text(
                      widget.user.address[index],
                      style: const TextStyle(color: Colors.black87),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => _showAddressDialog(index: index),
                          icon: const Icon(Icons.edit, color: Colors.orange),
                        ),
                        IconButton(
                          onPressed: () => _deleteAddress(index),
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () => _showAddressDialog(),
              icon: const Icon(Icons.add),
              label: const Text("Add New Address"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
