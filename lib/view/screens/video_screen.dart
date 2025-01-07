import 'dart:convert';
import 'package:flutter/material.dart';
import '../widgets/app_style.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'play_view.dart';
import '../widgets/video_card.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}
class _VideoScreenState extends State<VideoScreen> {
  List infoVideo=[];
  bool _playArea=false;
  bool isPlaying=false;

  VideoPlayerController? _controller;
  _initData() async{
    await DefaultAssetBundle.of(context).loadString('json/videoinfo.json').then((value) {
      setState(() {
        infoVideo = jsonDecode(value);
      });
    });
  }
  @override
  void initState() {
     super.initState();
     _initData();
  }

  @override
  void dispose() {
    _controller?.dispose(); // Dispose controller to release resources
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final h=MediaQuery.of(context).size.height*1;
    //final w=MediaQuery.of(context).size.width*1;
    return Scaffold(
      body: Container(
        decoration:_playArea==false?BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.deepPurple.shade300, Colors.deepPurpleAccent.shade200,]
          ),
        ):const BoxDecoration(color: Color(0xff6985e8),),
        child: Column(
          children: [
            _playArea==false?Padding(
              padding: const EdgeInsets.only(left: 30,right: 30,top: 65),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.arrow_back,size: 20,color: Colors.white),
                        Spacer(),
                        Icon(Icons.info_outline,size: 20,color: Colors.white),
                      ],
                    ),
                  ),
                  SizedBox(height: h*0.03,),
                  Text('Legs Toning\nand Daily Workout',style: appStyle(22, Colors.white, FontWeight.bold),),
                  SizedBox(height: h*0.07),
                  Row(
                    children: [
                      Container(
                        height: 30,width: 80,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(children: [
                          const Icon(Icons.timer_sharp,color: Colors.white,size: 18,),
                          Text(' 60 min',style: appStyle(14, Colors.white, FontWeight.w400),),
                        ],),
                      ),
                      const SizedBox(width: 20,),
                      Container(
                        height: 30,width: 150,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(child: Text(' 🛠️ Resistent band',style: appStyle(14, Colors.white, FontWeight.w500),)),
                      ),
                    ],
                  ),
                ],
              ),
            ):Column(
              children: [
                Container(
                  height: h*0.1,
                  padding: const EdgeInsets.only(left: 20,top: 50,right: 20),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: (){Get.back();},
                        icon:const Icon(Icons.arrow_back_ios,size: 20,color: Colors.white,)),
                      Expanded(child: Container()),
                      const Icon(Icons.info_outline,size: 20,color: Colors.white,),
                    ],
                  ),
                ),
                PlayView(controller: _controller),
                _controlView(context),
              ],
            ),
            SizedBox(height: h*0.02),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 15,right: 15,top: 25),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(65)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Text('Circuit: Leg Toning',style: appStyle(20, Colors.black, FontWeight.w600),),
                        SizedBox(width: h*0.08),
                        const Icon(Icons.cached_rounded,size: 25,color: Colors.blue,),
                        Text(' 3 sets',style: appStyle(20, Colors.blueGrey, FontWeight.w400),),
                      ],
                    ),
                    Expanded(
                      child: _listView(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget _controlView(BuildContext context){
    final noMute = (_controller?.value.volume ?? 0) > 0;
    final duration = _controller?.value.duration ?? Duration.zero;
    final position = _controller?.value.position ?? Duration.zero;

    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Colors.red[700],
            inactiveTrackColor: Colors.red[100],
            thumbColor: Colors.red[700],
            trackShape: const RoundedRectSliderTrackShape(),
            trackHeight: 3.0,
            thumbShape: const RoundSliderThumbShape(disabledThumbRadius: 12.0),
            overlayColor:Colors.red.withAlpha(32),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 28.0),
            tickMarkShape: const RoundSliderTickMarkShape(),
            activeTickMarkColor: Colors.red[700],
            inactiveTickMarkColor: Colors.red[100],
            valueIndicatorColor: Colors.redAccent,
          ),
          child: Slider(
            value: position.inSeconds.toDouble(),
            onChanged: (value) {
              _controller?.seekTo(Duration(seconds: value.toInt()));
            },
            min: 0,
            max: duration.inSeconds.toDouble(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')}",
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                "${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}",
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        SizedBox(
         // height: MediaQuery.of(context).size.height*0.1,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(onPressed: (){
                setState(() {
                  if(noMute){
                    _controller?.setVolume(0);
                  }
                  else
                  {
                    _controller?.setVolume(1.0);
                  }
                });
              },
                  child: noMute?const Icon(Icons.volume_up,size: 25,color: Colors.white):const Icon(Icons.volume_off,size: 25,color: Colors.white)),
              TextButton(onPressed: (){}, child: const Icon(Icons.fast_rewind_sharp,size: 30,color: Colors.white)),
              TextButton(onPressed: () async{
                if(isPlaying){
                  setState(() {
                    isPlaying=false;
                  });
                  _controller?.pause();
                  Get.snackbar("Video Pause", 'please resume!',
                  snackPosition: SnackPosition.BOTTOM,
                    backgroundColor:Colors.blueAccent,
                    icon: const Icon(Icons.pause_circle,size: 25,color: Colors.white,),
                    colorText: Colors.black,
                    borderRadius: 20
                  );
                }
                else
                {
                  setState(() {
                    isPlaying=true;
                  });
                  _controller?.play();
                }

              }, child: isPlaying? const Icon(Icons.pause,size: 30,color: Colors.white,):const Icon(Icons.play_arrow,size: 30,color: Colors.white)),
              TextButton(onPressed: (){
                Get.snackbar("",'',
                   snackPosition: SnackPosition.BOTTOM,
                    backgroundColor:Colors.blueAccent,
                    icon: const Icon(Icons.refresh,size: 25,color: Colors.white,),
                    colorText: Colors.black,
                    borderRadius: 20, 
                    titleText: Text('No More Video!',style: appStyle(16, Colors.black, FontWeight.w600),),
                    messageText: Text('Thanks for Watching Congrats !',style: appStyle(12, Colors.black, FontWeight.w600),),
                );
              }, child: const Icon(Icons.fast_forward,size: 30,color: Colors.white)),

            ],
          ),
        ),
      ],
    );
  }

void _onControllerUpdate() async{
    final controller=_controller;
    if(controller==null){
      debugPrint('controller is null');
      return;
    }
    if(!controller.value.isInitialized){
      debugPrint('controller can not be initialize');
      return;
    }
    final playing=controller.value.isPlaying;
    isPlaying=playing;

    setState(() {

    });
}

  _onTapVideo(int index){
    _controller?.dispose();
    setState(() {
      final controller=VideoPlayerController.networkUrl(Uri.parse(infoVideo[index]['videoUrl']));
      _controller=controller;
      controller..initialize().then((_){
        controller.addListener(_onControllerUpdate);
        setState(() {
          controller.play();
        });
      });
    });
  }

  _listView(){
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: infoVideo.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){
            _onTapVideo(index);
           setState(() {
             if(!_playArea){
               _playArea=true;
             }
           });
          },
          child: VideoCard(
            thumbnail: infoVideo[index]['thumbnail'],
            title: infoVideo[index]['title'],
            time: infoVideo[index]['time'],
          ),
        );
      },
    );
  }

}

