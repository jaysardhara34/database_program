import 'package:database_program/database/controller/homeController.dart';
import 'package:database_program/database/utils/dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _txtname = TextEditingController();
  TextEditingController _txtstd = TextEditingController();
  TextEditingController _txtmobile = TextEditingController();
  TextEditingController _utxtname = TextEditingController();
  TextEditingController _utxtstd = TextEditingController();
  TextEditingController _utxtmobile = TextEditingController();
  DBHelper _db = DBHelper();

  HomeController _controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _controller.stdlist.value = await _db.readData();
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xff252525),
      appBar: AppBar(
        backgroundColor: Color(0xff252525),
        elevation: 00,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded))
        ],
        title: Text(
          'DB-Manager',
          style: TextStyle(color: Color(0xffffffff)),
        ),
      ),
      body: Obx(() => ListView.builder(
            itemCount: _controller.stdlist.value.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Text(
                  '${_controller.stdlist.value[index]['id']}',
                  style: TextStyle(color: Color(0xffffffff)),
                ),
                title: Text(
                  '${_controller.stdlist.value[index]['name']}',
                  style: TextStyle(color: Color(0xffffffff)),
                ),
                subtitle: Text(
                  '${_controller.stdlist.value[index]['mobile']}',
                  style: TextStyle(color: Color(0xffffffff)),
                ),
                trailing: SizedBox(
                    width: 97,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            _utxtmobile = TextEditingController(
                                text:
                                    '${_controller.stdlist.value[index]['mobile']}');
                            _utxtname = TextEditingController(
                                text:
                                    '${_controller.stdlist.value[index]['name']}');
                            _utxtstd = TextEditingController(
                                text:
                                    '${_controller.stdlist.value[index]['std']}');

                            Get.defaultDialog(
                              content: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextField(
                                    controller: _utxtname,
                                    cursorColor: Color(0xffffffff),
                                    style: TextStyle(color: Color(0xffffffff)),
                                    decoration: InputDecoration(
                                      hintStyle:
                                          TextStyle(color: Color(0xff919191)),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffffffff)),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      hintText: 'Enter Name',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffffffff)),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextField(
                                    controller: _utxtstd,
                                    cursorColor: Color(0xffffffff),
                                    style: TextStyle(color: Color(0xffffffff)),
                                    keyboardType:
                                        TextInputType.numberWithOptions(),
                                    decoration: InputDecoration(
                                      focusColor: Color(0xffffffff),
                                      fillColor: Color(0xffffffff),
                                      hintStyle:
                                          TextStyle(color: Color(0xff919191)),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffffffff)),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      hintText: 'Enter Std',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffffffff)),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextField(
                                    controller: _utxtmobile,
                                    cursorColor: Color(0xffffffff),
                                    style: TextStyle(color: Color(0xffffffff)),
                                    keyboardType:
                                        TextInputType.numberWithOptions(),
                                    decoration: InputDecoration(
                                      hintStyle:
                                          TextStyle(color: Color(0xff919191)),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffffffff)),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      hintText: 'Enter Mobile',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffffffff)),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      _db.updateData(_utxtname.text, _utxtstd.text, _utxtmobile.text,  '${_controller.stdlist.value[index]['id']}');
                                      _getData();
                                      
                                      Get.back();
                                    },
                                    child: Text(
                                      'Update',
                                      style:
                                          TextStyle(color: Color(0xff000000)),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xff757575)),
                                  )
                                ],
                              ),
                              titleStyle: TextStyle(color: Color(0xffffffff)),
                              backgroundColor: Color(0xff252525),
                              title: 'Update Credintials',
                            );
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Color(0xffffffff),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _db.deleteData(
                                '${_controller.stdlist.value[index]['id']}');
                            _getData();
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ],
                    )),
              );
            },
          )),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.defaultDialog(
              content: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _txtname,
                    cursorColor: Color(0xffffffff),
                    style: TextStyle(color: Color(0xffffffff)),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Color(0xff919191)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffffffff)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: 'Enter Name',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffffffff)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _txtstd,
                    cursorColor: Color(0xffffffff),
                    style: TextStyle(color: Color(0xffffffff)),
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                      focusColor: Color(0xffffffff),
                      fillColor: Color(0xffffffff),
                      hintStyle: TextStyle(color: Color(0xff919191)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffffffff)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: 'Enter Std',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffffffff)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _txtmobile,
                    cursorColor: Color(0xffffffff),
                    style: TextStyle(color: Color(0xffffffff)),
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Color(0xff919191)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffffffff)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: 'Enter Mobile',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffffffff)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _db.insertData(
                          _txtname.text, _txtstd.text, _txtmobile.text);
                      _getData();
                      _txtname.clear();
                      _txtstd.clear();
                      _txtmobile.clear();
                      Get.back();
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Color(0xff000000)),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff757575)),
                  )
                ],
              ),
              titleStyle: TextStyle(color: Color(0xffffffff)),
              backgroundColor: Color(0xff252525),
              title: 'Add Credintials',
            );
          },
          child: Icon(
            Icons.add,
            color: Color(0xff000000),
          ),
          backgroundColor: Color(0xff757575)),
    ));
  }
}
