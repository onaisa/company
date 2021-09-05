import 'package:company/UI/component/component.dart';
import 'package:company/UI/pages/layout_screen.dart';
import 'package:company/UI/pages/register_screen.dart';
import 'package:company/cubit/login_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController emailContriller = TextEditingController();
  TextEditingController passwordContriller = TextEditingController();

  bool secur = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSucessState) {
              showToast(text: 'login success', state: ToastStates.SUCCESS);
              navigateAndFinish(context, LayOutScreen());
            }
          },
          builder: (context, state) {
            LoginCubit cubit = LoginCubit.get(context);
            return Scaffold(
              appBar: AppBar(),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                            height: 150.0,
                            width: 150.0,
                            child: Image(
                                image: AssetImage('assets/images/file_1.png'))),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'LOGIN ',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        'if you an employee in our company enter your data',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .copyWith(color: Colors.grey[400]),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Form(
                          child: Column(
                        children: [
                          defaultFormField(
                              controller: emailContriller,
                              label: 'Email',
                              prefix: Icons.email,
                              type: TextInputType.emailAddress),
                          SizedBox(
                            height: 15.0,
                          ),
                          defaultFormField(
                              isPassword: secur,
                              suffix: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      secur = !secur;
                                    });
                                  },
                                  icon: secur == false
                                      ? Icon(Icons.visibility)
                                      : Icon(Icons.visibility_off)),
                              controller: passwordContriller,
                              label: 'Password',
                              prefix: Icons.lock,
                              type: TextInputType.visiblePassword),
                          SizedBox(
                            height: 15.0,
                          ),
                        ],
                      )),
                      Center(
                          child: defaultButton(
                              function: () {
                                cubit.userLogin(
                                  email: emailContriller.text,
                                  password: passwordContriller.text,
                                );
                              },
                              text: 'log in')),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Are you a new employee?'),
                          defaultTextButton(
                              function: () {
                                navigateTo(context, RegisterScreen());
                              },
                              text: 'register now')
                        ],
                      ),
                      if (state is LoginLoudingState)
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                      if (state is LoginErorrState)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              state.message,
                              maxLines: 2,
                              style:
                                  TextStyle(fontSize: 16.0, color: Colors.red),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
