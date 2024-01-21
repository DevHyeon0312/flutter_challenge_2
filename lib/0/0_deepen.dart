import 'package:flutter/material.dart';
import 'dart:math';

enum Shape {
  rect,
  circle,
}

class MyApp0Deepen extends StatefulWidget {
  const MyApp0Deepen({super.key});

  @override
  State<MyApp0Deepen> createState() => _MyApp0DeepenState();
}

class _MyApp0DeepenState extends State<MyApp0Deepen> {
  Shape dragShape = Shape.rect;

  void initDragShape() {
    final random = Random();
    int randomInt = random.nextInt(100);
    if (randomInt < 50) {
      setState(() {
        dragShape = Shape.rect;
      });
    } else {
      setState(() {
        dragShape = Shape.circle;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello Draggable!',
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const Spacer(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BucketWidget(
                    shape: Shape.rect,
                    score: 0,
                  ),
                  BucketWidget(
                    shape: Shape.circle,
                    score: 0,
                  ),
                ],
              ),
              const Spacer(),
              DragWidget(
                shape: dragShape,
                onDragEnd: () {
                  initDragShape();
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class BucketWidget extends StatefulWidget {
  const BucketWidget({
    super.key,
    required this.shape,
    required this.score,
  });

  final Shape shape;
  final int score;
  final Size shapeSize = const Size(100,100);

  @override
  State<BucketWidget> createState() => _BucketWidgetState();
}

class _BucketWidgetState extends State<BucketWidget> {
  var _isWillAccept = false;
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _score = widget.score;
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      builder: (BuildContext context, List<dynamic> candidateData,
          List<dynamic> rejectedData) {
        return Container(
          width: widget.shapeSize.width,
          height: widget.shapeSize.height,
          decoration: BoxDecoration(
            shape: widget.shape == Shape.rect
                ? BoxShape.rectangle
                : BoxShape.circle,
            border: Border.all(
              color: Colors.black,
              width: _isWillAccept ? 4.0 : 2.0,
            ),
          ),
          child: Center(
            child: Text('$_score'),
          ),
        );
      },
      onAccept: (_) {
        setState(() {
          _score++;
          _isWillAccept = false;
        });
      },
      onLeave: (_) {
        setState(() {
          _isWillAccept = false;
        });
      },
      onWillAccept: (data) {
        setState(() {
          _isWillAccept = data == widget.shape;
        });
        return data == widget.shape;
      },
    );
  }
}

class DragWidget extends StatefulWidget {
  const DragWidget({
    super.key,
    required this.shape,
    required this.onDragEnd,
  });

  final Shape shape;
  final VoidCallback onDragEnd;
  final Size shapeSize = const Size(70,70);

  @override
  State<DragWidget> createState() => _DragWidgetState();
}

class _DragWidgetState extends State<DragWidget> {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(
        fontSize: 14.0,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      child: Draggable(
        data: widget.shape,
        childWhenDragging: SizedBox(
          width: widget.shapeSize.width,
          height: widget.shapeSize.height,
        ),
        onDragEnd: (detail) {
          if (detail.wasAccepted) {
            widget.onDragEnd.call();
          }
        },
        feedback: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          child: Container(
            width: widget.shapeSize.width,
            height: widget.shapeSize.height,
            decoration: BoxDecoration(
              shape: widget.shape == Shape.rect
                  ? BoxShape.rectangle
                  : BoxShape.circle,
              border: Border.all(
                color: Colors.black,
                width: 2.0,
              ),
            ),
            child: const Center(
              child: Text('Drag Me!'),
            ),
          ),
        ),
        child: Container(
          width: widget.shapeSize.width,
          height: widget.shapeSize.height,
          decoration: BoxDecoration(
            shape: widget.shape == Shape.rect
                ? BoxShape.rectangle
                : BoxShape.circle,
            border: Border.all(
              color: Colors.black,
              width: 2.0,
            ),
          ),
          child: const Center(
            child: Text('Drag Me!'),
          ),
        ),
      ),
    );
  }
}