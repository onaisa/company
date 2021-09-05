import 'package:company/cubit/companyapp_cubit.dart';
import 'package:company/models/schedualmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowScedualScreen extends StatelessWidget {
  List<SchedualModel> list;
  ShowScedualScreen(this.list);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyappCubit, CompanyappState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'schedual',
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    BuildScedualItem(cont: context, model: list[index]),
                separatorBuilder: (context, index) => Divider(),
                itemCount: list.length),
          ),
        );
      },
    );
  }
}

Widget BuildScedualItem({BuildContext cont, SchedualModel model}) => Container(
      padding: const EdgeInsets.all(10.0),
      // child: Row(
      //   children: [
      //     Icon(Icons.date_range),
      //     SizedBox(
      //       width: 15.0,
      //     ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.date_range),
              SizedBox(
                width: 15.0,
              ),
              Text(
                model.dayDate,
                style: Theme.of(cont)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.orange),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.login),
              SizedBox(
                width: 15.0,
              ),
              Text(
                model.enterTime,
                style: Theme.of(cont).textTheme.bodyText2,
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.logout),
              SizedBox(
                width: 15.0,
              ),
              Text(
                "${model.exitTime}",
                style: Theme.of(cont).textTheme.bodyText2,
              ),
            ],
          ),
        ],
      ),
      //   ],
      // ),
    );
