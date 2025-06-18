class Category {
  final String name;
  final int isCustom;

  Category({
    required this.name,
    required this.isCustom,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isCustom': isCustom,
    };
  }

  factory Category.fromJson(Map<String, dynamic> map) {
    return Category(
      name: map['name'],
      isCustom: map['isCustom'],
    );
  }
}
