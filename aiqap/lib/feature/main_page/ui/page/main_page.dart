import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Text("Main page", style: TextStyle(color: Colors.black)),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Expanded(
              child: Container(
                // padding: EdgeInsets.only(
                //   top: 50,
                //   left: 50,
                // ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(50),
                  //   topRight: Radius.circular(50),
                  // ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BookSection(
                        heading: "Танымал кітаптар",
                      ),
                      BookSection(
                        heading: "Шытырман оқиға",
                      ),
                      BookSection(
                        heading: "Драма",
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Book {
  final String name;
  final String author;
  final String coverImage;
  final double rating;

  Book({this.author, this.coverImage, this.name, this.rating});
}

List<Book> _recentBooks = [
  Book(
      name: "Conjure Women",
      author: "Afia Atakora",
      coverImage: "assets/abay_path.png",
      rating: 4.0),
  Book(
      name: "Felix Ever After",
      author: "Kacen Callender",
      coverImage: "assets/abay_path.png",
      rating: 4.0),
];
List<Book> get recentBooks {
  return [..._recentBooks];
}

class BookSection extends StatelessWidget {
  final String heading;
  BookSection({this.heading});
  @override
  Widget build(BuildContext context) {
    List<Book> bookList;
    if (heading == "Танымал кітаптар") {
      bookList = recentBooks;
    } else if (heading == "Шытырман оқиға") {
      bookList = recentBooks;
    } else if (heading == "Драма") {
      bookList = recentBooks;
    }
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 5,
            ),
            height: MediaQuery.of(context).size.height * 0.25,
            child: ListView.builder(
              itemBuilder: (ctx, i) => GestureDetector(
                // onTap: () => Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (ctx) => BooksDetails(
                //       index: i,
                //       section: heading,
                //     ),
                //   ),
                // ),
                child: Row(
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/book_page",
                                arguments: [0]);
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.21,
                            width: MediaQuery.of(context).size.width * 0.63,
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          'assets/abay_path.png',
                                          height: 250,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20.0),
                                                topRight: Radius.circular(20))),
                                      ),
                                      Container(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            'Абай жолы',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22.0),
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              ),
              itemCount: bookList.length,
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      ),
    );
  }
}
