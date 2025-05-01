class Todo {
  int? id;
  String title;
  String description;
  int isDone;
  String? imagePath;

  Todo({
    this.id,
    required this.title,
    required this.description,
    this.isDone = 0,
    this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isDone': isDone,
      'imagePath': imagePath,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isDone: map['isDone'],
      imagePath: map['imagePath'],
    );
  }
}

