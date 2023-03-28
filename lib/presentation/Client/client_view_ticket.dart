import 'package:acme_corp_interview/presentation/Client/transition_ticket.dart';
import 'package:acme_corp_interview/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientViewTicket extends StatefulWidget {
  const ClientViewTicket(
      {Key? key, required this.name, required this.email, required this.phone})
      : super(key: key);
  final String name;
  final String email;
  final String phone;

  @override
  State<ClientViewTicket> createState() => _ClientViewTicketState();
}

class _ClientViewTicketState extends State<ClientViewTicket> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "View Ticket",
          style: AppStyle.txtInterBold24.copyWith(
            letterSpacing: 0.72,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ClientTransitionTicket(
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
                title: Text('${_title ?? 'Title'}'),
                subtitle: Text('${_status ?? 'Not resolved'} '),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
