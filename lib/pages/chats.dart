import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pusher/pusher.dart';
import 'package:horizon_realtors/blocs/chat_bloc/chat_bloc.dart';
import 'package:horizon_realtors/models/chat.dart';
import 'package:horizon_realtors/pages/chat_room.dart';
import 'package:horizon_realtors/repository/chat_repository.dart';
import 'package:horizon_realtors/widget/bottom_bar.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  final Color _titleColor = Color(0xff363636);

  final _unreadColor = Color(0xff6178B9);

  final _chatRepo = ChatRepository();

  final _chatBloc = ChatBloc();

  final TextEditingController _searchCon = TextEditingController();

  initState() {
    super.initState();
//    listenFun();
  }

  listenFun() async {
    await Pusher.subscribe('room.5').then((val) async {
      val.bind('new_message', (va) {
        print(va.data);
        print(va.channel);
        print('add from chats');
        BlocProvider.of<ChatBloc>(context).add(ReceiveMessage());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _appbar(context),
            Container(
              height: MediaQuery.of(context).size.height - 135,
              child: BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    print('$state this from chats');
//                    if (state is Found) {
//                      return ListView.builder(
//                        padding: EdgeInsets.all(0.0),
//                        itemCount: state.filtred.length,
//                        itemBuilder: (context, index) {
//                          return _room(context, state.filtred[index]);
//                        },
//                      );
//                    }
                    return ListView.builder(
                      padding: EdgeInsets.all(0.0),
                      itemCount: _chatRepo.allChats.length,
                      itemBuilder: (context, index) {
                        return _room(context, _chatRepo.allChats[index]);
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomBar(2),
    );
  }

  Widget _room(BuildContext context, chat) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ChatRoomScreen(chat)));
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
          color: Color(0xffECECEC),
        )),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16.0),
        height: 90.0,
        child: Row(
          children: <Widget>[
            _avatar(chat),
            SizedBox(
              width: 12,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 110,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '${chat.user.name}',
                        style: TextStyle(
                            color: _titleColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Today, 09:40 AM',
                        style: TextStyle(color: Color(0xff8F8F8F)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  chat.post == null
                      ? Container()
                      : Text(
                          '${chat.post.mainAddress}',
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                              color: _titleColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                  SizedBox(
                    height: 5,
                  ),
                  chat.messages.length == 0 && chat.unreadMessages.length == 0
                      ? Container()
                      : Text(
                          chat.unreadMessages.length == 0
                              ? '${chat.messages[chat.messages.length - 1].message}'
                              : '${chat.unreadMessages[chat.unreadMessages.length - 1].message}',
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          softWrap: false,
                          style: TextStyle(color: _unreadColor, fontSize: 16),
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _appbar(BuildContext context) {
    return Container(
      height: 135.0,
      padding: EdgeInsets.only(top: 41, left: 16, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Chat',
            style: TextStyle(
                color: _titleColor,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 14,
          ),
          _search(context)
        ],
      ),
    );
  }

  Container _search(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: _searchCon,
        onChanged: (val) {
          if (_searchCon.text == '') {
             _chatBloc.add(Stoped());
          } else {
             _chatBloc.add(Search(val));
          }
        },
        textInputAction: TextInputAction.search,
        decoration: _inputDecoration('Search Chats'),
      ),
    );
  }

  _inputDecoration(String hint) {
    return InputDecoration(
      prefixIcon: Icon(Icons.search),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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

  Container _avatar(chat) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/profile.png'), fit: BoxFit.cover),
        shape: BoxShape.circle,
      ),
      height: 64,
      width: 64,
      alignment: Alignment.topRight,
      child: chat.unreadMessages.length == 0
          ? Container()
          : Container(
              alignment: Alignment.center,
              width: 20.0,
              height: 20.0,
              decoration: BoxDecoration(
                color: Color(0xffFF2129),
                shape: BoxShape.circle,
              ),
              child: Text(
                '${chat.unreadMessages.length}',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
    );
  }
}
