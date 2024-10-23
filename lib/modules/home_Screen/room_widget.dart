import 'package:flutter/material.dart';

import '../../models/room.dart';
import '../chat/chat_screen.dart';

class RoomWidget extends StatelessWidget {
  Room room;

  RoomWidget({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, ChatScreen.routeName,arguments: room);
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.all(30.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  "assets/images/${room.catId}.png",
                  fit: BoxFit.fitWidth,
                  width: MediaQuery.of(context).size.width * 0.23,
                ),
              ),
            ),

            Text(room.roomName,style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),),
          ],
        ),
      ),
    );
  }
}
