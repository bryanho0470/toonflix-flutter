import 'package:flutter/material.dart';
import 'package:toonflix/widget/currency_card.dart';
import 'widget/button.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: const Color(0xFF181818),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 80,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  const Text('Hey, Selena',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                      )),
                  Text('Wecome Black',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 16,
                      )),
                ])
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            Text(
              "Total Balnace",
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 22,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "\$5 194 482",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyButton(
                  text: "Transfer",
                  bgColor: Colors.amber,
                  textColor: Colors.black,
                ),
                MyButton(
                  text: "Request",
                  bgColor: Color.fromARGB(200, 200, 200, 1),
                  textColor: Colors.white,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text("Wallets",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      )),
                  Text("View all",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Currency_card(
              name: "Euro",
              code: 'EUR',
              amount: "6 428",
              icon: Icons.euro_rounded,
              isInverted: false,
            ),
            Transform.translate(
              offset: const Offset(0, -30),
              child: const Currency_card(
                name: "Dollar",
                code: 'USD',
                amount: "53 234",
                icon: Icons.attach_money_rounded,
                isInverted: true,
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -60),
              child: const Currency_card(
                name: "Bitcoin",
                code: 'BTC',
                amount: "1 278",
                icon: Icons.currency_bitcoin_rounded,
                isInverted: false,
              ),
            ),
          ]),
        ),
      ),
    ));
  }
}
