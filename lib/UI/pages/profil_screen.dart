import 'package:cached_network_image/cached_network_image.dart';
import 'package:company/UI/component/component.dart';
import 'package:company/UI/component/conts.dart';
import 'package:company/UI/pages/showsceuale.dart';
import 'package:company/UI/pages/updateprofile_screen.dart';
import 'package:company/cubit/companyapp_cubit.dart';
import 'package:company/models/usermodel.dart';
import 'package:company/util/local_cred.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyappCubit, CompanyappState>(
      listener: (context, state) {},
      builder: (context, state) {
        CompanyappCubit cubit = CompanyappCubit.get(context);

        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HederItem(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Card(
                    elevation: 5.0,
                    child: BlocBuilder<CompanyappCubit, CompanyappState>(
                      builder: (context, state) {
                        if (cubit.userModel == null)
                          return Container(
                            height: MediaQuery.of(context).size.height - 400,
                            width: MediaQuery.of(context).size.width - 100,
                            child: Center(child: Text('no data ')),
                          );
                        else
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              RowItem(context, 'Name :${cubit.userModel.name}',
                                  Icons.person),
                              Divider(),
                              RowItem(
                                  context,
                                  'Phone : ${cubit.userModel.number}',
                                  Icons.phone),
                              Divider(),
                              RowItem(
                                  context,
                                  'Email : ${cubit.userModel.email}',
                                  Icons.email),
                              Divider(),
                              RowItem(
                                  context,
                                  'Offday : ${cubit.userModel.offDays}',
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
                    defaultButton(
                        function: () {
                          cubit.showScedual(id: userId);
                          navigateTo(
                              context, ShowScedualScreen(cubit.listschedual));
                        },
                        text: 'show schedual'),
                    // SizedBox(
                    //   width: 15.0,
                    // ),
                    defaultButton(
                        function: () {
                          navigateTo(
                              context, UpdateProfileScreen(cubit.userModel));
                        },
                        text: 'update'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
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
            Align(
                alignment: AlignmentDirectional.bottomStart,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: FutureBuilder(
                    // future: storage.getAuth(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return CircleAvatar(
                        radius: 60.0,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('assets/images/R.jpg')
                        // child: CachedNetworkImage(
                        //   imageUrl: "$img",
                        //   placeholder: (context, url) =>
                        //       CircularProgressIndicator(),
                        //   errorWidget: (context, url, i) =>
                        //       Image.asset('assets/images/R.jpg'),
                        // )
                        ,
                      );
                    },
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
}
