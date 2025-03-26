import 'package:flutter/material.dart';

class Pertemuan2 extends StatelessWidget {
  const Pertemuan2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Pertemuan 2'),
        backgroundColor: Colors.pinkAccent,
        leading: Icon(Icons.home),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout) ,
            onPressed: () {
              print('Logout');
            },
            color: Colors.white,
            )
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.pinkAccent,
          borderRadius: BorderRadius.circular(20),
        ),
        child:  Center(child: Text('Hello World', 
        style: TextStyle(
          fontSize: 20, 
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.italic,
          ),)),
      ),
    );
  }
}