import 'package:company/UI/component/component.dart';
import 'package:company/UI/pages/sendemail_screen.dart';
import 'package:company/UI/pages/showsceuale.dart';
import 'package:company/cubit/companyapp_cubit.dart';
import 'package:company/models/EmployeeModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowEmployeeDetileScreen extends StatelessWidget {
  int intEmployee;
  ShowEmployeeDetileScreen(this.intEmployee);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyappCubit, CompanyappState>(
      listener: (context, state) {},
      builder: (context, state) {
        CompanyappCubit cubit = CompanyappCubit.get(context);
        cubit.getEmployeeProfle(id: intEmployee);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal[50],
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HederItem(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 0.0),
                  child: Card(
                      elevation: 5.0,
                      child: BlocBuilder<CompanyappCubit, CompanyappState>(
                        builder: (context, state) {
                          if (cubit.employeeModel == null)
                            return Container(
                              height: MediaQuery.of(context).size.height - 400,
                              width: MediaQuery.of(context).size.width - 100,
                              child: Center(child: CircularProgressIndicator()),
                            );
                          else
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                RowItem(
                                    context,
                                    'Name :${cubit.employeeModel.name}',
                                    Icons.person),
                                Divider(),
                                RowItem(
                                    context,
                                    'Phone : ${cubit.employeeModel.number}',
                                    Icons.phone),
                                Divider(),
                                RowItem(
                                    context,
                                    'Email : ${cubit.employeeModel.email}',
                                    Icons.email),
                                Divider(),
                                RowItem(
                                    context,
                                    'Offday : ${cubit.employeeModel.offDays}',
                                    Icons.home)
                              ],
                            );
                        },
                      )),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (cubit.userModel.administration == true)
                        defaultButton(
                            function: () {
                              navigateTo(context,
                                  ShowScedualScreen(cubit.listschedual));
                            },
                            text: 'show schedual'),
                      defaultButton(
                          function: () {
                            navigateTo(
                                context, SendEmailScreen(cubit.employeeModel));
                          },
                          text: 'send email'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget HederItem() => Container(
      height: 170.0,
      width: double.infinity,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              color: Colors.teal[50],
              height: 100.0,
            ),
          ),
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: Container(
              height: 120.0,
              width: 120.0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Image(image: AssetImage('assets/images/file.png')),
              ),
            ),
          ),
          Align(
              child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: CircleAvatar(
              radius: 60.0,
              backgroundColor: Colors.white,
            ),
          )),
          Align(
              child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: CircleAvatar(
              radius: 52.0,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
          )),
        ],
      ),
    );
Widget RowItem(context, String text, IconData icon) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
              child: Text(
            text,
            style: Theme.of(context).textTheme.bodyText2,
          )),
        ],
      ),
    );
