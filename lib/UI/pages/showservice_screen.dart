import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:company/UI/component/component.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class BoardModel {
  final String image;
  final String title;
  final String body;
  BoardModel({this.image, this.title, this.body});
}

class ShowServiceScreen extends StatefulWidget {
  @override
  _ShowServiceScreenState createState() => _ShowServiceScreenState();
}

class _ShowServiceScreenState extends State<ShowServiceScreen> {
  List<BoardModel> boarding = [
    BoardModel(
        image: 'assets/images/mopile.png',
        title: 'Mopile Application',
        body:
            ' Service 1 Nulla amet nulla do velit nulla enim. Commodo eiusmod consequat proident laborum ipsum incididunt in sunt mollit culpa consectetur aliquip incididunt anim. Ipsum aliquip irure laboris sit. Officia labore exercitation nisi mollit velit.'),
    BoardModel(
        image: 'assets/images/desktop.png',
        title: ' Desktop Application',
        body:
            '  Service 2 nulla incididunt duis elit consectetur exercitation. Qui excepteur reprehenderit voluptate cupidatat qui fugiat Lorem proident anim laborum do id consectetur. Nulla officia nisi commodo consectetur excepteur esse culpa incididunt elit ea officia quis ea. Tempor qui ullamco deserunt do qui officia amet.'),
    BoardModel(
        image: 'assets/images/wordpress.png',
        title: 'Web Application',
        body:
            'Service 3 Laboris ea sint incididunt laborum Lorem officia. Deserunt nulla ex do aute cupidatat. Non magna et dolore fugiat proident nisi aliquip esse id commodo proident.'),
  ];

  var boardconroller = PageController();

  double currentindex = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        titleSpacing: 0.0,
        title: CircleAvatar(
          backgroundColor: Colors.white,
          child: Image(
            image: AssetImage('assets/images/file.png'),
            fit: BoxFit.contain,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                AwesomeDialog(
                    context: context,
                    dialogType: DialogType.INFO,
                    btnOk: defaultButton(
                        function: () {
                          Navigator.pop(context);
                        },
                        text: 'ok'),
                    customHeader: Image.asset('assets/images/file.png'),
                    body: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                          // color: Colors.teal[50],
                          elevation: 5.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                'We are a digital transformation consultancy and software development company that provides cutting edge engineering solutions, helping Fortune 500 companies and enterprise clients untangle complex issues that always emerge during their digital evolution journey. Since 2007 we have been a visionary and a reliable software engineering partner for world-class brands.'),
                          )),
                    ))
                  ..show();
              },
              icon: Icon(Icons.group)),
          Padding(
              padding: const EdgeInsetsDirectional.only(end: 10.0),
              child: IconButton(
                  onPressed: () {
                    AwesomeDialog(
                      width: double.infinity,
                      context: context,
                      customHeader: Image.asset('assets/images/file.png'),
                      body: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 5.0,
                          child: Column(
                            children: [
                              ListTile(
                                leading: Icon(Icons.email),
                                title: Text('onaisa@gmail.com',
                                    style: TextStyle(fontSize: 16.0)),
                                // subtitle: Text('0991726325'),
                              ),
                              ListTile(
                                leading: Icon(Icons.phone),
                                title: Text('0991726325'),
                              ),
                              Divider(),
                              ListTile(
                                leading: Icon(Icons.email),
                                title: Text('Hiba@gmail.com',
                                    style: TextStyle(fontSize: 16.0)),
                                // subtitle: Text('0991726325'),
                              ),
                              ListTile(
                                leading: Icon(Icons.phone),
                                title: Text('0943563060'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      btnOk: defaultButton(
                          function: () {
                            Navigator.pop(context);
                          },
                          text: 'ok'),
                    )..show();
                  },
                  icon: Icon(Icons.email))),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                  controller: boardconroller,
                  onPageChanged: (int index) {
                    setState(() {
                      currentindex = index.toDouble();
                    });
                  },
                  physics: BouncingScrollPhysics(),
                  itemCount: boarding.length,
                  itemBuilder: (context, index) {
                    return boardingItem(boarding[index], context);
                  }),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                new DotsIndicator(
                  dotsCount: boarding.length,
                  position: currentindex,
                  decorator: DotsDecorator(
                    size: const Size.square(
                      12.0,
                    ),
                    activeSize: const Size(40.0, 12.0),
                    activeColor: Colors.orange,
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
                Spacer(),
                defaultTextButton(function: () {}, text: 'Get Service Now')
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget boardingItem(BoardModel model, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Image(
            image: AssetImage('${model.image}'),
            fit: BoxFit.contain,
          ),
        ),
        Text(
          '${model.title}',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        SizedBox(
          height: 10.0,
        ),
        Expanded(flex: 1, child: Text('${model.body}')),
        SizedBox(
          height: 50.0,
        ),
      ],
    );
  }
}
