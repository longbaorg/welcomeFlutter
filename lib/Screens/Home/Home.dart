import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/Screens/Home/Community.dart';
import 'package:flutter_auth/utils/colorUtil.dart';
import 'Manager.dart';
import 'MyProfile.dart';

class home extends StatefulWidget {
  home({Key key, @required this.email}) : super(key: key);
  String email;

  @override
  homeState createState() => homeState();
}

//自定义的主页
class homeState extends State<home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 在Flutter中的每一个类都是一个控件
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        //用DefaultTabController包围,使每一个Tabbar都能对应一个页面
        appBar: PreferredSize(
            child: AppBar(
              title: Text("蛋小白"),
              backgroundColor: Colors.amber,
              centerTitle: true, //居中
              // actions: <Widget>[
              //   //右侧行为按钮
              //   IconButton(
              //     color: Colors.amber,
              //     icon: Icon(Icons.cast),
              //   )
              // ],
            ),
            preferredSize: Size.fromHeight(45)),


        drawer: Drawer(
          //侧面栏
            child: ListView(
              //一个列表// 抽屉可能在高度上超出屏幕，所以使用 ListView 组件包裹起来，实现纵向滚动效果
              // 干掉顶部灰色区域
              padding: EdgeInsets.all(0),
              // 所有抽屉中的子组件都定义到这里：
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountEmail: Text('luyao@163.com'),
                  accountName: Text("张璐瑶"),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2373827893,3715761695&fm=26&gp=0.jpg'),
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://gss0.baidu.com/70cFfyinKgQFm2e88IuM_a/forum/w=580/sign=7f408207d754564ee565e43183de9cde/7692f21fbe096b63c030e04406338744eaf8acc9.jpg')) //背景图片
                  ), //美化当前控件
                ),
                ListTile(
                  title: Text('用户反馈'),
                  trailing: Icon(
                    Icons.feedback,
                    color: Colors.blue,
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('系统设置'),
                  trailing: Icon(
                    Icons.settings,
                    color: Colors.lightGreenAccent,
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('发布'),
                  trailing: Icon(
                    Icons.send,
                    color: Colors.deepPurpleAccent,
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('注销'),
                  trailing: Icon(
                    Icons.exit_to_app,
                    color: Colors.amberAccent,
                  ),
                ),
              ],
            )),
        bottomNavigationBar: Container(
//           //底部导航栏
//           //美化
          decoration: BoxDecoration(
            color: colorBlueTestS,
            borderRadius: BorderRadius.circular(1),
          ),
          height: 50, //一般tabbar的高度为50
//        borderRadius: BorderRadius.circular(50),
          child: TabBar(
            labelStyle: TextStyle(height: 0, fontSize: 10),
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.supervised_user_circle_outlined),
                text: "首页",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Community(),
            // Manager(),
            // MyProfile(email: widget.email),
          ],
        ),
      ),
    );
  }
}

