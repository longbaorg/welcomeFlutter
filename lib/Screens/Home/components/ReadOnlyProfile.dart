import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/utils/Check.dart';
import 'package:flutter_auth/utils/URL.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';

class ReadOnlyProfile extends StatefulWidget {
  ReadOnlyProfile({Key key, @required this.email}) : super(key: key);
  final String email;

  @override
  ReadOnlyProfileState createState() {
    return new ReadOnlyProfileState();
  }
}

class ReadOnlyProfileState extends State<ReadOnlyProfile> {
  bool _status = true;
  String _asURL;
  File _image;
  final FocusNode myFocusNode = FocusNode();
  TextEditingController emailContr=new TextEditingController();
  TextEditingController usernameContr=new TextEditingController();
  TextEditingController nameContr=new TextEditingController();
  TextEditingController telephoneContr=new TextEditingController();
  TextEditingController ageContr=new TextEditingController();
  TextEditingController jobContr=new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    findByEmail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(
          color: Colors.white,
          child: new ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  new Container(
                    height: 250.0,
                    color: Colors.white,
                    child: new Column(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: 20.0, top: 20.0),
                            child: new Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Icon(
                                  Icons.emoji_people,
                                  color: Colors.greenAccent,
                                  size: 22.0,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 25.0),
                                  child: new Text('PROFILE',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                          fontFamily: 'sans-serif-light',
                                          color: Colors.blue
                                      )),
                                )
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: new Stack(fit: StackFit.loose, children: <Widget>[
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Container(
                                    width: 140.0,
                                    height: 140.0,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                        image: new NetworkImage(_asURL==null?defaultAsURL:_asURL),
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                              ],
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 90.0, right: 100.0),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    _getAsEditIcon(),
                                  ],
                                )),
                          ]),
                        )
                      ],
                    ),
                  ),
                  new Container(
                    color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Parsonal Information',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      _status ? _getEditIcon() : new Container(),
                                    ],
                                  )
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Email ID',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      decoration: const InputDecoration(hintText: "Enter Email ID"),
                                      controller: emailContr,
                                      onChanged: (value) {
                                        print("inputEmail: " + value);
                                      },
                                      enabled: false,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Username',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      decoration: const InputDecoration(
                                        hintText: "Enter Your Username",
                                      ),
                                      controller: usernameContr,
                                      onChanged: (value) {
                                        print("inputUsername: " + value);
                                      },
                                      enabled: !_status,
                                      autofocus: !_status,

                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Name',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      decoration: const InputDecoration(
                                          hintText: "Enter Your Name"),
                                      enabled: !_status,
                                      controller: nameContr,
                                      onChanged: (value) {
                                        print("inputName: " + value);
                                      },
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Mobile',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      decoration: const InputDecoration(
                                          hintText: "Enter Mobile Number"),
                                      enabled: !_status,
                                      controller: telephoneContr,
                                      onChanged: (value) {
                                        print("inputTel: " + value);
                                      },
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: new Text(
                                        'Age',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: new Text(
                                        'Job',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: new TextField(
                                        decoration: const InputDecoration(
                                            hintText: "Enter Age"),
                                        enabled: !_status,
                                        controller: ageContr,
                                        onChanged: (value) {
                                          print("inputAge: " + value);
                                        },
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                  Flexible(
                                    child: new TextField(
                                      decoration: const InputDecoration(
                                          hintText: "Enter Job"),
                                      enabled: !_status,
                                      controller: jobContr,
                                      onChanged: (value) {
                                        print("inputJob: " + value);
                                      },
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )),
                          !_status ? _getActionButtons() : new Container(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    // ????????????,????????????
    myFocusNode.dispose();
    emailContr.dispose();
    usernameContr.dispose();
    nameContr.dispose();
    telephoneContr.dispose();
    ageContr.dispose();
    jobContr.dispose();

    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Save"),
                    textColor: Colors.white,
                    color: Colors.green,
                    onPressed: () {
                      //??????????????????
                      if(!isMobile(telephoneContr.text)){
                        Fluttertoast.showToast(
                            msg: "??????????????????????????????",
                            gravity: ToastGravity.CENTER,
                            textColor: Colors.grey);
                      }
                      else if(!isAge(ageContr.text)){
                        Fluttertoast.showToast(
                            msg: "?????????????????????",
                            gravity: ToastGravity.CENTER,
                            textColor: Colors.grey);
                      }
                      else {
                        update(); //??????
                        setState(() {
                          _status = true;
                          FocusScope.of(context).requestFocus(new FocusNode());
                        });
                      }
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Cancel"),
                    textColor: Colors.white,
                    color: Colors.red,
                    onPressed: () {
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
      },
    );
  }

  Widget _getAsEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.redAccent,
        radius: 20.0,
        child: new Icon(
          Icons.camera_alt,
          color: Colors.white,
          size: 18.0,
        ),
      ),
      onTap: () {
      },
    );
  }

  //????????????
  Future<List> findByEmail() async {
    print(widget.email);
    String findUrl = baseURL+'/profile/findByEmail?email='+widget.email;
    Dio dio = new Dio();

    var response = await dio.get(findUrl);

    print('Respone ${response.statusCode}');
    print(response.data);
    //?????????????????????? ??????????????????????????????????????????! shit, ???????????????, ???????????????!
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "sucess",
          gravity: ToastGravity.CENTER,
          textColor: Colors.grey);

      print("--------------------");
      emailContr.text=response.data["email"];
      usernameContr.text=response.data["username"];
      nameContr.text=response.data["name"];
      telephoneContr.text=response.data["telephone"];
      ageContr.text=(response.data["age"]==null)?"":response.data["age"].toString();
      jobContr.text=response.data["job"];
      setState(() {
        _asURL=response.data["path"];
      });
    }
    else{
      showToast("????????????????????????!");
    }
  }

  //??????
  void update() async {
    String loginURL = baseURL+'/profile/update';
    Dio dio = new Dio();
    var response = await dio.post(
        loginURL,
        data: {
          "email":emailContr.text,
          "username":usernameContr.text,
          "name":nameContr.text,
          "telephone":telephoneContr.text,
          "age":int.parse(ageContr.text),//??????int
          "job":jobContr.text
        });

    print('Respone ${response.statusCode}');
    print(response.data);
    //?????????????????????? ??????????????????????????????????????????! shit, ???????????????, ???????????????!
    if (response.statusCode == 200) {
      showToast("sucess");
    }
    else{
      showToast("????????????????????????!");
      //???????????????????????????????????????
      findByEmail();
    }
  }

  //?????????????????????
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if(_image==null) return;
    _upLoadImage(image);//????????????
    findByEmail();
    setState(() {
      _image = image;
    });
  }


  //????????????
  void _upLoadImage(File image) async {
    String path = image.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);

    FormData formdata = FormData.fromMap({
      "file": await MultipartFile.fromFile(path, filename:name)
    });

    Dio dio = new Dio();
    var respone = await dio.post<String>(baseURL+"/image/update?email="+widget.email, data: formdata);
    if (respone.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "??????????????????",
          gravity: ToastGravity.CENTER,
          textColor: Colors.grey);
      initState();
    }
  }

}