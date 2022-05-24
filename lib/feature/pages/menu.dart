import 'package:cake_wallet_test/feature/pages/authenticate_pin/authenticate_pin.dart';
import 'package:cake_wallet_test/feature/pages/create_pin/create_pin.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Menu',
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  CreatePin.show(context);
                },
                child: const Text('Create Pin'),
              ),
              ElevatedButton(
                onPressed: () {
                  AuthenticatePin.show(context);
                },
                child: const Text('Authenticate Pin'),
              ),
            ],
          )
        ],
      )),
    );
  }
}
