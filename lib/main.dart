// import 'package:flutter/material.dart';
// import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'as bg;
// import 'package:fluttertoast/fluttertoast.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home:  MyHomePage(),
//     );
//   }
// }
//
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
// String _location="Current Location..";
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     ////
//     // 1.  Listen to events (See docs for all 12 available events).
//     //
//
//     // Fired whenever a location is recorded
//     bg.BackgroundGeolocation.onLocation((bg.Location location) {
//       setState(() {
//         _location="${location.coords.latitude} | ${location.coords.longitude}";
//       });
//       Fluttertoast.showToast(
//           msg: "[location]-$location",
//           toastLength: Toast.LENGTH_SHORT,
//           // gravity: ToastGravity.CENTER,
//           // timeInSecForIosWeb: 1,
//           // backgroundColor: Colors.red,
//           // textColor: Colors.white,
//           fontSize: 16.0
//       );
//       print('[location] - $location');
//     });
//
//     // Fired whenever the plugin changes motion-state (stationary->moving and vice-versa)
//     bg.BackgroundGeolocation.onMotionChange((bg.Location location) {
//       setState(() {
//         _location="${location.coords.latitude} | ${location.coords.longitude}";
//       });
//       Fluttertoast.showToast(
//           msg: "[motionchange]-$location",
//           toastLength: Toast.LENGTH_SHORT,
//           // gravity: ToastGravity.CENTER,
//           // timeInSecForIosWeb: 1,
//           // backgroundColor: Colors.red,
//           // textColor: Colors.white,
//           fontSize: 16.0
//       );
//       print('[motionchange] - $location');
//     });
//
//     // Fired whenever the state of location-services changes.  Always fired at boot
//     bg.BackgroundGeolocation.onProviderChange((bg.ProviderChangeEvent event) {
//       // setState(() {
//       //   _location="${location.coords.latitude} | ${location.coords.longitude}";
//       // });
//       Fluttertoast.showToast(
//           msg: "[providerchange]-$event",
//           toastLength: Toast.LENGTH_SHORT,
//           // gravity: ToastGravity.CENTER,
//           // timeInSecForIosWeb: 1,
//           // backgroundColor: Colors.red,
//           // textColor: Colors.white,
//           fontSize: 16.0
//       );
//       print('[providerchange] - $event');
//     });
//
//     ////
//     // 2.  Configure the plugin
//     //
//     bg.BackgroundGeolocation.ready(bg.Config(
//       notification: bg.Notification(
//         title: "Name App",
//         text:"Current Location"
//       ),
//         desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
//         distanceFilter: 0.1,
//         stopOnTerminate: false,
//         startOnBoot: true,
//         debug: true,
//         logLevel: bg.Config.LOG_LEVEL_VERBOSE
//     )).then((bg.State state) {
//       if (!state.enabled) {
//         ////
//         // 3.  Start the plugin.
//         //
//         bg.BackgroundGeolocation.start();
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           height: MediaQuery.sizeOf(context).height,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Center(
//                 child: Text(_location,style: TextStyle(fontSize: 20),),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as bg;
//
// ////
// // For pretty-printing location JSON.  Not a requirement of flutter_background_geolocation
// //
// import 'dart:convert';
// JsonEncoder encoder = new JsonEncoder.withIndent("     ");
// //
// ////
// void main() => runApp(new MyApp());
//
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       title: 'BackgroundGeolocation Demo',
//       theme: new ThemeData(
//         primarySwatch: Colors.amber,
//       ),
//       home: new MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//
//
//
//
//   @override
//   _MyHomePageState createState() => new _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   bool? _isMoving;
//   bool? _enabled;
//   String? _motionActivity;
//   String? _odometer;
//   String? _content;
//
//   @override
//   void initState() {
//     _isMoving = false;
//     _enabled = false;
//     _content = '';
//     _motionActivity = 'UNKNOWN';
//     _odometer = '0';
//
//     // 1.  Listen to events (See docs for all 12 available events).
//     bg.BackgroundGeolocation.onLocation(_onLocation);
//     bg.BackgroundGeolocation.onMotionChange(_onMotionChange);
//     bg.BackgroundGeolocation.onActivityChange(_onActivityChange);
//     bg.BackgroundGeolocation.onProviderChange(_onProviderChange);
//     bg.BackgroundGeolocation.onConnectivityChange(_onConnectivityChange);
//     bg.BackgroundGeolocation.startBackgroundTask();
//
//     // 2.  Configure the plugin
//     bg.BackgroundGeolocation.ready(bg.Config(
//         desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
//         distanceFilter: 10.0,
//         stopOnTerminate: false,
//         startOnBoot: true,
//         debug: true,
//         logLevel: bg.Config.LOG_LEVEL_VERBOSE,
//         reset: true
//     )).then((bg.State state) {
//       setState(() {
//         _enabled = state.enabled;
//         _isMoving = state.isMoving!;
//       });
//     });
//   }
//
//   void _onClickEnable(enabled) {
//     if (enabled) {
//       bg.BackgroundGeolocation.start().then((bg.State state) {
//         print('[start] success $state');
//         setState(() {
//           _enabled = state.enabled;
//           _isMoving = state.isMoving!;
//         });
//       });
//     } else {
//       bg.BackgroundGeolocation.stop().then((bg.State state) {
//         print('[stop] success: $state');
//         // Reset odometer.
//         bg.BackgroundGeolocation.setOdometer(0.0);
//
//         setState(() {
//           _odometer = '0.0';
//           _enabled = state.enabled;
//           _isMoving = state.isMoving!;
//         });
//       });
//     }
//   }
//
//   // Manually toggle the tracking state:  moving vs stationary
//   void _onClickChangePace() {
//     setState(() {
//       _isMoving = !_isMoving!;
//     });
//     print("[onClickChangePace] -> $_isMoving");
//
//     bg.BackgroundGeolocation.changePace(_isMoving!).then((bool isMoving) {
//       print('[changePace] success $isMoving');
//     }).catchError((e) {
//       print('[changePace] ERROR: ' + e.code.toString());
//     });
//   }
//
//   // Manually fetch the current position.
//   void _onClickGetCurrentPosition() {
//     bg.BackgroundGeolocation.getCurrentPosition(
//         persist: false,     // <-- do not persist this location
//         desiredAccuracy: 0, // <-- desire best possible accuracy
//         timeout: 30000,     // <-- wait 30s before giving up.
//         samples: 3          // <-- sample 3 location before selecting best.
//     ).then((bg.Location location) {
//       print('[getCurrentPosition] - $location');
//     }).catchError((error) {
//       print('[getCurrentPosition] ERROR: $error');
//     });
//   }
//
//   ////
//   // Event handlers
//   //
//
//   void _onLocation(bg.Location location) {
//     print('[location] - $location');
//
//     String odometerKM = (location.odometer / 1000.0).toStringAsFixed(1);
//
//     setState(() {
//       _content = encoder.convert(location.toMap());
//       _odometer = odometerKM;
//     });
//   }
//
//   void _onMotionChange(bg.Location location) {
//     print('[motionchange] - $location');
//   }
//
//   void _onActivityChange(bg.ActivityChangeEvent event) {
//     print('[activitychange] - $event');
//     setState(() {
//       _motionActivity = event.activity;
//     });
//   }
//
//   void _onProviderChange(bg.ProviderChangeEvent event) {
//     print('$event');
//
//     setState(() {
//       _content = encoder.convert(event.toMap());
//     });
//   }
//
//   void _onConnectivityChange(bg.ConnectivityChangeEvent event) {
//     print('$event');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title: const Text('Background Geolocation'),
//           actions: <Widget>[
//             Switch(
//                 value: _enabled!,
//                 onChanged: _onClickEnable
//             ),
//           ]
//       ),
//       body: SingleChildScrollView(
//           child: Text('$_content')
//       ),
//       bottomNavigationBar: BottomAppBar(
//           child: Container(
//               padding: const EdgeInsets.only(left: 5.0, right: 5.0),
//               child: Row(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     IconButton(
//                       icon: Icon(Icons.gps_fixed),
//                       onPressed: _onClickGetCurrentPosition,
//                     ),
//                     Text('$_motionActivity · $_odometer km'),
//                     MaterialButton(
//                         minWidth: 50.0,
//                         child: Icon((_isMoving!) ? Icons.pause : Icons.play_arrow, color: Colors.white),
//                         color: (_isMoving!) ? Colors.red : Colors.green,
//                         onPressed: _onClickChangePace
//                     )
//                   ]
//               )
//           )
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as bg;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? test=0;
  double latitude=0.0;
  double longitude=0.0;
  double altitude=0.0;

  @override
  void initState() {
    super.initState();

    // Initialize the plugin with desired configuration settings.
    bg.BackgroundGeolocation.ready(bg.Config(
        desiredAccuracy: bg.Config.DESIRED_ACCURACY_NAVIGATION,
        distanceFilter: 0.5,
        stopOnTerminate: false,
        startOnBoot: true,
        debug: true,
        logLevel: bg.Config.LOG_LEVEL_VERBOSE,
        reset: true
    )).then((bg.State state) {
      print('BackgroundGeolocation is ready: $state');

      // Start location tracking.
      bg.BackgroundGeolocation.start();
    });

    setupLocationEventListeners();

    // Start a background task.
    startBackgroundTask();
  }

  // Subscribe to location events to receive latitude and longitude updates.
  void setupLocationEventListeners() {
    bg.BackgroundGeolocation.onLocation((bg.Location location) {
      // Handle location updates here.
      setState(() {
        latitude = location.coords.latitude;
        longitude = location.coords.longitude;
        altitude=location.coords.altitude;
      });


      print('Latitude: $latitude, Longitude: $longitude');

      // You can now use latitude and longitude as needed in your app.
    });
  }

  // Start a background task to send location updates to a server.
  Future<void> startBackgroundTask() async {
    try {
      // Start a background task.
      int taskId = await bg.BackgroundGeolocation.startBackgroundTask();

      // Simulate sending location updates to a server.
      // for (int i = 0; i < 5; i++) {
      //   // Perform background work here, such as sending location updates.
      //   print('Sending location update $i to server...');
      //
      //   // Simulate a delay (e.g., network request).
      //   await Future.delayed(Duration(seconds: 2));
      // }
      Timer.periodic(Duration(seconds: 1), (timer) {
        print('Latitude: $latitude, Longitude: $longitude');
        setState(() {
          test=test!+1;
        });
        print(test);
        print("Background Task is running"+DateTime.now().toString());
      });

      // Finish the background task when your work is done.
      // bg.BackgroundGeolocation.finish(taskId);
    } catch (e) {
      print('Error starting background task: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Background Task Example'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Latitude: $latitude, Longitude: $longitude'),
            Text('Latitude: $altitude'),
            Text('Performing background task...+$test'),
          ],
        ),
      ),
    );
  }


}
