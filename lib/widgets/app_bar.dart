import 'package:bar2_banzeen/widgets/search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/messages_screen.dart';
import '../services/authentication_service.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({ Key? key}) : preferredSize = Size.fromHeight(kToolbarHeight), super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar>{



  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: Colors.white,

      actions: [

        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {

            context.go('/mainPage/explore');
          },
        ),  IconButton(
        onPressed: () {
          context.go("/mainPage/messages");
        },
        icon: Icon(Icons.message),
      )
      ],
    );
  }
}