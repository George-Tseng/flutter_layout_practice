import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.orange,
        accentColor: Colors.orangeAccent,
      ),
      home: null,
      /* 路由表 */
      routes: {
        '/': (BuildContext context) => T002(), //首頁
      },
      /* 路由表(帶參數) */
      onGenerateRoute: (RouteSettings settings) {
        return null;
      },
      /* 路由失敗時 */
      onUnknownRoute: (RouteSettings settings) {
        return null;
      },
    );
  }
}

class T002 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _T002();
  }
}

class _T002 extends State<T002> {
  List<String> idList = List<String>();

  List<Target> productList = List<Target>();

  List<Map<String, dynamic>> dataList = List<Map<String, dynamic>>();

  Target selectedProduct;

  int page = 5;

  DateFormat customFormat = DateFormat('yyyyMMdd');

  DateTime nowDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    setState(() {
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('曾丙顥', style: TextStyle(fontSize: 20)),
            centerTitle: true, //文字是否置中
            automaticallyImplyLeading: false), //取消預設返回
        body: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(width: 10),
                    SizedBox(
                        child: Text('商品清單',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))),
                    Expanded(child: SizedBox()), //利用Expanded填滿剩餘空間
                    IconButton(
                      icon: Icon(Icons.add),
                      color: Colors.green,
                      iconSize: 20.0,
                      onPressed: () {
                        //前往新增
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => T00201(idList: idList)));
                      },
                    ),
                  ],
                ),
                _buildTitle(),
                Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: _buildList(productList),
                  ),
                ),
                SizedBox(height: 10),
                Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.5 - 15,
                    child: _buildList2(selectedProduct),
                  ),
                ),
              ],
            )));
  }

  Widget _buildTitle() {
    return Row(
      children: <Widget>[
        SizedBox(width: MediaQuery.of(context).size.width * 0.025),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.325,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(
                    color: Colors.white, width: 1, style: BorderStyle.solid)),
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0), //字體稍微跟左邊有隔開
            child: Text('料號',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                )),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(
                    color: Colors.white, width: 1, style: BorderStyle.solid)),
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0), //字體稍微跟左邊有隔開
            child: Text('品名',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                )),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.225,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(
                    color: Colors.white, width: 1, style: BorderStyle.solid)),
            child: Text('庫存量',
                textAlign: TextAlign.center, //字體置中
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                )),
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.025),
      ],
    );
  }

  Widget _buildList(List<Target> productList) {
    if (productList == null)
      return Container();
    else {
      return ListView.builder(
          shrinkWrap: true, //可能的話就進行壓縮
          itemCount: productList.length > page ? page : productList.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildItem(productList, index);
          });
    }
  }

  Widget _buildItem(List<Target> productList, int index) {
    return Row(
      children: <Widget>[
        SizedBox(width: MediaQuery.of(context).size.width * 0.025),
        SizedBox(
          width: 30,
          height: 30,
          child: IconButton(
            icon: Icon(Icons.clear),
            color: Colors.orange,
            iconSize: 20.0,
            onPressed: () {},
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.325 - 30,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
                color: index % 2 == 0 ? Colors.blue : Colors.green,
                border: Border.all(
                    color: Colors.black, width: 1, style: BorderStyle.solid)),
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0), //字體稍微跟左邊有隔開
            child: GestureDetector(
              onLongPress: () {
                //前往修改
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            T00202(list: productList[index])));
              },
              onTap: () {
                setState(() {
                  selectedProduct = productList[index];
                });
              },
              child: Text(productList[index].r01,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
                color: index % 2 == 0 ? Colors.blue : Colors.green,
                border: Border.all(
                    color: Colors.black, width: 1, style: BorderStyle.solid)),
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0), //字體稍微跟左邊有隔開
            child: GestureDetector(
              onLongPress: () {
                //前往修改
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            T00202(list: productList[index])));
              },
              onTap: () {
                setState(() {
                  selectedProduct = productList[index];
                });
              },
              child: Text(productList[index].r02,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.225,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
                color: index % 2 == 0 ? Colors.blue : Colors.green,
                border: Border.all(
                    color: Colors.black, width: 1, style: BorderStyle.solid)),
            child: GestureDetector(
              onLongPress: () {
                //前往修改
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            T00202(list: productList[index])));
              },
              onTap: () {
                setState(() {
                  selectedProduct = productList[index];
                });
              },
              child: Text(productList[index].r03.toString(),
                  textAlign: TextAlign.center, //字體置中
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
            ),
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.025),
      ],
    );
  }

  Widget _buildList2(Target selectedProduct) {
    if (selectedProduct == null)
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(width: 10),
                SizedBox(
                    child: Text('商品詳細資訊',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))),
              ],
            ),
          ],
        ),
      );
    else {
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(width: 10),
                SizedBox(
                    child: Text('商品詳細資訊',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))),
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(width: MediaQuery.of(context).size.width * 0.025),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 60),
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height * 0.2,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                    style: BorderStyle.solid)),
                          ),
                        ),
                        SizedBox(height: 45),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.025),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.625,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        _buildDetail('料號', selectedProduct.r01),
                        _buildDetail('品名', selectedProduct.r02),
                        _buildDetail2(
                            '庫存量', selectedProduct.r03, selectedProduct.r07),
                        _buildDetail('產地', selectedProduct.r04),
                        _buildDetail('單價', selectedProduct.r05.toString()),
                        _buildDetail(
                            '產品金額',
                            (selectedProduct.r05 * 1.2)
                                .roundToDouble()
                                .toStringAsFixed(0)),
                        _buildDetail2('有效日期', int.parse(selectedProduct.r06),
                            int.parse('${customFormat.format(nowDate)}')),
                        _buildDetail('安庫量', selectedProduct.r07.toString()),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.025),
              ],
            ),
          ],
        ),
      );
    }
  }

  Widget _buildDetail(String title, String value) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.325 - 30,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(
                    color: Colors.black, width: 1, style: BorderStyle.solid)),
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0), //字體稍微跟左邊有隔開
            child: Text(title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                )),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3 + 30,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: Colors.black, width: 1, style: BorderStyle.solid)),
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0), //字體稍微跟左邊有隔開
            child: Text(value,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                )),
          ),
        )
      ],
    );
  }

  Widget _buildDetail2(String title, int value, int value2) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.325 - 30,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(
                    color: Colors.black, width: 1, style: BorderStyle.solid)),
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0), //字體稍微跟左邊有隔開
            child: Text(title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                )),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3 + 30,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: Colors.black, width: 1, style: BorderStyle.solid)),
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0), //字體稍微跟左邊有隔開
            child: value > value2
                ? Text(value.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ))
                : Text(value.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                    )),
          ),
        )
      ],
    );
  }

  //離線版
  void getData() {
    List<Target> tmpProduct = <Target>[
      Target('G000', '罐裝咖啡', 480, 'P01', '臺灣', 30, '20200630', 120, '曾丙顥',
          '2020-04-26 20:00:00', '', ''),
      Target('G001', '罐裝綠茶', 360, 'P02', '日本', 25, '20200630', 480, '曾丙顥',
          '2020-04-26 20:05:00', '', ''),
      Target('G002', '罐裝烏龍茶', 240, 'P03', '中國', 25, '20200401', 480, '曾丙顥',
          '2020-04-26 20:10:00', '', ''),
      Target('G003', '罐裝紅茶', 360, 'P06', '俄羅斯', 25, '20200630', 480, '曾丙顥',
          '2020-04-26 20:15:00', '', ''),
      Target('G004', '罐裝奶茶', 240, 'P04', '泰國', 25, '20200401', 360, '曾丙顥',
          '2020-04-26 20:20:00', '', ''),
      Target('G005', '罐裝汽水', 480, 'P05', '美國', 25, '20200630', 120, '曾丙顥',
          '2020-04-26 20:25:00', '', ''),
    ];
    setState(() {
      productList = tmpProduct;
    });

    for (Target tmpItem in tmpProduct) {
      idList.add(tmpItem.r01);
    }
  }
}

