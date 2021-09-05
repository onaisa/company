import 'package:company/UI/component/component.dart';
import 'package:company/UI/component/conts.dart';

import 'package:company/UI/pages/login_screen.dart';
import 'package:company/UI/pages/notification_screen.dart';
import 'package:company/cubit/companyapp_cubit.dart';
import 'package:company/cubit/login_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayOutScreen extends StatefulWidget {
  @override
  _LayOutScreenState createState() => _LayOutScreenState();
}

class _LayOutScreenState extends State<LayOutScreen> {
  @override
  void initState() {
    CompanyappCubit.get(context).getAllEmployee();
    CompanyappCubit.get(context).getUserProfle();
    CompanyappCubit.get(context).getAllTaskes();
    CompanyappCubit.get(context).showScedual(id: userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyappCubit, CompanyappState>(
      listener: (context, state) {
        if (state is LogoutSuccessState) {
          showToast(text: "${state.message}", state: ToastStates.SUCCESS);
          navigateTo(context, LogInScreen());
        }
      },
      builder: (context, state) {
        CompanyappCubit cubit = CompanyappCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, NotificationsScreen());
                  },
                  icon: Icon(Icons.notifications)),
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 10.0),
                child: IconButton(
                  onPressed: () {
                    cubit.logout();
                  },
                  icon: Icon(Icons.logout_rounded),
                ),
              )
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              onTap: (int index) {
                cubit.chaangeBottobNavBar(index);
              },
              backgroundColor: Colors.white,
              elevation: 20.0,
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              selectedItemColor: Colors.orange,
              unselectedItemColor: Colors.grey,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.group),
                  label: 'Employees',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.task),
                  label: 'Taskes',
                )
              ]),
        );
      },
    );
  }
}
