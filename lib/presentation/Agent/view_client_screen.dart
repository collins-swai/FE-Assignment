import 'package:acme_corp_interview/presentation/Agent/agent_home_screen.dart';
import 'package:acme_corp_interview/presentation/Agent/agent_update_screen.dart';
import 'package:acme_corp_interview/theme/app_style.dart';
import 'package:flutter/material.dart';

class ViewClientScreen extends StatefulWidget {
  const ViewClientScreen(
      {Key? key, required this.name, required this.email, required this.phone})
      : super(key: key);
  final String name;
  final String email;
  final String phone;

  @override
  State<ViewClientScreen> createState() => _ViewClientScreenState();
}

class _ViewClientScreenState extends State<ViewClientScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'View Profile',
          style: AppStyle.txtInterBold24.copyWith(
            letterSpacing: 0.72,
          ),
        )),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
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
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AgentUpdateScreen(
                name: widget.name,
                email: widget.email,
                phone: widget.phone,
              ),
            ),
          );
        },
        child: Card(
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Image.asset('assets/images/profile.png'),
                title: Text('${widget.name}'),
                subtitle: Text('${widget.email} , ${widget.phone} '),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
