import 'package:acme_corp_interview/presentation/Client/client_home_screen.dart';
import 'package:acme_corp_interview/presentation/SharedPreference/shared_done.dart';
import 'package:acme_corp_interview/theme/color_constant.dart';
import 'package:acme_corp_interview/theme/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../theme/app_style.dart';

class ClientTransitionTicket extends StatefulWidget {
  const ClientTransitionTicket(
      {Key? key, required this.name, required this.email, required this.phone})
      : super(key: key);
  final String name;
  final String email;
  final String phone;

  @override
  State<ClientTransitionTicket> createState() => _ClientTransitionTicketState();
}

class _ClientTransitionTicketState extends State<ClientTransitionTicket> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String? _title;
  String? _description;
  String? _comment;
  String? _status;

  @override
  void initState() {
    super.initState();
    _loadTicket();
  }

  Future<void> _loadTicket() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _title = prefs.getString('title');
      _description = prefs.getString('description');
      _comment = prefs.getString('comment');
      _status = prefs.getString('status');
    });
  }

  Future<void> launchTicket(Transition transition) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'ticket',
      transition.ticket,
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
          label: Text("Comment"),
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
                  final shared = Transition(ticket: titleController.text);
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
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Ticket Resolved")));
                },
                child: Text('Ticket Status'),
              );
            }
          }),
    );

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Ticket: ${_title ?? 'Ticket'}",
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
        ));
  }
}
