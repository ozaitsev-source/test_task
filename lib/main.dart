import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: TestTaskScreen(),
  ));
}

class TestTaskScreen extends StatefulWidget {
  const TestTaskScreen({super.key});
  @override
  State<TestTaskScreen> createState() => _TestTaskScreenState();
}

class _TestTaskScreenState extends State<TestTaskScreen>{

double _rotationAngle = 0.0;



@override
Widget build(BuildContext context){
  return Scaffold(
    body: Row(children: [
      AspectRatio(
        aspectRatio: 4/3,
        child: Padding(padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration:BoxDecoration( border: Border()),
          child: Image.asset('assets/stars_sky_space.jpg',
          fit: BoxFit.cover,),
          ),
        ),
      ),




  Expanded(child: Padding(padding: const EdgeInsets.only(
    left: 20.0,
    top: 20.0,
    right: 40.0,
    bottom: 20.0
  ),
  child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        children: [
        Padding(padding: const EdgeInsets.only(right: 30),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
        const SizedBox(height: 50),
        _button('-10°', -pi/18),
        ElevatedButton(onPressed: (){
          setState(() {
            _rotationAngle = 0;
          });
        },
        child:Text('0'),
        ),
        _button('+10°', pi/18),        
          ]
        ),
        ),
              
      Slider(value: _rotationAngle,
      min: -pi,
      max: pi,
        onChanged: (value){
        setState((){
          _rotationAngle = value;
        });
        },
      ),
      ],
    ),
      


      Transform.rotate(angle: _rotationAngle,
      child:CustomPaint(
        size: Size(100,100),
        painter: TrianglePainter(),
      )
    )],
  ),
  ),
  ),
    ]),
    );
}


Widget _button(String text, double step){
  return ElevatedButton(onPressed: (){
    setState((){
      _rotationAngle += step;
    });
    _rotationAngle = (_rotationAngle).clamp(-pi, pi);
  },
  child:Text(text),
  );
}
}

class TrianglePainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size){
    final paint = Paint()
    ..color = Color.fromARGB(120, 120, 0, 120)
    ..style = PaintingStyle.fill;
    final path = Path();
    path.moveTo(size.width/2, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

