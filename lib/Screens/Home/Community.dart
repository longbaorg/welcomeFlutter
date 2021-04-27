import 'package:dio/dio.dart';
import 'package:flutter_auth/Screens/Home/MyProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Home/components/ProteinInfo.dart';
import 'package:flutter_auth/utils/URL.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oktoast/oktoast.dart';
import 'components/PersonCell.dart';
import 'components/ReadOnlyProfile.dart';

class Community extends StatefulWidget {
  // @override
  // State<StatefulWidget> createState() => new GridViewState();
  @override
  _ListTestPageState createState() => _ListTestPageState();
}




class _ListTestPageState extends State<Community> {


  var personList = [];

  var titleList = [];
  var classification = [];
  var organism = [];
  var expressionSystem = [];
  var deposited = [];
  var depositionAuthor = [];
  var fastaSequence = [];

  var subTitleList = [];
  List<Image> iconList = [];
  Color mainColor = const Color(0xff3C3261);


  @override
  Widget build(BuildContext context) {
    List<Widget> _list = new List();
    for (int i = 0; i < personList.length; i++) {
      var personEntity = personList[i];
      _list.add(
          buildListData(
              context,
              titleList[i],
              iconList[i],
              subTitleList[i],
              classification[i],
              organism[i],
              expressionSystem[i],
              deposited[i],
              depositionAuthor[i],
              fastaSequence[i],
      ));
    }
    // 分割线
    var divideTitles =
    ListTile.divideTiles(context: context, tiles: _list).toList();
    return Scaffold(
      body: Scrollbar(
        child: listViewSeparated(),
      ),
    );
  }


  void getData() async {
    //获取数据
    String getUrl = baseURL + '/proteinInfo/selectAll';
    Dio dio = new Dio();

    var response = await dio.get(getUrl);

    print('Respone ${response.statusCode}');

    //前台似乎很方便? 因为后台已经处理了大部分逻辑! shit, 我是个全栈, 都由我来做!
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "sucess",
          gravity: ToastGravity.CENTER,
          textColor: Colors.grey);

      setState(() {
        //必须要通过这个来更新数据,否则将不会刷新页面
        personList = response.data;
        for(int i = 0 ;i<personList.length ; i++){
            titleList.add(personList[i]['name']);
            classification.add(personList[i]['classification']);
            organism.add(personList[i]['organism']);
            expressionSystem.add(personList[i]['expressionSystem']);
            deposited.add(personList[i]['deposited']);
            depositionAuthor.add(personList[i]['depositionAuthor']);
            fastaSequence.add(personList[i]['fastaSequence']);
            subTitleList.add(personList[i]['classification']);
            iconList.add(new Image(image: new NetworkImage(personList[i]['imageUrl']), fit: BoxFit.cover));
        }
      });
    }
    else {
      showToast("服务器或网络错误!");
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  ///默认构造方法
  Widget listView(List<Widget> _list) {
    return ListView(
      children: _list,
    );
  }

  /// ListView.builder
  Widget listViewBuilder() {
    return ListView.builder(
      //有分割线
      itemBuilder: (context, i) {
        return Container(
          child: Column(
            children: <Widget>[
              buildListData(context,
                  titleList[i],
                  iconList[i],
                  subTitleList[i],
                  classification[i],
                  organism[i],
                  expressionSystem[i],
                  deposited[i],
                  depositionAuthor[i],
                  fastaSequence[i]
              ),
              Divider(),
            ],
          ),
        );
      },
      itemCount: titleList.length,
    );
  }

  ///ListView.separated
  Widget listViewSeparated() {
    return ListView.separated(
        itemBuilder: (context, i) {
          return buildListData(
              context,
              titleList[i],
              iconList[i],
              subTitleList[i],
              classification[i],
              organism[i],
              expressionSystem[i],
              deposited[i],
              depositionAuthor[i],
              fastaSequence[i]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
        itemCount: titleList.length);
  }

  Widget buildListData(BuildContext context,
      String titleItem,
      Image iconItem,
      String subTitleItem,
      classification,
      organism,
      expressionSystem,
      deposited,
      depositionAuthor,
      fastaSequence
      ) {
    return ListTile(
      leading: iconItem ,
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      title: Text(
        titleItem,
        style: TextStyle(fontSize: 18.0),
      ),
      subtitle: Text(
        subTitleItem,
      ),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                '蛋小白信息',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                ),
              ),
              content: Text('名称:$titleItem\n分类:$classification\n生物体:$organism\n表达系统:$expressionSystem'
                  '\n发布时间:$deposited\n发布作者:$depositionAuthor\n氨基酸秀娥:$fastaSequence'),
            );
          },
        );
      },
    );
  }
}