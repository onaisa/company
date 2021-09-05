import 'package:company/UI/component/component.dart';
import 'package:company/UI/pages/sendemail_screen.dart';
import 'package:company/UI/pages/showemployee.dart';
import 'package:company/UI/pages/showsceuale.dart';
import 'package:company/cubit/companyapp_cubit.dart';
import 'package:company/models/EmployeeModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllusersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyappCubit, CompanyappState>(
      listener: (context, state) {},
      builder: (context, state) {
        CompanyappCubit cubit = CompanyappCubit.get(context);

        return Center(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
              elevation: 5.0,
              child: BlocBuilder<CompanyappCubit, CompanyappState>(
                builder: (context, state) {
                  if (cubit.employees.length >= 0)
                    return ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return UserItem(
                            context,
                            cubit.employees[index],
                          );
                        },
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: cubit.employees.length);
                  else
                    return Container(
                        height: MediaQuery.of(context).size.height - 400,
                        width: MediaQuery.of(context).size.width - 200,
                        child: Center(child: CircularProgressIndicator()));
                },
              )),
        ));
      },
    );
  }

  Widget UserItem(BuildContext cont, EmployeeModel employeeModel) => InkWell(
        onTap: () {
          navigateTo(cont, ShowEmployeeDetileScreen(employeeModel.id));
        },
        child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.png'),
              radius: 30.0,
            ),
            title: Text(employeeModel.name),
            subtitle: Text(
              employeeModel.specialty,
              style: Theme.of(cont).textTheme.caption,
            ),
            trailing: Icon(
              Icons.arrow_right_sharp,
              color: Colors.teal,
            )),
      );
}
