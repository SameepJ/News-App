import 'package:flutter/material.dart';

class ArticleModel {
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  ArticleModel({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  ArticleModel.fromJson(Map<String, dynamic> json) {
    source = json['source'] != null
        ? Source.fromJson(json['source'])
        : Source(id: 'unknown', name: 'Unknown Source');
    author = json['author'] ?? 'Unknown Author';
    title = json['title'] ?? 'No Title';
    description = json['description'] ?? '';
    url = json['url'] ?? '';

    // Check if urlToImage is valid
    if (json['urlToImage'] != null) {
      // Replace 'file://' with default image if needed
      if (json['urlToImage'].startsWith('file://') ||
          !(json['urlToImage'].contains('.png') ||
              json['urlToImage'].contains('.jpg') ||
              json['urlToImage'].contains('.jpeg'))) {
        urlToImage =
        'https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/7a/3b/db/7a3bdb75-ab9b-827d-2866-2eb73fceab27/AppIcon-live-0-0-1x_U007emarketing-0-5-0-0-85-220.png/512x512bb.jpg';
      } else {
        urlToImage = json['urlToImage'];
      }
    } else {
      urlToImage =
      'https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/7a/3b/db/7a3bdb75-ab9b-827d-2866-2eb73fceab27/AppIcon-live-0-0-1x_U007emarketing-0-5-0-0-85-220.png/512x512bb.jpg';
    }

    publishedAt = json['publishedAt'] ?? DateTime.now().toIso8601String();
    content = json['content'] ?? 'Content not available';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.source != null) {
      data['source'] = this.source!.toJson();
    }
    data['author'] = this.author ?? 'Unknown Author';
    data['title'] = this.title ?? 'No Title';
    data['description'] = this.description ?? 'No Description';
    data['url'] = this.url ?? '';
    data['urlToImage'] = this.urlToImage ??
        'https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/7a/3b/db/7a3bdb75-ab9b-827d-2866-2eb73fceab27/AppIcon-live-0-0-1x_U007emarketing-0-5-0-0-85-220.png/512x512bb.jpg';
    data['publishedAt'] = this.publishedAt ?? DateTime.now().toIso8601String();
    data['content'] = this.content ?? 'Content not available';
    return data;
  }
}

class Source {
  String? id;
  String? name;

  Source({this.id, this.name});

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 'unknown';
    name = json['name'] ?? 'Unknown Source';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id ?? 'unknown';
    data['name'] = this.name ?? 'Unknown Source';
    return data;
  }
}
