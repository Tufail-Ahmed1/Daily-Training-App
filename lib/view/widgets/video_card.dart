import 'package:flutter/material.dart';

import 'app_style.dart';
class VideoCard extends StatelessWidget {
  final String thumbnail;
  final String title;
  final String time;

  const VideoCard({
    super.key,
    required this.thumbnail,
    required this.title,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return SizedBox(
      height: h * 0.15,
      width: w * 0.2,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: h * 0.1,
                width: w * 0.22,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                    image: AssetImage(thumbnail),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                height: h * 0.1,
                width: w * 0.6,
                padding: const EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    FittedBox(
                      child: Text(
                        title,
                        style: appStyle(18, Colors.black, FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      time,
                      style: appStyle(14, Colors.grey, FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: h * 0.01),
          Row(
            children: [
              Container(
                height: h * 0.025,
                width: w * 0.15,
                decoration: BoxDecoration(
                  color: const Color(0xff839fed).withOpacity(0.4),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(
                  child: Text(
                    '30s rest',
                    style: appStyle(12, Colors.blue, FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              const Text(
                '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          )
        ],
      ),
    );
  }
}
