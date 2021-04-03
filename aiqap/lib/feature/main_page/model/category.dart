class Category {
  final int id;
  final String name;
  final String createdDate;

  Category(this.id, this.name, this.createdDate);

  factory Category.parseJson(json) {
    return Category(json['id'], json['name'], json['created']);
  }
}
