import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'todo.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<Todo> _todoList = [];
  final _dbHelper = DatabaseHelper();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _refreshList();
  }

  Future<void> _refreshList() async {
    List<Todo> list = _searchQuery.isEmpty
        ? await _dbHelper.getFilms()
        : await _dbHelper.searchFilms(_searchQuery);
    setState(() {
      _todoList = list;
    });
  }

  Future<String?> _pickImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  return pickedFile?.path;
}


  void _showForm({Todo? todo}) {
  final titleController = TextEditingController(text: todo?.title ?? '');
  final descController = TextEditingController(text: todo?.description ?? '');
  String? selectedImagePath = todo?.imagePath;

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(todo == null ? 'Tambah Film' : 'Edit Film'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: InputDecoration(labelText: 'Judul')),
            TextField(controller: descController, decoration: InputDecoration(labelText: 'Deskripsi')),
            SizedBox(height: 8),
            selectedImagePath != null
                ? Image.file(File(selectedImagePath!), height: 100)
                : SizedBox(),
            TextButton.icon(
              onPressed: () async {
                final path = await _pickImage();
                if (path != null) {
                  setState(() => selectedImagePath = path);
                }
              },
              icon: Icon(Icons.image),
              label: Text('Pilih Gambar'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text('Tutup')),
        ElevatedButton(
          onPressed: () async {
            final title = titleController.text;
            final desc = descController.text;
            if (todo == null) {
              await _dbHelper.insertFilm(Todo(
                title: title,
                description: desc,
                imagePath: selectedImagePath,
               ));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Film berhasil ditambahkan!')),
              );
            } else {
              await _dbHelper.updateFilm(Todo(
                id: todo.id,
                title: title,
                description: desc,
                isDone: todo.isDone,
                imagePath: selectedImagePath,
               ));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Film berhasil diperbarui!')),
              );
            }
            Navigator.pop(context);
            _refreshList();
          },
          child: Text(todo == null ? 'Tambah' : 'Update'),
        ),
      ],
    ),
  );
}


  void _confirmDelete(int id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Hapus Film?'),
        content: Text('Apakah kamu yakin ingin menghapus film ini?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Batal')),
          ElevatedButton(
            onPressed: () async {
              await _dbHelper.deleteFilm(id);
              Navigator.pop(context);
              _refreshList();
            },
            child: Text('Hapus'),
          ),
        ],
      ),
    );
  }

  void _deleteCompleted() {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text('Hapus Todo'),
      content: Text('Apakah anda yakin ingin menghapus semua data yang telah diselesaikan?'),
      actions: [
        TextButton(
          child: Text('Tutup'),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: Text('Hapus'),
          onPressed: () async {
            Navigator.pop(context);
            await _dbHelper.deleteCompletedFilms();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Film berhasil dihapus!')),
            );
            _refreshList();
          },
        ),
      ],
    ),
  );
}

  void _toggleDone(Todo todo) async {
    await _dbHelper.updateFilm(
      Todo(
        id: todo.id,
        title: todo.title,
        description: todo.description,
        isDone: todo.isDone == 1 ? 0 : 1,
        imagePath: todo.imagePath, // Pastikan imagePath tetap dipertahankan
      ),
    );
    _refreshList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Film'),
        centerTitle: true, // Judul di tengah
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari judul film...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() => _searchQuery = value);
                _refreshList();
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todoList.length,
              itemBuilder: (_, index) {
  final item = _todoList[index];

  return Card(
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: ListTile(
      contentPadding: EdgeInsets.all(8),
      leading: GestureDetector(
        onTap: () => _toggleDone(item),
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: item.isDone == 1 ? Colors.blue : Colors.grey,
              width: 2,
            ),
            color: item.isDone == 1 ? Colors.blue : Colors.transparent,
          ),
          child: item.isDone == 1
              ? Icon(
                  Icons.check,
                  size: 16,
                  color: Colors.white,
                )
              : null,
        ),
      ),
      title: Text(item.title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.description),
          if (item.imagePath != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Image.file(
                File(item.imagePath!),
                width: 100, // Resolusi tetap untuk lebar
                height: 150, // Resolusi tetap untuk tinggi
                fit: BoxFit.cover, // Menjaga proporsi gambar
              ),
            ),
        ],
      ),
      trailing: Wrap(
        spacing: 8,
        children: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.blue),
            onPressed: () => _showForm(todo: item),
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () => _confirmDelete(item.id!),
          ),
        ],
      ),
    ),
  );
}

            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: ElevatedButton.icon(
              icon: Icon(Icons.delete_sweep),
              label: Text('Hapus yang Selesai'),
              onPressed: _deleteCompleted,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(),
        child: Icon(Icons.add),
      ),
    );
  }
}
