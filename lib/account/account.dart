import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../db/dbhelper.dart';
import '../login/account_login.dart';
import '../provider/auth_provider.dart';
import '../utils/cache_manager.dart';
import '../utils/common_webview.dart';
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
    final authProvider = Provider.of<AuthProvider>(context);
    final username = authProvider.username;
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
            FutureBuilder<Map<String, dynamic>?>(
        future: DatabaseHelper.instance.getUser(username!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No user data found'));
          } else {
            final user = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   const Text('About Me'),
                   const SizedBox(height: 10),
                   _buildProfileData('Your Name', '${user['username']}'),
                   _buildProfileData('Contact Number', '${user['contactNumber']}'),
                   _buildProfileData('Email', '${user['email']}'),
                   _buildProfileData('Start Date', '2024-01-01'),
                   _buildProfileData('Submission Date', '2024-12-31'),
                ],
              ),
            );
          }
        },
      ),
    
            
 
            
           
            
            
            
            
             const SizedBox(height: 20),
            _buildChangePasswordSection(),
             const SizedBox(height: 20),
            _buildChangePass(context),
            const SizedBox(height: 20),
            _buildaboutUs(context),
          
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
        Provider.of<AuthProvider>(context, listen: false).logout();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const Login()),
                (route) => false,
              );
        
      },
      child: const Text('Logout'),
    ),);
  }
   Widget _buildaboutUs(BuildContext context) {
     return ElevatedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: ((context) => 
                       MyWebView(url: 'https://www.digitalmatty.com/')
                        )));
       
      },
      child: const Text('Contact Us'),
    );;
  }
}



