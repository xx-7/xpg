```dart

// 数据
import 'package:flutter/material.dart';

class BookModel {
  static final _books = [
    Book(1, "夜的命名数"),
    Book(2, "大奉打更人"),
    Book(3, "星门"),
    Book(4, "大魏读书人"),
    Book(5, "我师兄实在太稳健了"),
    Book(6, "深空彼岸"),
  ];

  int get length => _books.length;

  Book getById(int id) => _books[id - 1];

  Book getByPosition(int position) => _books[position];
}

class Book {
  final int bookId;
  final String bookName;

  Book(this.bookId, this.bookName);
}

class BookManagerModel with ChangeNotifier {
  final BookModel _bookModel;

  final List<int>? _bookIds;

  BookManagerModel(this._bookModel, {BookManagerModel? bookManagerModel})
      : _bookIds = bookManagerModel?._bookIds ?? [];

  List<Book> get books =>
      _bookIds!.map((id) => _bookModel.getById(id)).toList();

  Book getByPosition(int position) => books[position];

  int get length => _bookIds?.length ?? 0;

  void addFaves(Book book) {
    _bookIds!.add(book.bookId);
    notifyListeners();
  }

  void removeFaves(Book book) {
    _bookIds!.remove(book.bookId);
    notifyListeners();
  }
}

// 入口
return MultiProvider(
    providers: [
      Provider(create: (_) => BookModel()),
      ChangeNotifierProxyProvider<BookModel, BookManagerModel>(
          create: (_) => BookManagerModel(BookModel()),
          update: (_, m1, m2) => BookManagerModel(m1)),
    ],
    child: const Example(),
  );

// 使用
class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: '列表', icon: Icon(Icons.book)),
                Tab(text: '收藏', icon: Icon(Icons.favorite)),
              ],
            ),
            SizedBox(
                width: 1024,
                height: 768,
                child: TabBarView(
                  children: [PageA(), PageB()],
                )),
          ],
        ));
  }
}

class PageA extends StatelessWidget {
  const PageA({super.key});

  @override
  Widget build(BuildContext context) {
    var bookModel = Provider.of<BookModel>(context);

    return ListView.builder(
      itemCount: bookModel.length,
      itemBuilder: (_, index) => BookItem(id: index + 1),
    );
  }
}

class PageB extends StatelessWidget {
  const PageB({super.key});

  @override
  Widget build(BuildContext context) {
    var bookManagerModel = Provider.of<BookManagerModel>(context);
    var bookCount = bookManagerModel.length;

    return ListView.builder(
      itemCount: bookCount,
      itemBuilder: (_, index) =>
          BookItem(id: bookManagerModel.getByPosition(index).bookId),
    );
  }
}

class BookItem extends StatelessWidget {
  final int id;

  const BookItem({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    var bookModel = Provider.of<BookModel>(context);
    var book = bookModel.getById(id);

    return ListTile(
      leading: CircleAvatar(
        child: Text("${book.bookId}"),
      ),
      title: Text(
        style: const TextStyle(color: Colors.black87),
        '${book.bookName} ',
      ),
      trailing: BookButton(book: book),
    );
  }
}

class BookButton extends StatelessWidget {
  final Book book;

  const BookButton({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    var bookManagerModel = Provider.of<BookManagerModel>(context);

    return GestureDetector(
      onTap: bookManagerModel.books.contains(book)
          ? () => bookManagerModel.removeFaves(book)
          : () => bookManagerModel.addFaves(book),
      child: SizedBox(
        width: 100,
        height: 60,
        child: bookManagerModel.books.contains(book)
            ? const Icon(
                Icons.star,
                color: Colors.red,
              )
            : const Icon(Icons.star_border),
      ),
    );
  }
}



```