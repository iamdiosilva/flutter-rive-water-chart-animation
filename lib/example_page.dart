import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  final ValueNotifier<double> _valueNotifier = ValueNotifier<double>(0.0);

  // Controller for playback
  late StateMachineController? _controller;
  SMIInput<double>? valueInput;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          RiveAnimation.asset(
            'assets/animations/water-bar-demo.riv',
            stateMachines: const [
              'State Machine',
            ],
            onInit: (artboard) {
              setState(() {
                _controller = StateMachineController.fromArtboard(
                    artboard, "State Machine");

                if (_controller == null) return;
                artboard.addController(_controller!);
                valueInput = _controller?.findInput("Level");
              });
            },
            fit: BoxFit.fitHeight,
          ),
          const Positioned(
            top: 72,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'RIVE',
                  style: TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.w500,
                    height: 0.5,
                    color: Colors.lightBlueAccent,
                  ),
                ),
                Text(
                  'Animation',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    color: Colors.lightBlueAccent,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            child: RotatedBox(
              quarterTurns: 3,
              child: ValueListenableBuilder<double>(
                valueListenable: _valueNotifier,
                builder: (context, value, child) => SizedBox(
                  width: 256,
                  child: Slider(
                    activeColor: Colors.lightBlueAccent,
                    min: 0,
                    max: 100,
                    value: value,
                    onChanged: (value) {
                      _valueNotifier.value = value;
                      valueInput?.change(value);
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