class T00201 extends StatefulWidget {
  //定義
  final List<String> idList;

  //建構
  T00201({
    Key key,
    @required this.idList,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _T00201();
  }
}

class _T00201 extends State<T00201> {
  final TextEditingController _controller01 = TextEditingController();
  final TextEditingController _controller02 = TextEditingController();
  final TextEditingController _controller03 = TextEditingController();
  final TextEditingController _controller05 = TextEditingController();
  final TextEditingController _controller07 = TextEditingController();

  final FocusNode node01 = FocusNode();
  final FocusNode node02 = FocusNode();
  final FocusNode node03 = FocusNode();
  final FocusNode node04 = FocusNode();
  final FocusNode node05 = FocusNode();
  final FocusNode node07 = FocusNode();

  List<DropdownMenuItem<String>> location = List<DropdownMenuItem<String>>();

  List<String> idList = List<String>();
  List<String> searchedList = List<String>();

  List<Target> productList = List<Target>();

  List<Map<String, dynamic>> dataList = List<Map<String, dynamic>>();

  String r01; //料號
  String r02; //品名
  String r04; //產地代碼
  String r06; //有效日期
  String r08 = '曾丙顥'; //建立人員
  String r09; //建立日期
  String queryStringAdd; //查詢語句

  int r03; //庫存量
  int r05; //單價
  int r055; //金額
  int r07; //安庫量

