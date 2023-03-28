import 'package:acme_corp_interview/presentation/Agent/view_ticket.dart';
import 'package:acme_corp_interview/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AgentLogScreen extends StatefulWidget {
  const AgentLogScreen({Key? key, required this.name, required this.email, required this.phone}) : super(key: key);
  final String name;
  final String email;
  final String phone;

  @override
  State<AgentLogScreen> createState() => _AgentLogScreenState();
}

class _AgentLogScreenState extends State<AgentLogScreen> {
  String? _ticket;

  @override
  void initState() {
    super.initState();
    _loadTicket();
  }

  Future<void> _loadTicket() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _ticket = prefs.getString('ticket');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Log Ticket",
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
              builder: (context) => ViewTicketAgent(
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
                title: Text('Ticket: '),
                subtitle: Text('${_ticket ?? 'No ticket currently'} '),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
