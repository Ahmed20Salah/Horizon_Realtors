import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horizon_realtors/pages/favorite.dart';
import 'package:horizon_realtors/pages/profile.dart';
import 'package:horizon_realtors/pages/properties.dart';

import '../models/user.dart';
import '../pages/home.dart';
import '../pages/user_home.dart';
import '../repository/user_repo.dart';

class CustomBottomBar extends StatelessWidget {
  final _userRepository = UserRepository();
  final int active;
  CustomBottomBar(this.active);
  final _activeColor = Color(0xff6178B9);
  @override
  Widget build(BuildContext context) {
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
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => Favorite(),
            //   ),
            // );
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
          icon: Icon(
            Icons.chat_bubble_outline,
            size: 30.0,
            textDirection: TextDirection.rtl,
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
