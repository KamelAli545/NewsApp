import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:newsapp/cubit/auth_cubit.dart';
import 'package:newsapp/screens/registerScreen.dart';
import 'package:newsapp/widgets/inputWidgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthCubit,AuthState>(
        listener: (context,state){
          if(state is AuthError){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context,state){
          return Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Lottie.asset('assets/animations/News.json',
                            height: 200,
                            width: 200
                        ),
                      ),
                      Text.rich(
                         TextSpan(
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                          children: [
                            TextSpan(text: 'Hello ',
                                style: TextStyle(
                                    color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 50

                                )
                            ),
                            TextSpan(
                              text: '\nAgain!',
                              style: TextStyle(color: Colors.blue,
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold),
                            )
                          ]
                      ),
                      ),
                      Text("Welcome back you’ve\n"
                          "been missed",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey
                      ),
                      ),
                      SizedBox(height: 15,),
                     InputWidgets(
                       prefixIcon: Icons.email,
                       label: "Email",
                         controller: _email,
                       validator: (v)=>(
                           v==null||!v.contains('@')?
                           "Enter a valid email":null
                       ),
                          color: Colors.black,
                     ),
                      SizedBox(height: 15,),
                      InputWidgets(
                        prefixIcon: Icons.lock,
                        label: "Password",
                          controller: _password,
                      obscureText: true,
                        validator: (v)=>(
                            v==null||v.length<6?
                            "Enter a More Than 6 Characters ":null
                        ),
                        color: Colors.black,
                      ),
                      const SizedBox(height: 24),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15))
                        ),
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                            )
                          ),
                          onPressed: state is AuthLoading
                              ? null
                              : () {
                            if (_formKey.currentState!.validate()) {
                              context
                                  .read<AuthCubit>()
                                  .login(_email.text, _password.text);
                            }
                          },
                          child: state is AuthLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text('Login',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text("OR",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                            color: Colors.grey
                          ),),
                      ),
                      GoogleSignInButton(
                          loadingIndicator:
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2,),
                          ),
                          clientId: "254953698829-6niaqj5i73c44r5uavs2sevl4f76drs9.apps.googleusercontent.com"),

                      TextButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => RegisterScreen())),
                        child: Center(
                          child: const Text("Create An Account? Sign Up",
                            style: TextStyle(
                                color: Colors.blue
                            ),),
                        ),
                      ),





                    ],
                  )),
            ),
          );
        },
      ),




    );
  }
}
