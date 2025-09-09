import 'package:amir_backend/models/user.dart';
import 'package:amir_backend/provider/user.dart';
import 'package:amir_backend/services/auth.dart';
import 'package:amir_backend/services/user.dart';
import 'package:amir_backend/views/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateProfileView extends StatefulWidget {
  const UpdateProfileView({super.key});

  @override
  State<UpdateProfileView> createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    nameController = TextEditingController(
      text: userProvider.getUser().name.toString(),
    );
    phoneController = TextEditingController(
      text: userProvider.getUser().phone.toString(),
    );
    addressController = TextEditingController(
      text: userProvider.getUser().address.toString(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Update")),
      body: Column(
        children: [
          TextField(controller: nameController),
          TextField(controller: phoneController),
          TextField(controller: addressController),
          SizedBox(height: 20),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : ElevatedButton(
                  onPressed: () async {
                    if (nameController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Name cannot be empty.")),
                      );
                      return;
                    }

                    try {
                      isLoading = true;
                      setState(() {});
                      await UserServices()
                          .updateProfile(
                            UserModel(
                              docId: userProvider.getUser().docId.toString(),
                              name: nameController.text,
                              phone: phoneController.text,
                              address: addressController.text,
                            ),
                          )
                          .then((val) async {
                            UserModel userModel = await UserServices()
                                .getUserByID(
                                  userProvider.getUser().docId.toString(),
                                );
                            userProvider.setUser(userModel);
                            isLoading = false;
                            setState(() {});
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Message"),
                                  content: Text(
                                    "User has been updated successfully",
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
                      isLoading = false;
                      setState(() {});
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
                  child: Text("Update Profile"),
                ),
        ],
      ),
    );
  }
}