  bool btnSave = true; //儲存時防連點

  DateFormat customFormat = DateFormat('yyyyMMdd');
  DateFormat customFormat2 = DateFormat('yyyy-MM-dd HH:mm:ss');

  DateTime inputDate = DateTime.now();
  DateTime inputDate2;

  @override
  void initState() {
    super.initState();
    setState(() {
      getLocation();
      idList = widget.idList;
      r06 = '${customFormat.format(inputDate)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('曾丙顥', style: TextStyle(fontSize: 20)),
          centerTitle: true, //文字是否置中
          automaticallyImplyLeading: false), //取消預設返回
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
              child: Row(
                children: <Widget>[
                  SizedBox(width: 10),
                  SizedBox(
                      child: Text('新增資料',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                  SizedBox(width: 10),
                  Flexible(
                    child: ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        //水平捲動ListView
                        scrollDirection: Axis.horizontal,
                        itemCount: searchedList.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return FlatButton(
                            onPressed: () {
                            },
                            child: Text(searchedList[index]),
                          );
                        }),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
            SizedBox(height: 10),
            _buildList0('料號', '請輸入料號(必填)', _controller01, 20,
                TextInputType.text, null, true, node01, node02),
            _buildList('品名', '請輸入品名(必填)', _controller02, 50, TextInputType.text,
                null, true, node02, node03),
            _buildList(
                '庫存量',
                '請輸入庫存量',
                _controller03,
                4,
                TextInputType.number,
                [WhitelistingTextInputFormatter.digitsOnly],
                true,
                node03,
                node03),
            _buildList2('產地', '下拉以選擇產地', node04, node05),
            _buildList(
                '單價',
                '請輸入單價(必填)',
                _controller05,
                3,
                TextInputType.number,
                [WhitelistingTextInputFormatter.digitsOnly],
                true,
                node05,
                node07),
            _buildList4('金額', _controller05),
            _buildList3('有效日期'),
            _buildList(
                '安庫量',
                '請輸入安庫量(必填)',
                _controller07,
                3,
                TextInputType.number,
                [WhitelistingTextInputFormatter.digitsOnly],
                true,
                node07,
                node07),
            SizedBox(height: 10),
            _buildButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildList0(
      String title,
      String message,
      TextEditingController controller,
      int maxLength,
      TextInputType keyboardType,
      List<TextInputFormatter> limit,
      bool enabled,
      FocusNode node,
      FocusNode node0) {
    return Row(
      children: <Widget>[
        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(
                    color: Colors.black, width: 1, style: BorderStyle.solid)),
            child: Text(title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                )),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.65,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black, width: 1, style: BorderStyle.solid)),
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              maxLength: maxLength,
              inputFormatters: limit,
              focusNode: node,
              decoration: InputDecoration(
                hintText: message, //輸入提示
                counterText: '', //取消顯示MaxLength的數字，並盡量不影響高度
              ),
              enabled: enabled,
              //按下確認後才準備跳至下個欄位
              onSubmitted: (value) {
                if (node != node0) {
                  node.unfocus();
                  FocusScope.of(context).requestFocus(node0);
                }
              },
              onChanged: (value) {
                setState(() {
                  value = controller.text;
                  _searchPK(value);
                });
              },
            ),
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
      ],
    );
  }

