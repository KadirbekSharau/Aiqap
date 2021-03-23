class Book {
  final int id;
  final String author;
  final String shortDesc;
  final String imgUrl;
  final String audioUrl;

  Book(this.id, this.author, this.shortDesc, this.imgUrl, this.audioUrl);
}

class Genre {
  final String janre;
  final List<Book> books;

  Genre(this.janre, this.books);
}

var genresList = [
  Genre("Танымал кітаптар", booksList),
  Genre("Шытырман оқиға", booksList),
  Genre("Драма", booksList),
];

var booksList = [
  Book(
      1,
      "Мұхтар Әуезов",
      "An Observatory debugger and profiler on Redmi Note 7 is available at: http://127.0.0.1:34825/UNwHsjQ2VDE=/",
      "https://upload.wikimedia.org/wikipedia/ru/c/c0/%D0%9C%D1%83%D1%85%D1%82%D0%B0%D1%80_%D0%90%D1%83%D1%8D%D0%B7%D0%BE%D0%B2.jpg",
      "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"),
  Book(
      1,
      "Мұхтар Әуезов",
      "An Observatory debugger and profiler on Redmi Note 7 is available at: http://127.0.0.1:34825/UNwHsjQ2VDE=/",
      "https://upload.wikimedia.org/wikipedia/ru/c/c0/%D0%9C%D1%83%D1%85%D1%82%D0%B0%D1%80_%D0%90%D1%83%D1%8D%D0%B7%D0%BE%D0%B2.jpg",
      "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"),
  Book(
      1,
      "Мұхтар Әуезов",
      "An Observatory debugger and profiler on Redmi Note 7 is available at: http://127.0.0.1:34825/UNwHsjQ2VDE=/",
      "https://upload.wikimedia.org/wikipedia/ru/c/c0/%D0%9C%D1%83%D1%85%D1%82%D0%B0%D1%80_%D0%90%D1%83%D1%8D%D0%B7%D0%BE%D0%B2.jpg",
      "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"),
  Book(
      1,
      "Мұхтар Әуезов",
      "An Observatory debugger and profiler on Redmi Note 7 is available at: http://127.0.0.1:34825/UNwHsjQ2VDE=/",
      "https://upload.wikimedia.org/wikipedia/ru/c/c0/%D0%9C%D1%83%D1%85%D1%82%D0%B0%D1%80_%D0%90%D1%83%D1%8D%D0%B7%D0%BE%D0%B2.jpg",
      "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"),
  Book(
      1,
      "Мұхтар Әуезов",
      "An Observatory debugger and profiler on Redmi Note 7 is available at: http://127.0.0.1:34825/UNwHsjQ2VDE=/",
      "https://upload.wikimedia.org/wikipedia/ru/c/c0/%D0%9C%D1%83%D1%85%D1%82%D0%B0%D1%80_%D0%90%D1%83%D1%8D%D0%B7%D0%BE%D0%B2.jpg",
      "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"),
  Book(
      1,
      "Мұхтар Әуезов",
      "An Observatory debugger and profiler on Redmi Note 7 is available at: http://127.0.0.1:34825/UNwHsjQ2VDE=/",
      "https://upload.wikimedia.org/wikipedia/ru/c/c0/%D0%9C%D1%83%D1%85%D1%82%D0%B0%D1%80_%D0%90%D1%83%D1%8D%D0%B7%D0%BE%D0%B2.jpg",
      "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"),
  Book(
      1,
      "Мұхтар Әуезов",
      "An Observatory debugger and profiler on Redmi Note 7 is available at: http://127.0.0.1:34825/UNwHsjQ2VDE=/",
      "https://upload.wikimedia.org/wikipedia/ru/c/c0/%D0%9C%D1%83%D1%85%D1%82%D0%B0%D1%80_%D0%90%D1%83%D1%8D%D0%B7%D0%BE%D0%B2.jpg",
      "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"),
];
