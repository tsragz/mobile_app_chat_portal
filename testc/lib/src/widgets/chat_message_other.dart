import 'package:flutter/material.dart';

class ChatMessageOther extends StatelessWidget {
  final int index;
  final Map<String, dynamic> data;
  const ChatMessageOther({Key key, this.index, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 17,
          ),
          Container(
            constraints: BoxConstraints(
              maxWidth: 300,
            ),
            //child: Text('jccnnccscisjcisjisjvomvfkmvofjofmdfmoffodm fofvofvofv'),
            decoration: BoxDecoration(
                color: Colors.teal[100],
                borderRadius: BorderRadius.circular(5)),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
              Text(
                data['author'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 5),
             Text(data['value'],style: TextStyle(fontWeight: FontWeight.w400),),
            ]),
          ),
          Padding(padding: EdgeInsets.only(bottom: 67)),
        ],
      
      ),
    );
  }
}
