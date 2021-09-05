import 'dart:io';

import 'package:company/UI/component/component.dart';
import 'package:company/UI/pages/layout_screen.dart';
import 'package:company/cubit/register_cubit.dart';
import 'package:company/util/local_cred.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailContriller = TextEditingController();
  TextEditingController passwordContriller = TextEditingController();
  TextEditingController nameContriller = TextEditingController();
  TextEditingController poneContriller = TextEditingController();
  StorageUtil storageUtil = StorageUtil.getInstance();
  RegisterCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            showToast(text: 'login success', state: ToastStates.SUCCESS);
            navigateAndFinish(context, LayOutScreen());
          }
        },
        builder: (context, state) {
          RegisterCubit cubit = RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: ImageProfile(cubit.image, context)),
                    Text(
                      'REGISTER',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio(
                              value: cubit.admin,
                              groupValue: cubit.check,
                              onChanged: (bool value) {
                                cubit.adminCHick(value);
                              }),
                          Text('admin'),
                          SizedBox(
                            width: 50.0,
                          ),
                          Radio(
                              value: !cubit.admin,
                              groupValue: cubit.check,
                              onChanged: (bool value) {
                                setState(() {
                                  cubit.adminCHick(value);
                                });
                              }),
                          Text('technical'),
                        ],
                      ),
                    ),
                    if (cubit.check == true)
                      Center(child: technicalChoose(context)),
                    SizedBox(
                      height: 10.0,
                    ),
                    Form(
                        child: Column(
                      children: [
                        defaultFormField(
                            controller: nameContriller,
                            label: 'Fullname',
                            prefix: Icons.person,
                            type: TextInputType.name),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            controller: emailContriller,
                            label: 'Email',
                            prefix: Icons.email,
                            type: TextInputType.emailAddress),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            controller: poneContriller,
                            label: 'Phone',
                            prefix: Icons.phone,
                            type: TextInputType.number),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            isPassword: cubit.secur,
                            suffix: IconButton(
                                onPressed: () {
                                  cubit.changePasswordVisibility();
                                },
                                icon: cubit.secur == false
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
                              cubit.userRegister(
                                  administration: !cubit.check,
                                  specialty: cubit.selected,
                                  email: emailContriller.text,
                                  name: nameContriller.text,
                                  number: poneContriller.text,
                                  password: passwordContriller.text);
                            },
                            text: 'register')),
                    if (state is RegisterLoadingState)
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    if (state is RegisterErrorState)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            state.message,
                            maxLines: 3,
                            style: TextStyle(fontSize: 16.0, color: Colors.red),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget ImageProfile(File image, BuildContext cont) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          height: 125,
          width: 125,
          child: image == null
              ? Image(
                  image: AssetImage('assets/images/profile.png'),
                  fit: BoxFit.cover,
                )
              : Image.file(
                  image,
                  fit: BoxFit.cover,
                ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
        ),
        // ),
        Positioned(
          // left: 90.0,
          child: CircleAvatar(
            backgroundColor: Colors.grey[300],
            radius: 22.0,
            child: IconButton(
                onPressed: () {
                  showDialog(
                    context: cont,
                    builder: (ctxt) => Dialog(
                      child: Container(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Choose a Photo',
                                style: TextStyle(fontSize: 24.0)),
                            SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    RegisterCubit.get(cont).uploadImageCamera();
                                  },
                                  icon: Icon(
                                    Icons.camera_alt,
                                  ),
                                  iconSize: 50.0,
                                ),
                                IconButton(
                                  onPressed: () {
                                    RegisterCubit.get(cont)
                                        .uploadImageGallery();
                                  },
                                  icon: Icon(Icons.image),
                                  iconSize: 50.0,
                                )
                              ],
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(cont);
                                },
                                child: Text(
                                  'ok',
                                  style: TextStyle(fontSize: 20.0),
                                ))
                          ],
                        ),
                      ),
                    ),
                  );
                },
                icon: Icon(
                  Icons.camera_alt,
                  size: 30.0,
                )),
          ),
        )
      ],
    );
  }
}

List<String> dropdownValue = ['web', 'mopile', 'diskTop'];

Widget technicalChoose(BuildContext exe) => Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: DropdownButton(
        elevation: 3,
        hint: Text(
          'prtement',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w400, color: Colors.black54),
        ),
        items: dropdownValue
            .map(
              (e) => DropdownMenuItem(
                onTap: () {},
                value: e,
                child: Center(
                  child: Text(e,
                      style: TextStyle(fontSize: 22, color: Colors.orange)),
                ),
              ),
            )
            .toList(),
        onChanged: (val) {
          RegisterCubit.get(exe).tec_Choose(val);
        },
        value: RegisterCubit.get(exe).selected,
      ),
    );
