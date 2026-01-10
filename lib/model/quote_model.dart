class Quote {
  Quote({
    required this.id,
    required this.quote,
    required this.author,
  });
  late final int id;
  late final String quote;
  late final String author;

  Quote.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quote = json['quote'];
    author = json['author'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['quote'] = quote;
    _data['author'] = author;
    return _data;
  }
}
