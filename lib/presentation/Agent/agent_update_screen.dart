import 'package:acme_corp_interview/presentation/Agent/agent_home_screen.dart';
import 'package:acme_corp_interview/presentation/Agent/view_client_screen.dart';
import 'package:acme_corp_interview/theme/app_style.dart';
import 'package:acme_corp_interview/theme/color_constant.dart';
import 'package:acme_corp_interview/theme/size_utils.dart';
import 'package:flutter/material.dart';

class AgentUpdateScreen extends StatefulWidget {
  const AgentUpdateScreen({Key? key, required this.name, required this.email, required this.phone}) : super(key: key);
  final String name;
  final String email;
  final String phone;

  @override
  State<AgentUpdateScreen> createState() => _AgentUpdateScreenState();
}

class _AgentUpdateScreenState extends State<AgentUpdateScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool _isHidden = true;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final nameField = TextFormField(
      controller: nameController,
      keyboardType: TextInputType.name,
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
          label: Text("Enter username"),
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
          label: Text("Enter email"),
          contentPadding: EdgeInsets.fromLTRB(14.0, 1.0, 4.0, 2.0),
          labelStyle: AppStyle.txtInterMedium18.copyWith(
            letterSpacing: 0.50,
            height: 1.00,
          ),
          filled: true,
          fillColor: ColorConstant.whiteA700),
    );

    Future<void> submitForm() async {
      if (formKey.currentState!.validate()) {
        formKey.currentState?.save();
        print('Form submitted');
      }
    }

    final addUser = Material(
      child: FutureBuilder(
          future: submitForm(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading...');
            } else {
              return ElevatedButton(
                onPressed: () {
                  formKey.currentState?.save();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AgentHomeScreen(
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                      ),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Client profile updated successfully")));
                },
                child: Text('Update Client Profile'),
              );
            }
          }),
    );

    final phoneField = TextFormField(
      controller: phoneController,
      keyboardType: TextInputType.phone,
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
          label: Text("Enter phone number"),
          contentPadding: EdgeInsets.fromLTRB(14.0, 1.0, 4.0, 2.0),
          labelStyle: AppStyle.txtInterMedium18.copyWith(
            letterSpacing: 0.50,
            height: 1.00,
          ),
          filled: true,
          fillColor: ColorConstant.whiteA700),
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AgentHomeScreen(
                  name: widget.name,
                  email: widget.email,
                  phone: widget.phone,
                ),
              ),
            );
          },
        ),
        title: Center(
            child: Text(
              'Update Profile',
              style: AppStyle.txtInterBold24.copyWith(
                letterSpacing: 0.72,
              ),
            )),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                          child: phoneField,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    addUser,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
