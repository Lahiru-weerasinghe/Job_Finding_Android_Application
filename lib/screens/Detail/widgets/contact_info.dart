import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uee_assignment/models/message.dart';

class ContactInfo extends StatelessWidget{
  final Message message;
  ContactInfo(this.message);
  @override
  Widget build(BuildContext context) {
    return Container (
      padding: EdgeInsets.symmetric(horizontal:25),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Text('${message.user.firstName}\n${message.user.lastName}',
            style: TextStyle(
              height: 1.2,
              fontSize: 28,
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
        ),
        Row(children: [
          _buildCallButton(Icons.phone),
          SizedBox(width:10),
          _buildCallButton(Icons.video_camera_back)
        ],
        )
      ],),
    );
  }

  Widget _buildCallButton(IconData iconData){
    return Container(
      padding: EdgeInsets.all(8),
      decoration : BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.3)
      ),
      child: Icon(
        iconData,
        color: Colors.white,
        size: 25,
      )
    );
  }
}