import 'package:flutter/material.dart';

class Basic1TextStyle {
  Basic1TextStyle._();

  static const TextStyle title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const TextStyle itemTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const TextStyle itemBody = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );
  static const TextStyle subscribeTitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const TextStyle subscribeBody = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );
  static const TextStyle subscribeButton = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );
}

class Basic1Solution extends StatefulWidget {
  const Basic1Solution({super.key});

  @override
  State<Basic1Solution> createState() => _Basic1SolutionState();
}

class _Basic1SolutionState extends State<Basic1Solution> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: const Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NoScalingText(
                        'FlutterBoot Plus',
                        style: Basic1TextStyle.title,
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      ItemWidget(
                        iconData: Icons.bolt,
                        title: 'Premium features',
                        body:
                            'Plus subscribers have access to FlutterBoot+ and our latest beta features.',
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ItemWidget(
                        iconData: Icons.whatshot,
                        title: 'Priority access',
                        body:
                            'You’ll be able to use FlutterBot+ even when demand is high',
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ItemWidget(
                        iconData: Icons.speed,
                        title: 'Ultra-fast',
                        body:
                            'Enjoy even faster response speeds when using FlutterBoot',
                      ),
                    ],
                  ),
                ),
              ),
              NoScalingText(
                'Restore subscription',
                style: Basic1TextStyle.subscribeTitle,
              ),
              SizedBox(
                height: 8,
              ),
              NoScalingText(
                'Auto-renews for \$25/month until canceled',
                style: Basic1TextStyle.subscribeBody,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(99),
            ),
            disabledColor: Colors.black,
            onPressed: null,
            child: const NoScalingText(
              'Subscribe',
              style: Basic1TextStyle.subscribeButton,
            ),
          )),
    );
  }
}

class NoScalingText extends StatelessWidget {
  const NoScalingText(
    this.data, {
    super.key,
    this.style,
  });

  final String data;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: style,
      textScaler: TextScaler.noScaling,
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.iconData,
    required this.title,
    required this.body,
  });

  final IconData iconData;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          iconData,
          size: 32,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NoScalingText(
                title,
                style: Basic1TextStyle.itemTitle,
              ),
              NoScalingText(
                body,
                style: Basic1TextStyle.itemBody,
              )
            ],
          ),
        ),
      ],
    );
  }
}
