import 'package:hive/hive.dart';
part 'news_model.g.dart';

@HiveType(typeId: 1)
class NewsModel {
  @HiveField(0)
  String? author;
  @HiveField(1)
  String? content;
  @HiveField(2)
  String? date;
  @HiveField(3)
  String? id;
  @HiveField(4)
  String? imageUrl;
  @HiveField(5)
  String? readMoreUrl;
  @HiveField(6)
  String? time;
  @HiveField(7)
  String? title;
  @HiveField(8)
  String? url;
  @HiveField(9)
  String? category;

  NewsModel(
      {this.author,
      this.content,
      this.date,
      this.id,
      this.imageUrl,
      this.readMoreUrl,
      this.time,
      this.title,
      this.url,
      this.category});

  NewsModel.fromJson(Map<String, dynamic> json) {
    author = json['author'] ?? "";
    content = json['content'] ?? "";
    date = json['date'] ?? "";
    id = json['id'] ?? "";
    imageUrl = json['imageUrl'] ?? "";
    readMoreUrl = json['readMoreUrl'] ?? "";
    time = json['time'] ?? "";
    title = json['title'] ?? "";
    url = json['url'] ?? "";
    category = json['category'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['author'] = author ?? "";
    data['content'] = content ?? "";
    data['date'] = date ?? "";
    data['id'] = id ?? "";
    data['imageUrl'] = imageUrl ?? "";
    data['readMoreUrl'] = readMoreUrl ?? "";
    data['time'] = time ?? "";
    data['title'] = title ?? "";
    data['url'] = url ?? "";
    data['category'] = category ?? "";
    return data;
  }
}
