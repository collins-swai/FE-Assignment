import 'package:acme_corp_interview/presentation/SharedPreference/shared_preference_helper.dart';
import 'package:acme_corp_interview/theme/color_constant.dart';
import 'package:acme_corp_interview/theme/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../theme/app_style.dart';
import 'agent_home_screen.dart';

class ViewTicketAgent extends StatefulWidget {
  const ViewTicketAgent(
      {Key? key, required this.name, required this.email, required this.phone})
      : super(key: key);
  final String name;
  final String email;
  final String phone;

  @override
  State<ViewTicketAgent> createState() => _ViewTicketAgentState();
}

class _ViewTicketAgentState extends State<ViewTicketAgent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> commentTicket(ClientComplaint clientComplaint) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'title',
      clientComplaint.title,
    );
    await prefs.setString('description', clientComplaint.description);
    await prefs.setString('comment', clientComplaint.comment);
    await prefs.setString('status', clientComplaint.status);
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

    final descriptionField = TextFormField(
      controller: descriptionController,
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
          label: Text("Description of Ticket"),
          contentPadding: EdgeInsets.fromLTRB(14.0, 1.0, 4.0, 2.0),
          labelStyle: AppStyle.txtInterMedium18.copyWith(
            letterSpacing: 0.50,
            height: 1.00,
          ),
          filled: true,
          fillColor: ColorConstant.whiteA700),
    );

    final commentField = TextFormField(
      controller: commentController,
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
          label: Text("Comment"),
          contentPadding: EdgeInsets.fromLTRB(14.0, 1.0, 4.0, 2.0),
          labelStyle: AppStyle.txtInterMedium18.copyWith(
            letterSpacing: 0.50,
            height: 1.00,
          ),
          filled: true,
          fillColor: ColorConstant.whiteA700),
    );

    final statusField = TextFormField(
      controller: statusController,
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
          label: Text("Status"),
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
                  final client = ClientComplaint(
                      title: titleController.text,
                      description: descriptionController.text,
                      comment: commentController.text,
                      status: statusController.text);
                  await commentTicket(client);
                  formKey.currentState?.save();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AgentHomeScreen(
                        name: widget.name,
                        email: widget.email,
                        phone: widget.phone,
                      ),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Client ticket updated")));
                },
                child: Text('Update Ticket'),
              );
            }
          }),
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Update Ticket",
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
                          child: descriptionField,
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
                          child: commentField,
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
                          child: statusField,
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
