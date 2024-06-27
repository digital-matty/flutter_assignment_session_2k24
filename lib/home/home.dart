import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../account/account.dart';
import '../db/dbhelper.dart';
import '../model/item.dart';
import '../popup/popup.dart';
import '../provider/theme_provider.dart';
import '../utils/cache_manager.dart';
import 'additem.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void add() {
  
    if(CacheManager.getInt("loginflag")==0){
       dialogBuilder(context,"Alter!!!!","Please login to add item","Ok",false,"cancle");
    }else{
       Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddItemScreen()),
          ).then((_) {
            setState(() {
              _items = DatabaseHelper().getItems();
            });
          });
    }


    setState(() {
     
    });
  }
   late Future<List<Item>> _items;

  @override
  void initState() {
    super.initState();
    _items = DatabaseHelper().getItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Consumer<ThemeProvider>(builder: (context, theme, _) {
              var currentTheme = theme.currentTheme;

              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: IconButton(
                  onPressed: () {
                    currentTheme == "light" ? theme.changeTheme("dark") : theme.changeTheme("light");
                  },
                  icon: Icon(currentTheme == "light" ? Icons.dark_mode : Icons.light_mode),
                  splashRadius: 26,
                  key: ValueKey(currentTheme),
                ),
              );
            }),
          ),
          PopupMenuButton<int>(
                          itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 1,
                                  child: Text('My Account'),
                                ),
                               
                              ],
                          onSelected: (value) => {
                                if (value == 1)
                                  {
                                     
                                      Navigator.push(context, MaterialPageRoute(builder: ((context) => const UserInfo()))),
                                  }else{
                                    // _deleteAccount(context)
                                  }
                              },
                       
                          ),
                           
                
        ],
      ),
      body:(CacheManager.getInt("loginflag")==1)?
      
       FutureBuilder<List<Item>>(
        future: _items,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No items found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                return ListTile(
                  leading: Text(item.name),
                  title: Text(item.name),
                  subtitle: Text(item.description),
                  trailing: Text('Rating: ${item.rating}'),
                );
              },
            );
          }
        },
      )
      :const Column(
          children: [
            Center(
           child:  Text('Hii Guest User'),
        )]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         add();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}