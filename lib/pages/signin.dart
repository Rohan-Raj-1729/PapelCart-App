import 'package:flutter/material.dart';

import 'package:papelcart/pages/signup.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:papelcart/pages/userPage.dart';
import 'package:papelcart/logic/user.dart' as User;
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
//   TextEditingController emailController = TextEditingController();
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
//               controller: emailController,
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

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key, required this.pool}) : super(key: key);

  final MySQLConnectionPool pool;

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  TextEditingController emailController = TextEditingController();
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
                "Sign In",
                style: TextStyle(
                    color: Color.fromARGB(255, 134, 186, 212),
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              )),
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
          TextButton(
            onPressed: () {
              //forgot password screen
              print(User.globalSessionData.email);
            },
            child: const Text(
              'Forgot Password',
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              children: <Widget>[
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () {
                        print("Login Button Pressed");
                        var result = widget.pool.execute(
                            "SELECT * FROM login where Email_Id = :email_id AND Password = :password ",
                            {
                              "email_id": emailController.text,
                              "password": passwordController.text
                            });
                        var resU = widget.pool.execute(
                            "SELECT * FROM user where Email_Id = :email_id",
                            {"email_id": emailController.text});
                        List<int> l = [];
                        resU.then((value) {
                          for (var r in value.rows) {
                            print("resU info:\n");
                            print(r.assoc());
                            l.add(int.parse(r.assoc()["Id"]!));
                            print(r.assoc()["Id"]);
                          }
                        });
                        int l1 = l.length;
                        print(l);
                        result.then((value) {
                          for (var r in value.rows) {
                            print(r.assoc());
                          }
                          if (value.rows.isNotEmpty && l1 > 0) {
                            for (var r in value.rows) {
                              User.globalSessionData.email =
                                  r.assoc()["Email_Id"]!;
                              User.globalSessionData.type = 0;
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserPage(
                                        pool: widget.pool,
                                        email: emailController.text,
                                      )),
                            );
                          } else {
                            print("Error!");
                            showSnackBar(context, "Wrong Credentials");
                          }
                        });
                      },
                    )),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Manager Login'),
                      onPressed: () {
                        print("Manager Login Button Pressed");
                        var result = widget.pool.execute(
                            "SELECT * FROM login where Email_Id = :email_id AND Password = :password ",
                            {
                              "email_id": emailController.text,
                              "password": passwordController.text
                            });

                        result.then((value) {
                          for (var r in value.rows) {
                            print(r.assoc());
                          }
                          if (value.rows.isNotEmpty) {
                            for (var r in value.rows) {
                              User.globalSessionData.email =
                                  r.assoc()["Email_Id"]!;
                              User.globalSessionData.type = 0;
                            }
                          }
                        });
                      },
                    )),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              const Text('Does not have account?'),
              TextButton(
                child: const Text(
                  'Sign up',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SignUpPage(pool: widget.pool)),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}

class MyCardWidget extends StatelessWidget {
  MyCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: 300,
      height: 200,
      padding: new EdgeInsets.all(10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.red,
        elevation: 10,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.album, size: 60),
              title: Text('Sonu Nigam', style: TextStyle(fontSize: 30.0)),
              subtitle: Text('Best of Sonu Nigam Music.',
                  style: TextStyle(fontSize: 18.0)),
            ),
            ButtonBar(
              children: <Widget>[
                RaisedButton(
                  child: const Text('Play'),
                  onPressed: () {/* ... */},
                ),
                RaisedButton(
                  child: const Text('Pause'),
                  onPressed: () {/* ... */},
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}

void showSnackBar(BuildContext context, String text) {
  final snackBar = SnackBar(
    content: Text(text),
    duration: Duration(seconds: 1), //default is 4s
  );
  // Find the Scaffold in the widget tree and use it to show a SnackBar.
  // Scaffold.of(context).showSnackBar(snackBar);
}
