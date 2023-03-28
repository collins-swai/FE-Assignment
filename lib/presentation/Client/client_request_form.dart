import 'package:acme_corp_interview/presentation/Client/client_home_screen.dart';
import 'package:acme_corp_interview/presentation/SharedPreference/shared.dart';
import 'package:acme_corp_interview/theme/app_style.dart';
import 'package:acme_corp_interview/theme/color_constant.dart';
import 'package:acme_corp_interview/theme/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Agent/agent_log_screen.dart';

class ClientRequestForm extends StatefulWidget {
  const ClientRequestForm(
      {Key? key, required this.name, required this.email, required this.phone})
      : super(key: key);
  final String name;
  final String email;
  final String phone;

  @override
  State<ClientRequestForm> createState() => _ClientRequestFormState();
}

class _ClientRequestFormState extends State<ClientRequestForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> launchTicket(Shared shared) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'ticket',
      shared.ticket,
    );
  }

  @override
  Widget build(BuildContext context) {
    final titleField = TextFormField(
      controller: titleController,
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
          label: Text("Title of Complaint"),
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
                onPressed: () async {
                  final shared = Shared(ticket: titleController.text);
                  await launchTicket(shared);
                  formKey.currentState?.save();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ClientHomeScreen(
                        name: widget.name,
                        email: widget.email,
                        phone: widget.phone,
                      ),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Ticket launched successfully")));
                },
                child: Text('Launch Ticket'),
              );
            }
          }),
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "New Ticket",
          style: AppStyle.txtInterBold24.copyWith(
            letterSpacing: 0.72,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
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
                          child: titleField,
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
                    Padding(
                      padding: getPadding(bottom: 2),
                      child: addUser,
                    ),
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
