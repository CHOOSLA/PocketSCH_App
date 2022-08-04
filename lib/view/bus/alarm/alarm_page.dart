import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pocket_sch/controller/alarm_controller.dart';
import 'package:pocket_sch/model/alarm.dart';
import '../../../custom_color.dart';
import '../../../main.dart';
import '../../home.dart';
import 'alarm_add_page.dart';
import 'package:collection/collection.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'localData.dart';

List times = [
  {"시간": "10:00", "요일": "화", "상태": false},
  {"시간": "12:00", "요일": "화", "상태": false},
  {"시간": "15:00", "요일": "수", "상태": false},
  {"시간": "19:21", "요일": "금", "상태": false},
  {"시간": "19:23", "요일": "금", "상태": false},
  {"시간": "19:24", "요일": "금", "상태": false},
  {"시간": "19:28", "요일": "금", "상태": false},
  {"시간": "19:29", "요일": "금", "상태": false},
  {"시간": "19:31", "요일": "금", "상태": false},
  {"시간": "19:33", "요일": "금", "상태": false},
  {"시간": "16:59", "요일": "금", "상태": false}
];

class AlarmPage extends StatefulWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  AlarmController _alarmController = Get.put(AlarmController());

// 로컬 저장소 객체

  @override
  void initState() {
    super.initState();
    // 알람 로컬 저장소 객체 초기화
    _alarmController.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset('assets/btn_back.png',
              color: Color.fromARGB(255, 0, 0, 0), width: 15),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            children: [
              RichText(
                text: TextSpan(children: const <TextSpan>[
                  TextSpan(
                      text: ' LIVE ',
                      style: TextStyle(
                          backgroundColor: CustomColor.primary,
                          fontSize: 18,
                          color: Colors.white)),
                  TextSpan(text: ' '),
                  TextSpan(
                      text: '알람',
                      style: TextStyle(color: Colors.black, fontSize: 18))
                ]),
              ),
              SizedBox(height: 15),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.75,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                    side: BorderSide(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 15.5, right: 15.5, top: 31, bottom: 20),
                    child: Column(children: [
                      //여기서부터 코드 작성
                      Expanded(
                          child: RefreshIndicator(
                        onRefresh: refresh,
                        child: SingleChildScrollView(
                            scrollDirection: Axis.vertical, child: buildBody()),
                      ))
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffe5e5e5),
        onPressed: (() {
          Get.toNamed('alarmAdd');
        }),
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget buildBody() {
    // StreamBuilder를 통해 알람 업데이트

    // localData.init();
    // return StreamBuilder(
    //   stream: Alarm,
    //   builder: (BuildContext context, AsyncSnapshot snapshot) {
    //     if (snapshot.hasError) return Text("Error: ${snapshot.error}");
    //     print(snapshot);
    //     switch (snapshot.connectionState) {
    //       case ConnectionState.waiting:
    //         return Center(
    //             child: CircularProgressIndicator(
    //           color: Colors.green,
    //         ));
    //       default:
    return _buildList();
    //     }
    //   },
    // );
  }

  // final Stream<LocalData> _bids = (() {
  //   late final StreamController<LocalData> controller;
  //   controller = StreamController<LocalData>(
  //     onListen: () async {
  //       await localData.init();
  //       controller.add([""])
  //     },
  //   );
  //   print(controller.stream);

  //   return controller.stream;
  // })();

  // Widget _buildList() {
  //   return Column(
  //     children: localData.alarmListState.mapIndexed((idx, e) {
  //       print(idx);
  //       return _buildListItem(e, idx);
  //     }).toList(),
  //   );

  // }

  _buildList() {
    return GetBuilder<AlarmController>(builder: (controller) {
      return Column(
        children: controller.alarmController.mapIndexed((idx, e) {
          print(idx);
          return _buildListItem(e, idx);
        }).toList(),
      );
    });
  }

  doNothing(BuildContext context) {
    // setState(() {
    //   localData.alarmListState.remove(item);
    //   localData.remove(alarm: item);
    // });
  }

  // 알람을 리스트로 출력
  Widget _buildListItem(item, idx) {
    return Slidable(
      key: Key(idx.toString()),
      endActionPane: ActionPane(
        // dragDismissible: true,

        extentRatio: 0.2,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            autoClose: true,
            onPressed: doNothing(context),
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            label: '삭제',
          ),
        ],
      ),
      child: Card(
          child: Container(
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0x29000000),
                        offset: Offset(0, 1),
                        blurRadius: 2,
                        spreadRadius: 0)
                  ],
                  color: const Color(0xffead599)),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Center(
                      child: Text(
                        item.byDay.toString(),
                        style: TextStyle(
                          color: Color(0xff444444),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0x29000000),
                              offset: Offset(0, 1),
                              blurRadius: 2,
                              spreadRadius: 0)
                        ],
                        color: const Color(0xffffffff)),
                    child: Center(
                        child: Text(
                      item.time.toString(),
                      style: TextStyle(
                        color: Color(0xff444444),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  _getActivatedSwitch(item, idx),
                ],
              ))),
    );
  }

  _getActivatedSwitch(item, idx) {
    return CupertinoSwitch(
      value: item.activated,
      activeColor: Color(0xff9bd8d2),
      onChanged: (value) {
        setState(() {
          _alarmController.onChangedActivated(activated: value, index: idx);
        });
      },
    );
  }

  // build 업데이트
  Future refresh() async {
    await Future.delayed(Duration(seconds: 1)); //thread sleep 같은 역할을 함.

    setState(() {
      // build 업데이트
    });
  }
}
