import 'package:amir_backend/provider/user.dart';
import 'package:amir_backend/views/update_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Column(
        children: [
          Text(
            "Name: ${userProvider.getUser().name.toString()}",
            style: TextStyle(fontSize: 40),
          ),
          Text(
            "Email: ${userProvider.getUser().email.toString()}",
            style: TextStyle(fontSize: 40),
          ),
          Text(
            "Phone: ${userProvider.getUser().phone.toString()}",
            style: TextStyle(fontSize: 40),
          ),
          Text(
            "Address: ${userProvider.getUser().address.toString()}",
            style: TextStyle(fontSize: 40),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UpdateProfileView()),
              );
            },
            child: Text("Update Profile"),
          ),
        ],
      ),
    );
  }
}
