import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "notifications",
          style: TextStyle(fontSize: 24.0, color: Colors.black),
        ),
        backgroundColor: Colors.orange[50],
      ),
      body: Container(
        color: Colors.orange[50],
        padding: const EdgeInsets.all(15.0),
        child: ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => Notificationitem(context),
            separatorBuilder: (context, index) => SizedBox(
                  height: 10.0,
                ),
            itemCount: 3),
      ),
    );
  }
}

Widget Notificationitem(BuildContext cont) => Container(
      padding: const EdgeInsets.all(10.0),
      height: 300.0,
      child: Card(
        // color: Colors.teal[50],
        elevation: 4.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image(
                  image: AssetImage('assets/images/notification.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Text('title ', style: Theme.of(cont).textTheme.bodyText1),
            SizedBox(
              height: 5.0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                    'Officia culpa do voluptate reprehenderit consectetur amet velit est excepteur non. '),
              ),
            ),
          ],
        ),
      ),
    );
