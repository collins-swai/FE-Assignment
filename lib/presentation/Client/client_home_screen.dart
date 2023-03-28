import 'dart:io';

import 'package:acme_corp_interview/presentation/Client/client_profile.dart';
import 'package:acme_corp_interview/presentation/Client/client_request_form.dart';
import 'package:acme_corp_interview/presentation/Client/client_view_ticket.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen(
      {Key? key, required this.name, required this.email, required this.phone})
      : super(key: key);
  final String name;
  final String email;
  final String phone;

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      ClientRequestForm(
        name: widget.name,
        email: widget.email,
        phone: widget.phone,
      ),
      ClientViewTicket(
        name: widget.name,
        email: widget.email,
        phone: widget.phone,
      ),
      ClientViewProfile(
        name: widget.name,
        email: widget.email,
        phone: widget.phone,
      )
    ];
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 1,
                activeColor: Colors.black,
                iconSize: 24,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.black,
                tabs: const [
                  GButton(
                    icon: LineIcons.addressCard,
                    text: 'New Request',
                  ),
                  GButton(
                    icon: LineIcons.database,
                    text: 'View ticket',
                  ),
                  GButton(
                    icon: LineIcons.addressBook,
                    text: 'View Profile',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
        body: _widgetOptions?.elementAt(_selectedIndex),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    _onBackPressed();
    return true;
  }

  Object _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm'),
          content: const Text('Do you want to exit the App'),
          actions: <Widget>[
            MaterialButton(
              child: const Text(
                'No',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                Navigator.of(context).pop(false); //Will not exit the App
              },
            ),
            MaterialButton(
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                exit(0);
              },
            )
          ],
        );
      },
    );
  }

  void _onTap(int index) {
    _selectedIndex = index;
    setState(() {});
  }
}
