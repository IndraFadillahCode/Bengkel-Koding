import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(WarungAjibApp());
}

class WarungAjibApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Warung Ajib',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WarungAjibHome(),
    );
  }
}

class WarungAjibHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              SizedBox(height: 20),
              _buildWelcomeText(),
              SizedBox(height: 20),
              _buildMenuList(),
              SizedBox(height: 20),
              _buildPromoGrid(),
              SizedBox(height: 20),
              _buildActionButtons(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // AppBar
  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Warung Ajib'),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout, color: Colors.black),
          onPressed: () {
            SystemNavigator.pop(); // Keluar dari aplikasi
          },
        ),
      ],
    );
  }

  // Welcome Text
  Widget _buildWelcomeText() {
    return Text(
      'Selamat Datang di Warung Ajib',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  // Menu List
  Widget _buildMenuList() {
    return Column(
      children: [
        _buildMenuItem('Nasi Goreng', 'Rp 15.000'),
        _buildMenuItem('Mie Goreng', 'Rp 12.000'),
        _buildMenuItem('Es Teh', 'Rp 5.000'),
      ],
    );
  }

  Widget _buildMenuItem(String title, String price) {
    return ListTile(
      title: Text(title),
      subtitle: Text(price),
      trailing: Icon(Icons.add),
      onTap: () {
        // Aksi ketika item di-tap
      },
    );
  }

  // Promo Grid
  Widget _buildPromoGrid() {
    final promos = [
      {'color': Colors.blue, 'text': 'Promo 1'},
      {'color': Colors.green, 'text': 'Promo 2'},
      {'color': Colors.red, 'text': 'Promo 3'},
      {'color': Colors.purple, 'text': 'Promo 4'},
      {'color': Colors.orange, 'text': 'Promo 5'},
      {'color': Colors.teal, 'text': 'Promo 6'},
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: promos.map((promo) => _buildPromoItem(promo)).toList(),
    );
  }

  Widget _buildPromoItem(Map<String, dynamic> promo) {
    return InkWell(
      onTap: () {
        // Aksi ketika item di-tap
      },
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: promo['color'],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            promo['text'],
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }

  // Action Buttons
  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Pesan Sekarang', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Lihat Menu', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
        ),
      ],
    );
  }
}