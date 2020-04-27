import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pusher/pusher.dart';
import 'package:horizon_realtors/blocs/chat_bloc/chat_bloc.dart';
import 'package:horizon_realtors/models/chat.dart';
import 'package:horizon_realtors/models/message.dart';
import 'package:horizon_realtors/widget/bottom_bar.dart';

class ChatRoomScreen extends StatefulWidget {
  final Chat _chat;
  ChatRoomScreen(this._chat);
  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final _titleColor = Color(0xff363636);
  final _chatBloc = ChatBloc();
  List<Message> messages;
  List testmessages;
  TextEditingController _controller = TextEditingController();
  initState() {
    super.initState();

    testmessages = widget._chat.messages + widget._chat.unreadMessages;
    messages = testmessages.reversed.toList();
    print(messages.length);

  }

  _addMessage(message) {
    print(message);
    testmessages.add(Message.fromJson(message, MessageType.Send));
    messages = [];
    messages = testmessages.reversed.toList();
     BlocProvider.of<ChatBloc>(context)
         .add(SendMessage(Message.fromJson(message, null), widget._chat.roomId));
    setState(() {
      _controller.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(context),
          _property(),
          Flexible(
            child: ListView(
              padding: EdgeInsets.all(0.0),
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height - 323.0,
                  child: BlocBuilder<ChatBloc , ChatState>(
                    builder: (context, state) {

                      print('$state this from chatroom');

                      return ListView.builder(
                        reverse: true,
                        padding: EdgeInsets.only(top: 10.0),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          if (messages[index].type == MessageType.Send) {
                            return _sentMessage(messages[index].message);
                          }

                          return _receivedMessage(messages[index].message);
                        },
                      );
                    },
                  ),
                ),

                _input(context),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container _input(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 70.0,
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 20.0,
          ),
          SizedBox(
            width: 12.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width - 110,
            child: TextFormField(
              controller: _controller,
              onFieldSubmitted: (val) {
                _addMessage({'id': null, 'body': val});
              },
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                isDense: true,
                fillColor: Colors.white,
                filled: true,
                hintStyle: TextStyle(color: Color(0xff8F8F8F), fontSize: 14),
                border: InputBorder.none,
                enabledBorder: _inputBorder(),
                focusedBorder: _inputBorder(),
              ),
            ),
          ),
          SizedBox(
            width: 12.0,
          ),
          InkWell(
              child: Icon(
                Icons.send,
                color: Color(0xff3FB1E3),
              ),
              onTap: () {
                _addMessage({'id': null, 'body': _controller.text});
              })
        ],
      ),
    );
  }

  Container _receivedMessage(message) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.symmetric(vertical: 5),
      alignment: Alignment.topLeft,
      width: 270.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            decoration: BoxDecoration(
                color: Color(0xff3FB1E3),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(8),
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8))),
            width: 270.0,
            child: Text(
              '$message',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            'Today, 09:22 AM',
            style: TextStyle(color: Color(0xff8F8F8F)),
          )
        ],
      ),
    );
  }

  Container _sentMessage(message) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.topRight,
      width: 270.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            decoration: BoxDecoration(
                color: Color(0xff8F8F8F),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8))),
            width: 270.0,
            child: Text(
              '$message',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            'Today, 09:22 AM',
            style: TextStyle(color: Color(0xff8F8F8F)),
          )
        ],
      ),
    );
  }

  Container _property() {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Color(0xffECECEC))),
      height: 90.0,
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 100.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                image: DecorationImage(
                    image: AssetImage('assets/photo.jpg'), fit: BoxFit.cover)),
          ),
          SizedBox(
            width: 14,
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '725 Shaika Bin Rahin',
                  style: TextStyle(color: _titleColor, fontSize: 16),
                ),
                Text(
                  'Bin Jasim Road, Al Wakra, Doha',
                  style: TextStyle(color: Color(0xff8F8F8F)),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      width: 40.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Color(0xff3FB1E3)),
                      child: Text(
                        'Rent',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      '\$499',
                      style: TextStyle(
                          color: Color(0xff6178B9),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container _appBar(BuildContext context) {
    return Container(
      height: 135.0,
      margin: EdgeInsets.only(top: 24),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      InkWell(
                          child: Icon(Icons.arrow_back),
                          onTap: () {
                            Navigator.pop(context);
                          }),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        '${widget._chat.user.name}',
                        style: TextStyle(
                            color: _titleColor,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: AssetImage('assets/profile.png'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          _search(context),
          SizedBox(
            height: 10.0,
          )
        ],
      ),
    );
  }

  Container _search(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: TextFormField(
          textInputAction: TextInputAction.search,
          decoration: _inputDecoration('Find agents, agencies & properties'),
        ));
  }

  _inputDecoration(String hint) {
    return InputDecoration(
      prefixIcon: Icon(Icons.search),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      isDense: true,
      fillColor: Colors.white,
      filled: true,
      hintText: hint,
      hintStyle: TextStyle(color: Color(0xff8F8F8F), fontSize: 14),
      border: InputBorder.none,
      enabledBorder: _inputBorder(),
      focusedBorder: _inputBorder(),
    );
  }

  _inputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Color(0xffECECEC)),
    );
  }
}