  Widget _buildList(
      String title,
      String message,
      TextEditingController controller,
      int maxLength,
      TextInputType keyboardType,
      List<TextInputFormatter> limit,
      bool enabled,
      FocusNode node,
      FocusNode node0) {
    return Row(
      children: <Widget>[
        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(
                    color: Colors.black, width: 1, style: BorderStyle.solid)),
            child: Text(title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                )),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.65,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black, width: 1, style: BorderStyle.solid)),
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              maxLength: maxLength,
              inputFormatters: limit,
              focusNode: node,
              decoration: InputDecoration(
                hintText: message, //輸入提示
                counterText: '', //取消顯示MaxLength的數字，並盡量不影響高度
              ),
              enabled: enabled,
              //按下確認後才準備跳至下個欄位
              onSubmitted: (value) {
                if (node != node0) {
                  node.unfocus();
                  FocusScope.of(context).requestFocus(node0);
                }
              },
              onChanged: (value) {
                setState(() {
                  value = controller.text;
                });
              },
            ),
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
      ],
    );
  }

  Widget _buildList2(
      String title, String message, FocusNode node, FocusNode node0) {
    return Row(
      children: <Widget>[
        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(
                    color: Colors.black, width: 1, style: BorderStyle.solid)),
            child: Text(title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                )),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.65,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black, width: 1, style: BorderStyle.solid)),
            child: DropdownButton(
                value: r04,
                iconSize: 20,
                elevation: 16,
                focusNode: node,
                style: TextStyle(
                    color: Colors.black, //字體顏色
                    fontSize: 15, //字體大小
                    decoration: TextDecoration
                        .none, //額外裝飾，ex.刪除線<.lineThrough>、底線<.underline>、頂線<.overline>
                    fontWeight: FontWeight.w200), //字體粗細
                hint: Text(message),
                items: location,
                onChanged: (String selectedItem) {
                  setState(() {
                    r04 = selectedItem;
                  });
                  node.unfocus();
                  FocusScope.of(context).requestFocus(node0);
                }),
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.05)
      ],
    );
  }

  Widget _buildList3(String title) {
    return Row(
      children: <Widget>[
        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(
                    color: Colors.black, width: 1, style: BorderStyle.solid)),
            child: Text(title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                )),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.65,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black, width: 1, style: BorderStyle.solid)),
            child: GestureDetector(
              onTap: () {
                showPicker(context);
              },
              child: Container(child: Text(r06)),
            ),
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
      ],
    );
  }

  Widget _buildList4(String title, TextEditingController controller) {
    return Row(
      children: <Widget>[
        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(
                    color: Colors.black, width: 1, style: BorderStyle.solid)),
            child: Text(title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                )),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.65,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black, width: 1, style: BorderStyle.solid)),
            child: controller.text == ''
                ? Text('0')
                : Text((int.parse(controller.text) * 1.2)
                    .roundToDouble()
                    .toStringAsFixed(0)),
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
      ],
    );
  }

  Widget _buildButton() {
    return Row(
      children: <Widget>[
        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
        SizedBox(
          child: Container(
            child: FlatButton(
              onPressed: () {
                //返回
                Navigator.pop(context);
              },
              child: Text('取消', style: TextStyle(fontSize: 20)),
              color: Colors.blue, //顏色設定
              colorBrightness: Brightness.dark,
            ),
          ),
        ),
        SizedBox(width: 10),
        SizedBox(
          child: Container(
            child: FlatButton(
              onPressed: () {
                if (btnSave) {
                  btnSave = false;
                  inputCheckAdd();
                }
              },
              child: Text('儲存', style: TextStyle(fontSize: 20)),
              color: Colors.blue, //顏色設定
              colorBrightness: Brightness.dark,
            ),
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
      ],
    );
  }

  //離線版
  void getLocation() {
    List<DropdownMenuItem<String>> place = <DropdownMenuItem<String>>[
      DropdownMenuItem<String>(value: 'P01', child: Text('臺灣')),
      DropdownMenuItem<String>(value: 'P02', child: Text('日本')),
      DropdownMenuItem<String>(value: 'P03', child: Text('中國')),
      DropdownMenuItem<String>(value: 'P04', child: Text('泰國')),
      DropdownMenuItem<String>(value: 'P05', child: Text('美國')),
      DropdownMenuItem<String>(value: 'P06', child: Text('俄羅斯')),
    ];
    setState(() {
      location = place;
    });
  }

  void _searchPK(String key) {
    //輸入不為空
    if (key != '') {
      //驗證用
      print('key is: ' + key);

      setState(() {
        //清空List
        searchedList.clear();
        //for in查詢
        for (String rightKey in idList) {
          if (rightKey.toLowerCase().indexOf(key.toLowerCase()) >= 0) {
            //驗證用
            print('rightKey is:' + rightKey);
            searchedList.add(rightKey);
          }
        }
      });
    }
    //輸入為空
    else {
      setState(() {
        searchedList.clear();
      });
    }
  }

  void inputCheckAdd() {
    int _result = 0; //設定顯示錯誤訊息用

    //料號
    if (_controller01.text == '')
      _result = -1;
    else if (idList != null) {
      if (idList.indexOf(_controller01.text) != -1) _result = -2;
    } else
      setState(() {
        r01 = _controller01.text;
      });
    //品名
    if (_controller02.text == '') {
      if (_result == 0) _result = -3;
    } else
      setState(() {
        r02 = _controller02.text;
      });
    //庫存量
    if (_controller03.text == '')
      setState(() {
        r03 = 0;
      });
    else if (int.parse(_controller03.text) > 1000) {
      if (_result == 0) _result = -4;
    } else
      setState(() {
        r03 = int.parse(_controller03.text);
      });
    //產地代碼
    if (r04 == null) {
      if (_result == 0) _result = -5;
    }
    //單價
    if (_controller05.text == '') {
      if (_result == 0) _result = -6;
    } else
      setState(() {
        r05 = int.parse(_controller05.text);
      });
    //金額
    //有效日期
    //安庫量
    if (_controller07.text == '') {
      if (_result == 0) _result = -7;
    } else {
      setState(() {
        r07 = int.parse(_controller07.text);
      });
    }

    //顯示錯誤訊息用
    if (_result == 0) {
      //設定建立日期
      inputDate2 = DateTime.now();
      r09 = '${customFormat2.format(inputDate2)}';
      getQueryStringAdd();
    } else {
      btnSave = true;
      if (_result == -1) {
        print('輸入錯誤: 料號不可空白');
        MessageBox.showMessage(context, true, '「料號」 不可空白');
        FocusScope.of(context).requestFocus(node01); //聚焦在欄位一
      } else if (_result == -2) {
        print('輸入錯誤: 料號不可重複');
        MessageBox.showMessage(context, true, '「料號」 不可重複');
        FocusScope.of(context).requestFocus(node01); //聚焦在欄位一
      } else if (_result == -3) {
        print('輸入錯誤: 品名不可空白');
        MessageBox.showMessage(context, true, '「品名」 不可空白');
        FocusScope.of(context).requestFocus(node02); //聚焦在欄位二
      } else if (_result == -4) {
        print('輸入錯誤: 庫存量不可超過1000');
        MessageBox.showMessage(context, true, '「庫存量」 不可超過 1000');
        FocusScope.of(context).requestFocus(node03); //聚焦在欄位三
      } else if (_result == -5) {
        print('輸入錯誤: 產地不可空白');
        MessageBox.showMessage(context, true, '「產地」 不可空白');
        FocusScope.of(context).requestFocus(node04); //聚焦在欄位四
      } else if (_result == -6) {
        print('輸入錯誤: 單價不可空白');
        MessageBox.showMessage(context, true, '「單價」 不可空白');
        FocusScope.of(context).requestFocus(node05); //聚焦在欄位五
      } else if (_result == -7) {
        print('輸入錯誤: 安庫量不可空白');
        MessageBox.showMessage(context, true, '「安庫量」 不可空白');
        FocusScope.of(context).requestFocus(node07); //聚焦在欄位七
      }
    }
  }

  void getQueryStringAdd() {
    StringBuffer buf1 = StringBuffer();
    buf1.write(
        "insert into EntireV4.dbo.T002(R01 ,R02, R03, R04, R05, R06, R07, R08, R09 values('$r01', N'$r02', $r03, '$r04', $r05, '$r06', $r07, N'$r08', '$r09')");

    setState(() {
      queryStringAdd = buf1.toString();
    });
    print('新增語法為: ' + queryStringAdd);

    insertData(queryStringAdd);
  }

  //離線版
  void insertData(String queryStringAdd) {
    Target tmpProduct =
        Target(r01, r02, r03, r04, '', r05, r06, r07, r08, r09, '', '');
    productList.add(tmpProduct);

    MessageBox.showMessage(context, false, '已完成新增工作');
  }

  Future<Null> showPicker(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2001),
        lastDate: DateTime(2101));

    if (pickedDate != null && pickedDate != inputDate) {
      setState(() {
        inputDate = pickedDate;
        r06 = '${customFormat.format(inputDate)}';
      });
    }
  }
}

