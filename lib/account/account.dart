import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login/account_login.dart';
import '../utils/cache_manager.dart';
class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  AccountScreen  createState() => AccountScreen();
}
class AccountScreen extends State<UserInfo> {
  bool islogin = false;
  
  @override
  void initState() {
    super.initState();
    if(CacheManager.getInt("loginflag")==1){
      setState(() {
         islogin = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Account'),
      ),
      body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: islogin?
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
 
            const Text('About Me'),
            const SizedBox(height: 10),
            _buildProfileData('Your Name', CacheManager.getString("name")),
            _buildProfileData('Contact Number', CacheManager.getString("number")),
            _buildProfileData('Email', CacheManager.getString("email")),
            _buildProfileData('Start Date', '2024-01-01'),
            _buildProfileData('Submission Date', '2024-12-31'),
             const SizedBox(height: 20),
            _buildChangePasswordSection(),
             const SizedBox(height: 20),
            _buildChangePass(context),
          
            const SizedBox(height: 20),
            _buildLogoutButton(context),
          ],
        )
        : Column(
          children: [
            const Center(
           child:  Text('Hii Guest User'),
        ),
          _buildLogoutButton(context),
          ]
        
      ),)
    ),);
  }

  Widget _buildProfileData(String title, String data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(data),
      ],
    );
  }

  Widget _buildChangePasswordSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Change Password'),
        TextField(
          decoration: InputDecoration(labelText: 'Old Password'),
          obscureText: true,
        ),
        TextField(
          decoration: InputDecoration(labelText: 'New Password'),
          obscureText: true,
        ),
      ],
    );
  }

  Widget _buildChangePass(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
       
      },
      child: const Text('Change Password'),
    );
  }

 

  Widget _buildLogoutButton(BuildContext context) {
    return Center(
    child: ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      },
      child: const Text('Logout'),
    ),);
  }
}



