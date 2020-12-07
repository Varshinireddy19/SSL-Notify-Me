import 'package:flutter/material.dart';
import 'auth.dart';
import 'auth_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'push_notifications.dart';

class HomePage extends StatefulWidget {
  const HomePage({this.onSignedOut});
  final VoidCallback onSignedOut;

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  String _title = '';
  String _message = '';



  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  _register() {
    _firebaseMessaging.getToken().then((token) => print(token));

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMessage();

    final obj = new PushNotificationsManager();
    obj.init();
  }

  void getMessage() {
    print('hi');
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print('on message $message');
          setState(() => _message = message["notification"]["body"]);
          setState(() => _title = message["notification"]["title"]);
        }, onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
      setState(() => _message = message["notification"]["body"]);
      setState(() => _title = message["notification"]["title"]);
    }, onLaunch: (Map<String, dynamic> message) async {
      print('on launch $message');
      setState(() => _message = message["notification"]["body"]);
      setState(() => _title = message["notification"]["title"]);
    });

  }

  Future<void> _signOut(BuildContext context) async {
    try {
      final BaseAuth auth = AuthProvider.of(context).auth;
      await auth.signOut();
      widget.onSignedOut();
      // onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome'),
          actions: <Widget>[
            FlatButton(
              child: Text('Logout', style: TextStyle(fontSize: 17.0, color: Colors.white)),
              onPressed: () => _signOut(context),
            )
          ],
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Message: "),
                Text("$_title"),
                Text("$_message"),
                OutlineButton(
                  child: Text("Register My Device"),
                  onPressed: () {
                    _register();
                  },
                ),
                // Text("Message: $message")
              ]),
        ),
      ),
    );
  }
}




//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Welcome'),
//         actions: <Widget>[
//           FlatButton(
//             child: Text('Logout', style: TextStyle(fontSize: 17.0, color: Colors.white)),
//             onPressed: () => _signOut(context),
//           )
//         ],
//       ),
//       body: Container(
//         child: Center(child: Text('Welcome', style: TextStyle(fontSize: 32.0))),
//       ),
//     );
//   }
// }



// class MyApp extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _MyAppState();
//   }
// }