class T00202 extends StatefulWidget {
  //定義
  final Target list;

  //建構
  T00202({
    Key key,
    @required this.list,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _T00202();
  }
}

class _T00202 extends State<T00202> {
  final TextEditingController _controller01 = TextEditingController();
  final TextEditingController _controller02 = TextEditingController();
  final TextEditingController _controller03 = TextEditingController();
  final TextEditingController _controller05 = TextEditingController();
  final TextEditingController _controller07 = TextEditingController();

  final FocusNode node02 = FocusNode();
  final FocusNode node03 = FocusNode();
  final FocusNode node04 = FocusNode();
  final FocusNode node05 = FocusNode();
  final FocusNode node07 = FocusNode();

  List<DropdownMenuItem<String>> location = List<DropdownMenuItem<String>>();

  List<String> idList = List<String>();

  List<Target> productList = List<Target>();

  List<Map<String, dynamic>> dataList = List<Map<String, dynamic>>();

  String r01; //料號
  String r02; //品名
  String r04; //產地代碼
  String r06; //有效日期
  String r08; //建立人員
  String r10 = '曾丙顥'; //修改人員
  String r11; //修改日期
  String queryStringModify; //查詢語句

  int r03; //庫存量
  int r05; //單價
  int r055; //金額
  int r07; //安庫量

