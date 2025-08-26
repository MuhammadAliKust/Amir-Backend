import 'package:amir_backend/models/priority.dart';
import 'package:amir_backend/services/priority.dart';
import 'package:flutter/material.dart';

class UpdatePriorityView extends StatefulWidget {
  final PriorityModel model;

  const UpdatePriorityView({super.key, required this.model});

  @override
  State<UpdatePriorityView> createState() => _UpdatePriorityViewState();
}

class _UpdatePriorityViewState extends State<UpdatePriorityView> {
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Priority")),
      body: Column(
        children: [
          TextField(controller: nameController),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              if (nameController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Name cannot be empty.")),
                );
                return;
              }
              try {
                await PriorityServices()
                    .updatePriority(
                      PriorityModel(
                        docId: widget.model.docId.toString(),
                        name: nameController.text,
                      ),
                    )
                    .then((val) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Message"),
                            content: Text(
                              "Priority has been updated successfully",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: Text("Okay"),
                              ),
                            ],
                          );
                        },
                      );
                    });
              } catch (e) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(e.toString())));
              }
            },
            child: Text("Create Priority"),
          ),
        ],
      ),
    );
  }
}
