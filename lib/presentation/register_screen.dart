import 'package:acme_corp_interview/presentation/login_screen.dart';
import 'package:acme_corp_interview/theme/app_style.dart';
import 'package:acme_corp_interview/theme/color_constant.dart';
import 'package:acme_corp_interview/theme/size_utils.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key, required this.name, required this.email, required this.phone}) : super(key: key);
  final String name;
  final String email;
  final String phone;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String dropDownPick = 'Agent';
  bool _isHidden = true;

  String _errorMessage = '';



  @override
  Widget build(BuildContext context) {
    final nameField = TextFormField(
      controller: nameController,
      keyboardType: TextInputType.name,
      textAlignVertical: TextAlignVertical.center,
      autofocus: false,
      validator: (value) {

      },
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: ColorConstant.plainGrey),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.red),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: ColorConstant.teal800),
          ),
          label: Text("Name"),
          contentPadding: EdgeInsets.fromLTRB(14.0, 1.0, 4.0, 2.0),
          labelStyle: AppStyle.txtInterMedium18.copyWith(
            letterSpacing: 0.50,
            height: 1.00,
          ),
          filled: true,
          fillColor: ColorConstant.whiteA700),
    );

    final emailField = TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      textAlignVertical: TextAlignVertical.center,
      autofocus: false,
      validator: (value) {},
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: ColorConstant.plainGrey),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.red),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: ColorConstant.teal800),
          ),
          label: Text("Email"),
          contentPadding: EdgeInsets.fromLTRB(14.0, 1.0, 4.0, 2.0),
          labelStyle: AppStyle.txtInterMedium18.copyWith(
            letterSpacing: 0.50,
            height: 1.00,
          ),
          filled: true,
          fillColor: ColorConstant.whiteA700),
    );

    final passwordField = TextFormField(
      controller: passwordController,
      textAlignVertical: TextAlignVertical.center,
      keyboardType: TextInputType.visiblePassword,
      validator: (value) {
        if (value!.isEmpty) {
          return "Password";
        } else if (value.length < 6) {
          return "Password";
        }
        return null;
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: ColorConstant.plainGrey),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: ColorConstant.teal800),
        ),
        contentPadding: EdgeInsets.fromLTRB(14.0, 1.0, 4.0, 2.0),
        labelStyle: AppStyle.txtInterMedium20.copyWith(
          letterSpacing: 0.50,
          height: 1.00,
        ),
        label: Text("Password"),
        filled: true,
        alignLabelWithHint: true,
        fillColor: ColorConstant.whiteA700,
        suffix: Container(
          padding: getPadding(right: 5, top: 4),
          child: InkWell(
            onTap: _togglePasswordView,
            child: Icon(
              _isHidden ? Icons.visibility : Icons.visibility_off,
              color: ColorConstant.lightGray,
            ),
          ),
        ),
      ),
    );

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: getPadding(left: 24, top: 100, right: 24),
                    child: Image.asset("assets/images/logo-dark.png"),
                  ),
                ),
                Padding(
                  padding: getPadding(top: 15),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: getVerticalSize(74.00),
                      width: getHorizontalSize(396.00),
                      margin: getMargin(left: 16, right: 16, bottom: 4),
                      child: Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              height: getVerticalSize(
                                74.00,
                              ),
                              width: getHorizontalSize(
                                396.00,
                              ),
                              margin: getMargin(
                                top: 10,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: nameField,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: getPadding(top: 15),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: getVerticalSize(74.00),
                      width: getHorizontalSize(396.00),
                      margin: getMargin(left: 16, right: 16, bottom: 4),
                      child: Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              height: getVerticalSize(
                                74.00,
                              ),
                              width: getHorizontalSize(
                                396.00,
                              ),
                              margin: getMargin(
                                top: 10,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: emailField,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: getPadding(top: 15),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: getVerticalSize(74.00),
                      width: getHorizontalSize(396.00),
                      margin: getMargin(left: 16, right: 16, bottom: 4),
                      child: Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              height: getVerticalSize(
                                74.00,
                              ),
                              width: getHorizontalSize(
                                396.00,
                              ),
                              margin: getMargin(
                                top: 10,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: passwordField,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: getPadding(top: 15, left: 15, right: 15),
                //   child: Container(
                //     child: Align(
                //       child: DropdownButtonFormField(
                //         decoration: InputDecoration(
                //           contentPadding:
                //               EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                //           enabledBorder: OutlineInputBorder(
                //             borderSide: BorderSide(
                //                 color: ColorConstant.plainGrey, width: 1),
                //           ),
                //           errorBorder: const OutlineInputBorder(
                //             borderSide: BorderSide(width: 1, color: Colors.red),
                //           ),
                //           focusedBorder: OutlineInputBorder(
                //             borderSide:
                //                 BorderSide(color: Colors.grey, width: 1),
                //           ),
                //         ),
                //         hint: Text("Select Role",
                //             style: AppStyle.txtInterMedium12.copyWith()),
                //         dropdownColor: Colors.white,
                //         value: _selectedRole,
                //         onChanged: (String? newValue) {
                //           setState(() {
                //             _selectedRole = newValue!;
                //           });
                //         },
                //         items:
                //             _roles.map<DropdownMenuItem<String>>((String role) {
                //           return DropdownMenuItem<String>(
                //             value: role,
                //             child: Text(
                //               role,
                //             ),
                //           );
                //         }).toList(),
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: getPadding(top: 15),
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: getPadding(bottom: 2),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen(name: widget.name,
                                          email: widget.email,
                                          phone: widget.phone,)));
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              shape: StadiumBorder(),
                              backgroundColor: ColorConstant.teal800,
                              minimumSize: Size(340, 40),
                            ),
                            child: Text("Sign Up"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: getPadding(top: 15),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: getVerticalSize(74.00),
                      width: getHorizontalSize(396.00),
                      margin: getMargin(left: 16, right: 16, bottom: 4),
                      child: Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              height: getVerticalSize(
                                74.00,
                              ),
                              width: getHorizontalSize(
                                396.00,
                              ),
                              margin: getMargin(
                                top: 10,
                              ),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              const Text('Already have an account?'),
                              TextButton(
                                child: const Text(
                                  'Log in',
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen(name: widget.name,
                                            email: widget.email,
                                            phone: widget.phone,)));
                                },
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
