import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/Signup/components/background.dart';
import 'package:flutter_auth/Screens/Signup/components/or_divider.dart';
import 'package:flutter_auth/Screens/Signup/components/social_icon.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:flutter_auth/utils/Check.dart';
import 'package:flutter_auth/utils/URL.dart';
import 'package:flutter_auth/utils/colorUtil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oktoast/oktoast.dart';

import '../../Home/Home.dart';



class Body extends StatelessWidget {
  String email="";
  String username="";
  String password="";
  TextEditingController makeSureControl=new TextEditingController();
  String token="";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "Sign Email",
              icon: Icons.alternate_email,
              onChanged: (value) {
                email=value;
              },
            ),
            RoundedInputField(
              hintText: "Username",
              icon: Icons.emoji_people,
              onChanged: (value) {
                username=value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                password=value;
              },
              myHintText: "Password",
            ),
            RoundedPasswordField(
              myController: makeSureControl,
              myHintText: "Make sure",
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                Padding(padding: EdgeInsets.only(left: 35.0)),
                Expanded(
                  child:
                  RoundedInputField(
                    hintText: "Token",
                    icon: Icons.code,
                    onChanged: (value) {
                      token=value;
                    },
                  ),
                ),
                Expanded(
                  child:
                  RoundedButton(
                    text: "Send",
                    color: colorButton1,
                    press: () {
                      //??????
                      print("?????????signup??????");
                      if(!isEmail(email)){
                        Fluttertoast.showToast(
                            msg: "?????????????????????!",
                            gravity: ToastGravity.CENTER,
                            textColor: Colors.grey);
                      }
                      else if(!isUsername(username)){
                        // showToast("??????????????????????????????");
                        Fluttertoast.showToast(
                          msg: "username 5~10??? ?????????????????? ????????????????????? ?????? _ ?????????????????????????????????",
                          gravity: ToastGravity.CENTER,
                          textColor: Colors.grey);
                      }
                      else if(!isPassword(password)){
                        Fluttertoast.showToast(
                            msg: "password 6~12??? ????????????????????? ?????? _ ",
                            gravity: ToastGravity.CENTER,
                            textColor: Colors.grey);
                      }
                      else if(!(makeSureControl.text==password)){
                        makeSureControl.clear();
                        Fluttertoast.showToast(
                            msg: "??????????????????????????????????????????",
                            gravity: ToastGravity.CENTER,
                            textColor: Colors.grey);
                      }

                      else{
                        print("try to send");
                        send();
                      }
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 40.0)),
              ],
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () {
                //??????
                SignUp(context);
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  //??????
  void SignUp(BuildContext context) async {
    String loginURL = baseURL+'/user/register';
    Dio dio = new Dio();

    var response = await dio.post(
        loginURL+"?token="+token,
        data: {'email': email, 'password': password,"username":username}
    );

    print('Respone ${response.statusCode}');
    print(response.data);

    //?????????????????????? ??????????????????????????????????????????! shit, ???????????????, ???????????????! shit ??????????????? ??????????????????
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: response.data,
          gravity: ToastGravity.CENTER,
          textColor: Colors.grey);

      if(response.data=="sucess"){
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => home(email: email,)));
      }
    }
    else{
      showToast("????????????????????????!");
    }
  }

  //???????????????
  void send() async {
    String sendURL = baseURL+"/user/send";
    Dio dio = new Dio();
    print("username:"+username);
    var response = await dio.post(
        sendURL,
        data: {'email': email, 'password': password,"username":username}
    );
    print('Respone ${response.statusCode}');
    print(response.data);
    //????????????????????????
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: response.data,
          gravity: ToastGravity.CENTER,
          textColor: Colors.grey);
      token=response.data.toString();
    }
    else{
      showToast("????????????????????????!");
    }
  }
}
