import 'dart:js_interop';

import 'package:batch16/signup/bloc/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:batch16/gen/assets.gen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {

    return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
        child: BlocProvider<SignUpCubit>(
          create: (context) => SignUpCubit(),
          child: _HomeContent(),
        ),
      );
  }
}

class _HomeContent extends StatelessWidget {
  _HomeContent({this.user_name, this.user_email, this.user_password, super.key});

  String? user_name;
  String? user_email;
  String? user_password;

  @override
  Widget build(BuildContext context) => Scaffold(
      body: SafeArea(
          child: Stack(
              children:[
                Container(
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      child: Column(
                          children:[
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Text('Create Account', style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500
                              )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Assets.female.image(
                                  width: 88,
                                  height: 88
                              ),
                            ),
                            // ignore: prefer_const_constructors
                            Text('Create account with', style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400
                            )),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:[
                                  BlocListener<SignUpCubit, SignUpState>(
                                    listener: (context, state) {
                                      if (state is SignUpFailed) {
                                        if (state.provider == "Github") {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            // ignore: prefer_const_constructors
                                            SnackBar(
                                                content:
                                                // ignore: prefer_const_constructors
                                                Text('Github sign up is not supported')));
                                        }
                                        return null;
                                      }
                                      return null;
                                    },
                                    child: AccountHolder(image: Assets.github.image(
                                        width: 43, height: 43
                                    ), onTap: () {
                                      context.read<SignUpCubit>().signupWithGithub();
                                    },),
                                  ),
                                  AccountHolder(image: Assets.google.image(
                                      width: 43, height: 43
                                  ), onTap: () {context.read<SignUpCubit>().signupWithGoogle();
                                  },
                                  ),
                                  AccountHolder(image: Assets.linkedin.image(
                                      width: 43, height: 43
                                  ), onTap: () {
                                    // context.read<SignUpCubit>().signupWithLinkedin();
                                  },
                                  ),
                                ]
                            ),
                            BlocBuilder<SignUpCubit,SignUpState>(
                                builder: (context, state) {
                                  if (state is SignUpFailed) {
                                    if (state.provider == "Google"){
                                    return Text('${state.provider} sign up is not supported');
                                    }
                                    return SizedBox.shrink(); 
                                  }
                                  return SizedBox.shrink() ;
                                }
                            ),
                      
                            Text('Or', style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400
                            ),),
                      
                            IconTextFieldRow(
                                image: Assets.user.path, 
                                hint: 'Name',
                                onTextChange: (value) {
                                  print('name change $value');
                                  user_name = value;
                                },
                              ),
                            IconTextFieldRow(
                                image: Assets.email.path, 
                                hint: 'Email',
                                onTextChange: (value) {
                                  print('email change $value');
                                  user_email = value;
                                },
                              ),
                            IconTextFieldRow(
                              image: Assets.password.path, 
                              hint: 'Password',
                              suffiximage: Assets.showpassword.image(width: 43, height: 43),
                              onTextChange: (value) {
                                  print('password change $value');
                                  user_password = value;
                                },
                            ),
              
                            BlocBuilder<SignUpCubit, SignUpState>(
                              builder: (context, state) {
                                if (state is ShowDialogOnScreen) {
                                  showDialog(context: context, builder: (context) => AlertDialog(
                                  title: Text('Congratulations'),
                                  content: Text('Please wait a little longer'),
                                ),);
                                }
                                  else if (state is  SignUpLackOfDetails){
                                  return Text('${state.field} must not be empty');
                                  }
                                return SizedBox.shrink();
                              },
                              ),
                      
                            SignUpButton(
                                onTap: () => {
                                if (user_name == null) {
                                  {context.read<SignUpCubit>().SignUpWithoutName()} 
                                }
                                  else if (user_email == null) {
                                    {context.read<SignUpCubit>().SignUpWithoutEmail()},
                                  }
                                    else  if (user_password == null ) {
                                    {context.read<SignUpCubit>().SignUpWithoutPassword()},
                                    },
                                      {context.read<SignUpCubit>().showDialogEvent()},
                                },
                              ),
                            
                            Text('Or', style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400
                            ),),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Already have an account?', style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400
                              ),),
                            ),
                            Text('Login', style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.indigo
                            ),),
                          ]
                      ),
                    )
                ),
                Positioned(
                  top: 5,
                  left: 3,
                  child: Assets.modebuttons.image(
                      width: 20,
                      height: 60
                  ),
                ),
              ])
      )
  );
}


class AccountHolder extends StatelessWidget {
  const AccountHolder ({required this.image, this.onTap, super.key});
  final Image image;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow (
            blurRadius: 40,
            blurStyle: BlurStyle.outer,
            color: Colors.black.withOpacity(0.3),
            offset: Offset(2,2)
          )
        ]
      ),
      child: image,
    ),
  );
}

class IconTextFieldRow extends StatefulWidget {
  IconTextFieldRow({required this.image, required this.hint, this.suffiximage, required this.onTextChange, super.key});

  final String image;
  final String hint;
  final Image? suffiximage;
  final ValueChanged<String> onTextChange;

  @override
  State<IconTextFieldRow> createState() => _IconTextFieldRowState();
}

class _IconTextFieldRowState extends State<IconTextFieldRow> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller.addListener(() { 
      widget.onTextChange(controller.text);
    });
  }

  @override 
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      children: [
        Image.asset(widget.image, width: 43, height: 43),
        SizedBox(width: 20),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: Offset(2,2),
                  blurRadius: 40
                )
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(16)
            ),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(12),
                  hintText: widget.hint,
                  suffixIcon: widget.suffiximage,
                
                )
              ),
            ),
          ),
      ],)
  );
}

class SignUpButton extends StatelessWidget{
  SignUpButton ({this.onTap, super.key});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular(7),
      ),
      child:
      Text('Signup', style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      )
     ),
  );
}

//show Dialog
// Future<void> _dialogBuilder(BuildContext context) {
//     return showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Congratulations'),
//           content: const Text('Please wait a little longer'),
//         );
//     },
//   );
// }

//BlocSelector<SignUpCubit, SignUpState, String?>(
//selector: (state){
//if (state is SignUpFailed) {
//return state.provider;
//}
//return null;
//},
//builder: (context, state) {
//if (state == null) {
//return SizedBox.shrink();
//}
//return Text('$state sign up is not supported');
//}
//),