  bool btnSave = true; //儲存時防連點

  DateFormat customFormat = DateFormat('yyyyMMdd');
  DateFormat customFormat2 = DateFormat('yyyy-MM-dd HH:mm:ss');

  DateTime inputDate = DateTime.now();
  DateTime inputDate2;

  @override
  void initState() {
    super.initState();
    setState(() {
      getLocation();
      r01 = widget.list.r01;
      _controller01.text = widget.list.r01;
      _controller02.text = widget.list.r02;
      _controller03.text = widget.list.r03.toString();
      r04 = widget.list.r04;
      _controller05.text = widget.list.r05.toString();
      r06 = widget.list.r06;
      _controller07.text = widget.list.r07.toString();
      r08 = widget.list.r08;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('George', style: TextStyle(fontSize: 20)),
          centerTitle: true, //文字是否置中
          automaticallyImplyLeading: false), //取消預設返回
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(width: 10),
                SizedBox(
                    child: Text('修改資料',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))),
              ],
            ),
            SizedBox(height: 10),
            _buildList('料號', '請輸入料號(必填)', _controller01, 20, TextInputType.text,
                null, false, node02, node02),
            _buildList('品名', '請輸入品名(必填)', _controller02, 50, TextInputType.text,
                null, true, node02, node03),
            _buildList(
                '庫存量',
                '請輸入庫存量(必填)',
                _controller03,
                4,
                TextInputType.number,
                [WhitelistingTextInputFormatter.digitsOnly],
                true,
                node03,
                node04),
            _buildList2('產地', '下拉以選擇產地', node04, node04),
            _buildList(
                '單價',
                '請輸入單價(必填)',
                _controller05,
                3,
                TextInputType.number,
                [WhitelistingTextInputFormatter.digitsOnly],
                true,
                node05,
                node07),
            _buildList4('金額', _controller05),
            _buildList3('有效日期'),
            _buildList(
                '安庫量',
                '請輸入安庫量(必填)',
                _controller07,
                3,
                TextInputType.number,
                [WhitelistingTextInputFormatter.digitsOnly],
                true,
                node07,
                node07),
            SizedBox(height: 10),
            _buildButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildList(
      String title,
      String message,
      TextEditingController controller,
      int maxLength,
      TextInputType keyboardType,
      List<TextInputFormatter> limit,
      bool enabled,
      FocusNode node,
      FocusNode node0) {
    return Row(
      children: <Widget>[
        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(
                    color: Colors.black, width: 1, style: BorderStyle.solid)),
            child: Text(title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                )),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.65,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black, width: 1, style: BorderStyle.solid)),
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              maxLength: maxLength,
              inputFormatters: limit,
              focusNode: node,
              decoration: InputDecoration(
                hintText: message, //輸入提示
                counterText: '', //取消顯示MaxLength的數字，並盡量不影響高度
              ),
              enabled: enabled,
              //按下確認後才準備跳至下個欄位
              onSubmitted: (value) {
                if (node != node0) {
                  node.unfocus();
                  FocusScope.of(context).requestFocus(node0);
                }
              },
              onChanged: (value) {
                setState(() {
                  value = controller.text;
                });
              },
            ),
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
      ],
    );
  }

  Widget _buildList2(
      String title, String message, FocusNode node, FocusNode node0) {
    return Row(
      children: <Widget>[
        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(
                    color: Colors.black, width: 1, style: BorderStyle.solid)),
            child: Text(title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                )),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.65,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black, width: 1, style: BorderStyle.solid)),
            child: DropdownButton(
                value: r04,
                iconSize: 20,
                elevation: 16,
                focusNode: node,
                style: TextStyle(
                    color: Colors.black, //字體顏色
                    fontSize: 15, //字體大小
                    decoration: TextDecoration
                        .none, //額外裝飾，ex.刪除線<.lineThrough>、底線<.underline>、頂線<.overline>
                    fontWeight: FontWeight.w200), //字體粗細
                hint: Text(message),
                items: location,
                onChanged: (String selectedItem) {
                  setState(() {
                    r04 = selectedItem;
                    node.unfocus();
                    FocusScope.of(context).requestFocus(node0);
                  });
                }),
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.05)
      ],
    );
  }

  Widget _buildList3(String title) {
    return Row(
      children: <Widget>[
        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(
                    color: Colors.black, width: 1, style: BorderStyle.solid)),
            child: Text(title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                )),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.65,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black, width: 1, style: BorderStyle.solid)),
            child: GestureDetector(
              onTap: () {
                showPicker(context);
              },
              child: Container(child: Text(r06)),
            ),
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
      ],
    );
  }

  Widget _buildList4(String title, TextEditingController controller) {
    return Row(
      children: <Widget>[
        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(
                    color: Colors.black, width: 1, style: BorderStyle.solid)),
            child: Text(title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                )),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.65,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black, width: 1, style: BorderStyle.solid)),
            child: controller.text == ''
                ? Text('0')
                : Text((int.parse(controller.text) * 1.2)
                    .roundToDouble()
                    .toStringAsFixed(0)),
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
      ],
    );
  }

  Widget _buildButton() {
    return Row(
      children: <Widget>[
        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
        SizedBox(
          child: Container(
            child: FlatButton(
              onPressed: () {
                //返回
                Navigator.pop(context);
              },
              child: Text('取消', style: TextStyle(fontSize: 20)),
              color: Colors.blue, //顏色設定
              colorBrightness: Brightness.dark,
            ),
          ),
        ),
        SizedBox(width: 10),
        SizedBox(
          child: Container(
            child: FlatButton(
              onPressed: () {
                if (btnSave) {
                  btnSave = false;
                  inputCheckModify();
                }
              },
              child: Text('儲存', style: TextStyle(fontSize: 20)),
              color: Colors.blue, //顏色設定
              colorBrightness: Brightness.dark,
            ),
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
      ],
    );
  }

  //離線版
  void getLocation() {
    List<DropdownMenuItem<String>> place = <DropdownMenuItem<String>>[
      DropdownMenuItem<String>(value: 'P01', child: Text('臺灣')),
      DropdownMenuItem<String>(value: 'P02', child: Text('日本')),
      DropdownMenuItem<String>(value: 'P03', child: Text('中國')),
      DropdownMenuItem<String>(value: 'P04', child: Text('泰國')),
      DropdownMenuItem<String>(value: 'P05', child: Text('美國')),
      DropdownMenuItem<String>(value: 'P06', child: Text('俄羅斯')),
    ];
    setState(() {
      location = place;
    });
  }

  void inputCheckModify() {
    int _result = 0; //設定顯示錯誤訊息用

    if (_controller02.text.compareTo(widget.list.r02) == 0 &&
        int.parse(_controller03.text) == widget.list.r03 &&
        r04.compareTo(widget.list.r04) == 0 &&
        int.parse(_controller05.text) == widget.list.r05 &&
        r06.compareTo(widget.list.r06) == 0 &&
        int.parse(_controller07.text) == widget.list.r07) {
      _result = -1;
    }
    //品名
    if (_controller02.text == '') {
      if (_result == 0) _result = -2;
    } else
      setState(() {
        r02 = _controller02.text;
      });
    //庫存量
    if (_controller03.text == '')
      setState(() {
        r03 = 0;
      });
    else if (int.parse(_controller03.text) > 1000) {
      if (_result == 0) _result = -3;
    } else
      setState(() {
        r03 = int.parse(_controller03.text);
      });
    //產地代碼
    //單價
    if (_controller05.text == '') {
      if (_result == 0) _result = -4;
    } else
      setState(() {
        r05 = int.parse(_controller05.text);
      });
    //金額
    //有效日期
    //安庫量
    if (_controller07.text == '') {
      if (_result == 0) _result = -5;
    } else {
      setState(() {
        r07 = int.parse(_controller07.text);
      });
    }

    //顯示錯誤訊息用
    if (_result == 0) {
      //設定建立日期
      inputDate2 = DateTime.now();
      r11 = '${customFormat2.format(inputDate2)}';
      getQueryStringModify();
    } else {
      btnSave = true;
      if (_result == -1) {
        print('輸入錯誤: 沒有進行任何修改');
        MessageBox.showMessage(context, true, '沒有進行任何修改');
        FocusScope.of(context).requestFocus(node02); //聚焦在欄位二
      } else if (_result == -2) {
        print('輸入錯誤: 品名不可空白');
        MessageBox.showMessage(context, true, '「品名」 不可空白');
        FocusScope.of(context).requestFocus(node02); //聚焦在欄位二
      } else if (_result == -3) {
        print('輸入錯誤: 庫存量不可超過1000');
        MessageBox.showMessage(context, true, '「庫存量」 不可超過 1000');
        FocusScope.of(context).requestFocus(node03); //聚焦在欄位三
      } else if (_result == -4) {
        print('輸入錯誤: 單價不可空白');
        MessageBox.showMessage(context, true, '「單價」 不可空白');
        FocusScope.of(context).requestFocus(node05); //聚焦在欄位五
      } else if (_result == -5) {
        print('輸入錯誤: 安庫量不可空白');
        MessageBox.showMessage(context, true, '「安庫量」 不可空白');
        FocusScope.of(context).requestFocus(node07); //聚焦在欄位七
      }
    }
  }

  void getQueryStringModify() {
    StringBuffer buf1 = StringBuffer();
    if (_controller02.text.compareTo(widget.list.r02) != 0)
      buf1.write("update EntireV4.dbo.T002 set R02 = '$r02'");
    if (r03 != widget.list.r03) {
      if (buf1.isEmpty)
        buf1.write("update EntireV4.dbo.T002 set R03 = $r03");
      else
        buf1.write(", R03 = $r03");
    }
    if (r04.compareTo(widget.list.r04) != 0) {
      if (buf1.isEmpty)
        buf1.write("update EntireV4.dbo.T002 set R04 = '$r04'");
      else
        buf1.write(", R04 = '$r04'");
    }
    if (r05 != widget.list.r05) {
      if (buf1.isEmpty)
        buf1.write("update EntireV4.dbo.T002 set R05 = $r05");
      else
        buf1.write(", R05 = $r05");
    }
    if (r06.compareTo(widget.list.r06) != 0) {
      if (buf1.isEmpty)
        buf1.write("update EntireV4.dbo.T002 set R06 = '$r06'");
      else
        buf1.write(", R06 = '$r06'");
    }
    if (r07 != widget.list.r07) {
      if (buf1.isEmpty)
        buf1.write("update EntireV4.dbo.T002 set R07 = $r07");
      else
        buf1.write(", R07 = $r07");
    }
    buf1.write(", R10 = '$r10', R11 = '$r11' where R01 = '$r01'");

    setState(() {
      queryStringModify = buf1.toString();
    });
    print('修改語法為: ' + queryStringModify);

    updateData(queryStringModify);
  }

  //離線版
  void updateData(String queryStringModify) {
    Target tmpProduct =
        Target(r01, r02, r03, r04, '', r05, r06, r07, '', '', r10, r11);
    productList.add(tmpProduct);

    MessageBox.showMessage(context, false, '已完成修改工作');
  }

  Future<Null> showPicker(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2001),
        lastDate: DateTime(2101));

    if (pickedDate != null && pickedDate != inputDate) {
      setState(() {
        inputDate = pickedDate;
        r06 = '${customFormat.format(inputDate)}';
      });
    }
  }
}

