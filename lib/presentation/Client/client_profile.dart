import 'package:acme_corp_interview/presentation/login_screen.dart';
import 'package:acme_corp_interview/theme/app_decoration.dart';
import 'package:acme_corp_interview/theme/app_style.dart';
import 'package:acme_corp_interview/theme/color_constant.dart';
import 'package:acme_corp_interview/theme/size_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';

class ClientViewProfile extends StatefulWidget {
  const ClientViewProfile(
      {Key? key, required this.name, required this.email, required this.phone})
      : super(key: key);
  final String name;
  final String email;
  final String phone;

  @override
  State<ClientViewProfile> createState() => _ClientViewProfileState();
}

class _ClientViewProfileState extends State<ClientViewProfile> {
  String? _name;
  int? _phone;
  String? _email;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name');
      _phone = prefs.getInt('phone');
      _email = prefs.getString('email');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profile",
          style: AppStyle.txtInterBold24.copyWith(
            letterSpacing: 0.72,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                logOut();
              },
              icon: Icon(
                Icons.power_settings_new,
                color: ColorConstant.redA700,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: _pullRefresh,
          child: Container(
            decoration: AppDecoration.fillWhiteA700,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: getPadding(
                    left: 14,
                    top: 21,
                    right: 14,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: getSize(
                          100.00,
                        ),
                        width: getSize(
                          100.00,
                        ),
                        margin: getMargin(
                          left: 16,
                          top: 22,
                          right: 16,
                        ),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  getHorizontalSize(
                                    50.00,
                                  ),
                                ),
                                child: Image.asset('assets/images/profile.png'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: getPadding(
                          left: 16,
                          top: 21,
                          right: 16,
                        ),
                        child: Text(
                          'Name: ${_name ?? 'Not set'}',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtInterSemiBold16.copyWith(
                            letterSpacing: 0.50,
                            height: 1.00,
                          ),
                        ),
                      ),
                      Padding(
                        padding: getPadding(
                          left: 16,
                          top: 8,
                          right: 16,
                        ),
                        child: Text(
                          "Phone : ${_phone ?? 'Not set'}",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtInterSemiBold12.copyWith(
                            letterSpacing: 0.50,
                            height: 1.00,
                          ),
                        ),
                      ),
                      Padding(
                        padding: getPadding(
                          left: 16,
                          top: 8,
                          right: 16,
                        ),
                        child: Text(
                          "Email:${_email ?? 'Not set'}",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtInterSemiBold12.copyWith(
                            letterSpacing: 0.50,
                            height: 1.00,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: getVerticalSize(
                            1.00,
                          ),
                          width: getHorizontalSize(
                            400.00,
                          ),
                          margin: getMargin(
                            top: 26,
                          ),
                          decoration: BoxDecoration(
                            color: ColorConstant.bluegray100,
                          ),
                        ),
                      ),
                      Padding(
                        padding: getPadding(
                          left: 16,
                          top: 23,
                          right: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: getPadding(
                                top: 4,
                                bottom: 4,
                              ),
                              child: Text(
                                "Edit Profile",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtInterRegular16.copyWith(
                                  letterSpacing: 0.50,
                                  height: 1.00,
                                ),
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> logOut() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Sign Out'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Sign out of application?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'No',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  CupertinoPageRoute(
                      builder: (context) => LoginScreen(
                            name: widget.name,
                            email: widget.email,
                            phone: widget.phone,
                          )),
                  (_) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _pullRefresh() async {
    setState(() {});
  }
}
