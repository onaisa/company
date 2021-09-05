import 'package:company/UI/component/component.dart';
import 'package:company/cubit/companyapp_cubit.dart';
import 'package:company/models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateProfileScreen extends StatelessWidget {
  UserModel usermodel;
  UpdateProfileScreen(this.usermodel);
  TextEditingController passControllre = TextEditingController();
  TextEditingController phoneControllre = TextEditingController();
  TextEditingController emailControllre = TextEditingController();

  @override
  Widget build(BuildContext context) {
    passControllre.text = usermodel.password;
    phoneControllre.text = usermodel.number;
    emailControllre.text = usermodel.email;

    return BlocConsumer<CompanyappCubit, CompanyappState>(
      listener: (context, state) {
        if (state is UpdateProfileLoudingState) {
          showToast(text: 'Update Success', state: ToastStates.SUCCESS);
        }
        if (state is UpdateProfileErrorState) {
          showToast(text: 'Update Erorr', state: ToastStates.ERROR);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HederItem(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Card(
                    elevation: 5.0,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          defaultFormField(
                              controller: emailControllre,
                              type: TextInputType.emailAddress,
                              label: "email",
                              prefix: Icons.email),
                          SizedBox(
                            height: 10.0,
                          ),
                          defaultFormField(
                              controller: phoneControllre,
                              type: TextInputType.number,
                              label: "phone",
                              prefix: Icons.phone),
                          SizedBox(
                            height: 10.0,
                          ),
                          defaultFormField(
                              controller: passControllre,
                              type: TextInputType.text,
                              label: "password",
                              prefix: Icons.lock),
                          SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                defaultButton(
                    function: () {
                      CompanyappCubit.get(context).updateProfile(
                        // id: usermodel.id,
                        email: emailControllre.text,
                        number: phoneControllre.text,
                        password: passControllre.text,
                      );
                    },
                    text: 'save'),
                SizedBox(
                  height: 15.0,
                ),
                if (state is UpdateProfileLoudingState)
                  Center(
                    child: CircularProgressIndicator(),
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget HederItem() => Container(
      height: 200.0,
      width: double.infinity,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              color: Colors.teal[50],
              height: 130.0,
            ),
          ),
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: Container(
              height: 120.0,
              width: 120.0,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image(image: AssetImage('assets/images/file.png')),
              ),
            ),
          ),
          Stack(
            // alignment: AlignmentDirectional.bottomStart,
            children: [
              Align(
                  // alignment: AlignmentDirectional.center,
                  child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: CircleAvatar(
                  radius: 65.0,
                  backgroundColor: Colors.white,
                ),
              )),
              Align(
                  // alignment: AlignmentDirectional.center,
                  child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: CircleAvatar(
                  radius: 60.0,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/images/R.jpg'),
                ),
              )),
            ],
          ),
        ],
      ),
    );
