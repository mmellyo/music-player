import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:permission_handler/permission_handler.dart';

import 'audio_service.dart';


class MusicPlayer extends StatefulWidget {
  const MusicPlayer({super.key});

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}



class _MusicPlayerState extends State<MusicPlayer> {
  bool isPlaying = false;
  bool isLoading = false;
  final service = FlutterBackgroundService();

  void startMusic() async {
    setState(() => isLoading = true);

    final status = await Permission.notification.request();
    log('Permission: $status');

    await initializeService();
    await service.startService();
    await Future.delayed(const Duration(seconds: 1));

    final running = await service.isRunning();
    setState(() {
      isPlaying = running;
      isLoading = false;
    });
  }

  void stopMusic() async {
    service.invoke('stop');

    await Future.delayed(const Duration(seconds: 1));
    final running = await service.isRunning();
    setState(() => isPlaying = running);

    if (running) {
      service.invoke('stop');
      await Future.delayed(const Duration(seconds: 1));
      final stillRunning = await service.isRunning();
      setState(() => isPlaying = stillRunning);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true, // Extends body behind the AppBar

        appBar: AppBar(

            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.white,
                size: 30,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ],
            title: Center(
                child: Column(
                  children: [
                    const Text("Now Playing",
                        style: TextStyle(fontSize: 18, color: Colors.white,)),
                  ],
                )
            )
        ),



        body: Container(
            padding: const EdgeInsets.all(20),
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF21355E), Color(0xFF061523)]
                )
            ),

            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 14
                ),

                child: Column(
                  children: [
                    _songCover(context),

                    const SizedBox(height: 30,),

                    _songDetails(),

                    const SizedBox(height: 20,),


                    Column(
                      children: [
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTickMarkColor: Colors.white,
                            inactiveTrackColor:  Colors.white,
                            thumbColor:  Colors.white,
                            trackHeight: 4,
                          ),
                          child: Slider(value: 0, onChanged: (val){}),
                        ),
                      ],
                    ),


                    const SizedBox(height: 20,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Icon(Icons.shuffle, color: Colors.white60, size: 20,),

                        Icon(Icons.skip_previous,color: Colors.white, size: 45,),


                        IconButton(
                          iconSize: 48,
                          color: Colors.white,
                          icon: Icon(
                            size: 65,
                            isPlaying ? Icons.stop : CupertinoIcons.play_circle_fill,
                          ),
                          onPressed: isLoading
                              ? null
                              : () {
                            if (isPlaying) {
                              stopMusic();
                            } else {
                              startMusic();
                            }
                          },
                        ),


                        Icon(Icons.skip_next,color: Colors.white, size: 45,),

                        Icon(Icons.repeat, color: Colors.white60, size: 20,),

                      ],
                    ),

                    const SizedBox(height: 35,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Icon(Icons.playlist_add, color: Colors.white60, size: 20,),

                        Icon(Icons.cast_connected_outlined ,color: Colors.white60, size: 20,),
                      ],
                    ),



                  ],
                ),


              ),
            )
        )
    );

  }
}



Widget _songCover(BuildContext context) {
  double screenWidth = MediaQuery
      .of(context)
      .size
      .width - 28; // -horiz padding
  double screenHeight = MediaQuery
      .of(context)
      .size
      .height;
  double size = screenWidth < screenHeight ? screenWidth : screenHeight / 2;

  return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 5, // How much the shadow spreads
            blurRadius: 40, // Softness of the shadow
          ),
        ],
        image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
                "https://i.pinimg.com/736x/af/a8/7e/afa87e2a238ddfd92430039b689df00b.jpg"
            )
        ),
      )
  );
}



Widget _songDetails() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Nature Sound",
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            "Natureast",
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18,
              color: Colors.white70,
            ),
          )
        ],
      ),
      IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.favorite_outline_outlined,
            color: Colors.white,
            size: 33,
          )
      ),
    ],
  );
}

