class Author {
  final int id;
  final String fullName;
  final String birthDate;

  Author(this.id, this.fullName, this.birthDate);

  factory Author.parseJson(json) {
    return Author(json['id'], json['full_name'], json['birth_date']);
  }
}
