import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Data Diri',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const FormPage(),
    );
  }
}

//Halaman 1: Form Input 
class FormPage extends StatefulWidget {
  const FormPage({super.key});
  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController nimController = TextEditingController();
  final TextEditingController fakultasController = TextEditingController();
  final TextEditingController prodiController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController hpController = TextEditingController();

  File? _imageFile;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nama', namaController.text);
    await prefs.setString('nim', nimController.text);
    await prefs.setString('fakultas', fakultasController.text);
    await prefs.setString('prodi', prodiController.text);
    await prefs.setString('alamat', alamatController.text);
    await prefs.setString('hp', hpController.text);
    if (_imageFile != null) {
      await prefs.setString('fotoPath', _imageFile!.path);
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Data berhasil disimpan")),
    );
  }

  void navigateToDisplayPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DisplayPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Data Diri')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Isi Data Diri Anda",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildStyledTextField(namaController, "Nama"),
            const SizedBox(height: 10),
            _buildStyledTextField(nimController, "NIM"),
            const SizedBox(height: 10),
            _buildStyledTextField(fakultasController, "Fakultas"),
            const SizedBox(height: 10),
            _buildStyledTextField(prodiController, "Prodi"),
            const SizedBox(height: 10),
            _buildStyledTextField(alamatController, "Alamat"),
            const SizedBox(height: 10),
            _buildStyledTextField(hpController, "Nomor HP", keyboardType: TextInputType.phone),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text("Pilih Foto", style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 10),
            _imageFile != null
                ? Image.file(_imageFile!, height: 100)
                : const Text("Belum ada foto yang dipilih", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveData,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text("Simpan Data", style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: navigateToDisplayPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text("Lihat Data", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStyledTextField(TextEditingController controller, String labelText, {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(fontSize: 16),
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blueAccent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
      ),
    );
  }
}

//Halaman 2: Tampilkan Data 
class DisplayPage extends StatefulWidget {
  const DisplayPage({super.key});
  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  String? nama, nim, fakultas, prodi, alamat, hp, fotoPath;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nama = prefs.getString('nama');
      nim = prefs.getString('nim');
      fakultas = prefs.getString('fakultas');
      prodi = prefs.getString('prodi');
      alamat = prefs.getString('alamat');
      hp = prefs.getString('hp');
      fotoPath = prefs.getString('fotoPath');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Diri Anda')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView(
          children: [
            Text("Nama: $nama", style: const TextStyle(fontSize: 18)),
            Text("NIM: $nim", style: const TextStyle(fontSize: 18)),
            Text("Fakultas: $fakultas", style: const TextStyle(fontSize: 18)),
            Text("Prodi: $prodi", style: const TextStyle(fontSize: 18)),
            Text("Alamat: $alamat", style: const TextStyle(fontSize: 18)),
            Text("Nomor HP: $hp", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            fotoPath != null
                ? Image.file(File(fotoPath!), height: 150)
                : const Text("Tidak ada foto", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
