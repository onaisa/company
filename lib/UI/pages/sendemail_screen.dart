import 'package:company/models/EmployeeModel.dart';
import 'package:flutter/material.dart';

class SendEmailScreen extends StatelessWidget {
  EmployeeModel model;
  SendEmailScreen(this.model);
  TextEditingController textconroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: Text(
                      model.name,
                      style: TextStyle(
                        color: Colors.teal[700],
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TextFormField(
                  controller: textconroller,
                  scrollPhysics: BouncingScrollPhysics(),
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'write email...',
                    // hintStyle: TextStyle(color: Colors.teal[300]),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xFF80CBC4))),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Icon(
              Icons.send,
              color: Colors.white,
            )));
  }
}
