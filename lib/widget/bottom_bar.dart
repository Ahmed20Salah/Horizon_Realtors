import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horizon_realtors/blocs/chat_bloc/chat_bloc.dart';
import 'package:horizon_realtors/pages/chats.dart';
import 'package:horizon_realtors/pages/favorite.dart';
import 'package:horizon_realtors/pages/profile.dart';
import 'package:horizon_realtors/pages/properties.dart';
import 'package:horizon_realtors/repository/chat_repository.dart';

import '../models/user.dart';
import '../pages/home.dart';
import '../pages/user_home.dart';
import '../repository/user_repo.dart';

class CustomBottomBar extends StatelessWidget {
  final _userRepository = UserRepository();
  final int active;

  CustomBottomBar(this.active);

  final _activeColor = Color(0xff6178B9);
  final _chatRepo = ChatRepository();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
      print('$state from bottom bar');
      return BottomNavigationBar(
        currentIndex: active,
        unselectedItemColor: Color(0xff363636),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xff6178B9),
        onTap: (val) {
          switch (val) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      _userRepository.user.type == UserType.EndUser
                          ? UserHome()
                          : Home(),
                ),
              );
              break;
            case 1:
              _userRepository.user.type == UserType.EndUser
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavoritePage(),
                      ),
                    )
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Properties(),
                      ),
                    );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Chats(),
                ),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Profile(),
                ),
              );
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            title: active == 0 ? _activeIndicator() : Container(),
            icon: Image.asset('assets/home-bottom.png'),
            activeIcon: Image.asset('assets/home-alt.png'),
          ),
          _userRepository.user.type == UserType.EndUser
              ? BottomNavigationBarItem(
                  title: active == 1 ? _activeIndicator() : Container(),
                  icon: Icon(
                    Icons.favorite_border,
                    size: 30.0,
                  ),
                  activeIcon: Icon(
                    Icons.favorite_border,
                    size: 30.0,
                    color: _activeColor,
                  ),
                )
              : BottomNavigationBarItem(
                  title: active == 1 ? _activeIndicator() : Container(),
                  icon: Image.asset('assets/list.png'),
                  activeIcon: Image.asset('assets/list_active.png'),
                ),
          BottomNavigationBarItem(
            title: active == 2 ? _activeIndicator() : Container(),
            icon: Container(
              width: 33.0,
              height: 35.0,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Icon(
                      Icons.chat_bubble_outline,
                      size: 27.0,
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${_chatRepo.unread}',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
            activeIcon: Icon(
              Icons.chat_bubble_outline,
              size: 30.0,
              color: _activeColor,
            ),
          ),
          BottomNavigationBarItem(
            title: active == 3 ? _activeIndicator() : Container(),
            icon: Image.asset('assets/person.png'),
            activeIcon: Image.asset('assets/person_active.png'),
          )
        ],
      );
    });
  }

  Widget _activeIndicator() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      height: 4,
      width: 4,
      decoration:
          BoxDecoration(color: Color(0xff6178B9), shape: BoxShape.circle),
    );
  }
}
