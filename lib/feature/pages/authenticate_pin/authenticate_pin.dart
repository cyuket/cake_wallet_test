import 'package:cake_wallet_test/feature/providers/authenticate_pin_provider.dart';
import 'package:cake_wallet_test/feature/widgets/pin_code_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticatePin extends StatefulWidget {
  const AuthenticatePin({Key? key, required this.provider}) : super(key: key);
  final AuthenticatePinProvider provider;
  static Future<void> show(BuildContext context,
      [bool isConfirm = false]) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
          create: (context) => AuthenticatePinProvider(),
          child: Consumer<AuthenticatePinProvider>(builder: (_, value, __) {
            return AuthenticatePin(
              provider: value,
            );
          }),
        ),
      ),
    );
  }

  @override
  State<AuthenticatePin> createState() => _AuthenticatePinState();
}

class _AuthenticatePinState extends State<AuthenticatePin> {
  @override
  void initState() {
    widget.provider.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Enter your PIN',
                    style: TextStyle(
                      fontSize: 24,
                      color: Color(0xff859DBB),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i = 0;
                          i < (widget.provider.isSixCode ? 6 : 4);
                          i++)
                        Row(
                          children: [
                            const SizedBox(width: 5.0),
                            PinCodeWidget(
                              filled: widget.provider.pins.length >= (i + 1),
                            ),
                            const SizedBox(width: 5.0),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 13.5,
                mainAxisSpacing: 13.5,
                childAspectRatio: 1.5,
              ),
              itemCount: 12,
              itemBuilder: (_, i) {
                return InkWell(
                  onTap: () {
                    widget.provider.keysPressed(i);
                  },
                  child: Container(
                    height: 30.0,
                    width: 30.0,
                    decoration: BoxDecoration(
                      color:
                          i == 9 ? Colors.transparent : const Color(0xffF5F6F9),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: i == 11
                          ? const Icon(
                              Icons.backspace_outlined,
                              size: 24.0,
                              color: Colors.black,
                            )
                          : Text(
                              i == 10 ? '0' : (i == 9 ? '' : '${i + 1}'),
                              style: const TextStyle(
                                fontSize: 20,
                                color: Color(0xff859DBB),
                              ),
                            ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
