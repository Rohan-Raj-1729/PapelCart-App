import 'package:flutter/material.dart';
import 'package:papelcart/pages/signin.dart';
import 'package:mysql_client/mysql_client.dart';

void main() {
  final pool = MySQLConnectionPool(
      host: '10.0.2.2',
      port: 3306,
      userName: 'root',
      password: 'Mahajan@9',
      maxConnections: 10, // optional,
      databaseName: 'papelcart');
  // pool.execute("Create database if not exists PapelCart");
  // pool.execute("use PapelCart");

  runApp(MyApp(pool: pool));
}

// class MyApp extends StatelessWidget {
//   //MyApp({Key? key}) : super(key: key);
//   var pool = MySQLConnectionPool(
//     host: '10.0.2.2',
//     port: 3306,
//     userName: 'root',
//     password: 'Mahajan@9',
//     maxConnections: 10,
//     databaseName: 'random', // optional,
//   );
//   //   var result = pool.execute("SELECT * FROM login");
//   //   var res = pool.execute(
//   //       "INSERT INTO login values (:id, :name)", {"id": 2, "name": 'raj'});
//   //   // for (final row in result.rows) {
//   //   //   print(row.assoc());
//   //   // }
//   //   // print(result);
//   //   result.then((value) {
//   //     for (var r in value.rows) {
//   //       print(r.assoc()["rollno"]);
//   //     }
//   //   });

// @override
// Widget build(BuildContext context) {
//   return MaterialApp(
//     title: 'Flutter Demo',
//     theme: ThemeData(
//       primarySwatch: Colors.blue,
//     ),
//     home: SigninPage(),
//   );
// }
// }

class MyApp extends StatefulWidget {
  const MyApp({Key? key, required this.pool}) : super(key: key);
  final MySQLConnectionPool pool;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PapelCart',
      theme: ThemeData.dark(),
      home: SigninPage(pool: widget.pool),
    );
  }
}

// class SigninPage extends StatefulWidget {
//   const SigninPage({Key? key, required this.pool}) : super(key: key);

//   final MySQLConnectionPool pool;

//   @override
//   State<SigninPage> createState() => _SigninPageState();
// }

// class _SigninPageState extends State<SigninPage> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Container(
//               alignment: Alignment.center,
//               padding: const EdgeInsets.all(10),
//               child: const Text(
//                 'CSN',
//                 style: TextStyle(
//                     color: Colors.blue,
//                     fontWeight: FontWeight.w500,
//                     fontSize: 30),
//               )),
//           Container(
//               alignment: Alignment.center,
//               padding: EdgeInsets.all(10),
//               child: Text(
//                 "",
//                 style: TextStyle(color: Colors.red),
//               )),
//           Container(
//             padding: const EdgeInsets.all(10),
//             child: TextField(
//               controller: nameController,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'User Email ID',
//               ),
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//             child: TextField(
//               obscureText: true,
//               controller: passwordController,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Password',
//               ),
//             ),
//           ),
//           TextButton(
//             onPressed: () {
//               //forgot password screen
//             },
//             child: const Text(
//               'Forgot Password',
//             ),
//           ),
//           Container(
//               height: 50,
//               padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//               child: ElevatedButton(
//                 child: const Text('Login'),
//                 onPressed: () {
//                   print("Button Pressed");
//                   var result = widget.pool.execute("SELECT * FROM login");

//                   result.then((value) {
//                     for (var r in value.rows) {
//                       print(r.assoc());
//                     }
//                   });
//                 },
//               )),
//           Row(
//             children: <Widget>[
//               const Text('Does not have account?'),
//               TextButton(
//                 child: const Text(
//                   'Sign up',
//                   style: TextStyle(fontSize: 20),
//                 ),
//                 onPressed: () {
//                   // Navigator.push(
//                   //   context,
//                   //   MaterialPageRoute(builder: (context) => SignupPage()),
//                   // );
//                   //signup screen
//                 },
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