class Target {
  String r01;
  String r02;
  int r03;
  String r04;
  String r045;
  int r05;
  String r06;
  int r07;
  String r08;
  String r09;
  String r10;
  String r11;

  bool isSelected = false;
  bool isClicked = false;

  Target(this.r01, this.r02, this.r03, this.r04, this.r045, this.r05, this.r06,
      this.r07, this.r08, this.r09, this.r10, this.r11);
}

class MessageBox {
  static void showMessage(BuildContext context, bool isError, String message) {
    showDialog(
        context: context,
        barrierDismissible: false, //獨占性，只允許使用者按下對話框中的按鈕才能繼續操作
        builder: (context) {
          return AlertDialog(
            title: Container(
              child: Column(
                children: <Widget>[
                  isError
                      ? Row(
                          children: <Widget>[
                            Text('出現錯誤',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(width: 10),
                            Icon(Icons.error_outline)
                          ],
                        )
                      : Row(
                          children: <Widget>[
                            Text('操作完成',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(width: 10),
                            Icon(Icons.check_circle_outline)
                          ],
                        ),
                ],
              ),
            ),
            content: isError
                ? Text(message,
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold))
                : Text(message,
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold)),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  isError
                      ? Navigator.of(context).pop()
                      : Navigator.push(context,
                          MaterialPageRoute(builder: (context) => T002()));
                },
                child:
                    Text("確定", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          );
        });
  }
}