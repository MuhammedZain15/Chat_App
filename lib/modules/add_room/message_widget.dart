import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/message.dart';
import '../../provider/user_provider.dart';

class MessageWidget extends StatelessWidget {
  Message message;

  MessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return provider.myUser!.uid == message.senderId
        ? SenderMessage(message: message)
        : ReciverMessage(message: message);
  }
}

class SenderMessage extends StatelessWidget {
  Message message;

  SenderMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    int ts = message.dataTime;
    var dt = DateTime.fromMillisecondsSinceEpoch(ts);
    var date = DateFormat("MM/dd/yyyy, hh:mm a").format(dt);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 8),
            decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(18),
                  topLeft: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                )),
            child: Text(
              message.content,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            date.substring(12),
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class ReciverMessage extends StatelessWidget {
  Message message;

  ReciverMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    int ts = message.dataTime;
    var dt = DateTime.fromMillisecondsSinceEpoch(ts);
    var date = DateFormat("MM/dd/yyyy, hh:mm a").format(dt);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 8),
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(18),
                    topLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18),
                  )),
              child: Text(
                message.content,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              )),
          Text(
            date.substring(12),
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
