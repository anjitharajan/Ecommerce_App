class Category {
  final String name;

//------- category model -------\\
  Category({required this.name});

  factory Category.fromJson(String name) {
    return Category(name: name);
  }

//------category mapping -------\\
  Map<String, dynamic> toJson() => {'name': name};
}
