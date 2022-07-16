import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AccountEditFields extends StatelessWidget {
  final TextEditingController name;
  final TextEditingController apiKey;
  final TextEditingController apiSecret;

  const AccountEditFields({
    super.key,
    required this.name,
    required this.apiKey,
    required this.apiSecret,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Text('Account Name'),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: TextFormField(
            controller: name,
            decoration: const InputDecoration(hintText: 'Enter account name'),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an account name';
              }
              return null;
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Text('API Key'),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: TextFormField(
            controller: apiKey,
            decoration: const InputDecoration(hintText: 'Enter API Key'),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an API key';
              }
              return null;
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Text('API Secret'),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: TextFormField(
            controller: apiSecret,
            decoration: const InputDecoration(hintText: 'Enter API Secret'),
            obscureText: true,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an API secret';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
