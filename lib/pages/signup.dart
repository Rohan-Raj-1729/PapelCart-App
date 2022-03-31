import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:papelcart/pages/signin.dart';
import 'package:papelcart/logic/user.dart' as User;
import 'package:papelcart/pages/userPage.dart';
// class UserInfo {
//   static late int id;
//   UserInfo(int id) {
//     this.id = id;
//   }
//   getId() {
//     return this.id;
//   }
// }

// class SigninPage extends StatelessWidget {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   final int
//       Id; // <--- generates the error, "Field doesn't override an inherited getter or setter"
//   SigninPage({required int Id}) : this.Id = Id;

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
//                 onPressed: () {},
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
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => SignupPage()),
//                   );
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

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key, required this.pool}) : super(key: key);

  final MySQLConnectionPool pool;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phnoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'PapelCart',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              )),
          Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(10),
              child: Text(
                "Register/Sign Up",
                style: TextStyle(
                    color: Color.fromARGB(255, 134, 186, 212),
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              )),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: phnoController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Phone Number',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email ID',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(10, 20, 0, 0),
            alignment: Alignment.center,
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              children: <Widget>[
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Register'),
                      onPressed: () {
                        print("Register Button Pressed");
                        var res_count =
                            widget.pool.execute("select * from user");

                        res_count.then((value) {
                          var id = 0;
                          id = value.rows.length + 1;
                          print(id);
                          widget.pool.execute(
                              "insert into user values(:id,:username,:email_id,:phno)",
                              {
                                "id": id,
                                "username": nameController.text,
                                "email_id": emailController.text,
                                "phno": phnoController.text
                              });
                        });
                        widget.pool.execute(
                            "insert into login values(:email_id, :password)", {
                          "email_id": emailController.text,
                          "password": passwordController.text
                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserPage(
                                  pool: widget.pool,
                                  email: emailController.text)),
                        );
                      },
                    )),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Sign in'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SigninPage(pool: widget.pool)),
                        );
                      },
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
