import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:training_app/view/screens/video_screen.dart';
import 'package:training_app/view/widgets/app_style.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  List info=[];
  _initData() async{
    await DefaultAssetBundle.of(context).loadString('json/info.json').then((value){
    setState(() {
      info=json.decode(value);
    });
    });
  }
  @override
  void initState() {
     super.initState();
     _initData();
  }
  @override
  Widget build(BuildContext context) {
    final h=MediaQuery.of(context).size.height*1;
    final w=MediaQuery.of(context).size.width*1;
    return Scaffold(
      backgroundColor: const Color(0xffe2e2e2),
      appBar: AppBar(
        backgroundColor: const Color(0xffe2e2e2),
        title:  Text("Training",style: appStyle(25, Colors.black, FontWeight.bold)),
      actions: const [
        Row(
          children: [
            Icon(Icons.arrow_back_ios_new),
            SizedBox(width: 5),
            Icon(Icons.calendar_today),
            SizedBox(width: 5),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10,right: 20,left: 20),
        child: Column(
          children: [
            InkWell(
              onTap: () => Get.to(const VideoScreen()),
              child: Row(
                children: [
                  Text('Your program',style: appStyle(18, Colors.black, FontWeight.bold),),
                  const Spacer(),
                  Text('Details ',style: appStyle(16, Colors.blue, FontWeight.bold),),
                   const Icon(Icons.arrow_forward),
                ],
              ),
            ),
            SizedBox(height: h*0.015,),
            InkWell(
              onTap: ()=>Get.to(const VideoScreen()),
              child: Container(
                height: h*0.25,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    // begin: Alignment(5, 10),
                    //   end: Alignment(10, 20),
                      colors: [Colors.deepPurple,Colors.deepPurpleAccent,]
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(1,5),
                      blurRadius: 10,
                      color: Colors.deepPurpleAccent,
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(70),),

                ),
                child: Padding(
                  padding: const EdgeInsets.only(top:20,left: 20,right: 20,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: h*0.01,),
                      Text('Next workout',style: appStyle(15, Colors.white, FontWeight.w400),),
                      Text('Legs Toning\nand Daily Workout',style: appStyle(20, Colors.white, FontWeight.bold),),
                      const Spacer(),
                      Row(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(Icons.timer_sharp,color: Colors.white,size: 18,),
                              Text(' 60 min',style: appStyle(14, Colors.white, FontWeight.w400),),
                            ],
                          ),
                         const Spacer(),
                          Container(
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 15,
                                  color: Colors.deepPurple,
                                ),
                              ],
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 25,
                                child: Icon(Icons.play_arrow,size: 40),
                              ),
                            ),
                          ),
                           ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: h*0.02),
            SizedBox(
            height: h*0.2,width: w,
              child: Stack(
                children: [
                  Container(
                    height: h*0.135,
                    margin: const EdgeInsets.only(top: 15),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                           blurRadius: 4,
                          color: Colors.deepPurpleAccent,
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(image: AssetImage('assets/card.png'),fit: BoxFit.fill),
                    ),
                  ),
                  Container(
                    height: h*0.2,width: w*0.35,
                    margin:const EdgeInsets.only(bottom: 50,right: 200),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(image: AssetImage('assets/figure.png'),fit: BoxFit.fill),
                    ),
                  ),
                  Container(
                    height: h*0.15,width: w,
                    margin: const EdgeInsets.only(left: 150,top: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('You are doing great',style: appStyle(18, Colors.blue, FontWeight.bold),),
                        Text('Keep it up\nstick to your plan',style: appStyle(14, Colors.grey.shade500, FontWeight.bold),),

                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 7),
                child: Text('Area of focus',style: appStyle(22, Colors.black, FontWeight.w600),)),
            Expanded(
              child: OverflowBox(
                child: ListView.builder(
                 itemCount: (info.length.toDouble()/2).toInt(),
                  scrollDirection: Axis.vertical,
                  reverse: true,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                   int a= 2*index;    //0 2
                   int b= 2*index+1;  //1 3
                  return  Row(
                    children: [
                      Container(
                        height: h*0.2,
                        width: w*0.4,
                        margin: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(image: AssetImage('assets/ex3.png'),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.deepPurpleAccent,
                                blurRadius: 3,
                            ),
                          ]
                        ),
                        child: Center(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(info[a]['title'],style: appStyle(18, Colors.blue, FontWeight.bold),),
                          ),
                        ),
                      ),
                      Container(
                        height: h*0.2,
                        width: w*0.4,
                        margin: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(image: AssetImage('assets/ex4.png'),
                          ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.deepPurpleAccent,
                                blurRadius: 3,
                              ),
                            ]
                        ),
                        child: Center(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(info[b]['title'],style: appStyle(18, Colors.blue, FontWeight.bold),),
                            )
                        ),
                      ),
                    ],
                  );
                },),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
