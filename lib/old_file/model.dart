import 'package:html/parser.dart' show parseFragment;

import 'package:html_unescape/html_unescape.dart';

class Product {
  final int id;
  final String name;
  final String imgLink;
  final double price;

  Product({required this.id, required this.name, required this.imgLink, required this.price});
}
class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}



class Countries {
  String? abbreviation;
  String? capital;
  String? currency;
  String? name;
  String? phone;
  int? population;
  Media? media;
  int? id;

  Countries({this.abbreviation,
      this.capital,
      this.currency,
      this.name,
      this.phone,
      this.population,
      this.media,
      this.id});

  Countries.fromJson(Map<String, dynamic> json) {
    abbreviation = json['abbreviation'];
    capital = json['capital'];
    currency = json['currency'];
    name = json['name'];
    phone = json['phone'];
    population = json['population'];
    media = json['media'] != null ? Media.fromJson(json['media']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['abbreviation'] = this.abbreviation;
    data['capital'] = this.capital;
    data['currency'] = this.currency;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['population'] = this.population;
    if (this.media != null) {
      data['media'] = this.media!.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}

class Media {
  String? flag;
  String? emblem;
  String? orthographic;

  Media({this.flag, this.emblem, this.orthographic});

  Media.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    emblem = json['emblem'];
    orthographic = json['orthographic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flag'] = this.flag;
    data['emblem'] = this.emblem;
    data['orthographic'] = this.orthographic;
    return data;
  }
}


class ImageModel {
  String path;

  ImageModel({required this.path});
}

class Country {
  final String code;
  final String name;
  final String region;

  Country({required this.code, required this.name, required this.region});

  factory Country.fromJson(String code, Map<String, dynamic> json) {
    return Country(
      code: code,
      name: json['country'],
      region: json['region'],
    );
  }
}

class CountryResponse {
  final String? status;
  final int? statusCode;
  final String? version;
  final String? access;
  final int? total;
  final int? offset;
  final int? limit;
  final Map<String, Country>? countries;

  CountryResponse({
    this.status,
    this.statusCode,
    this.version,
    this.access,
    this.total,
    this.offset,
    this.limit,
    this.countries,
  });

  factory CountryResponse.fromJson(Map<String, dynamic> json) {
    Map<String, Country> countryMap = {};
    (json['data'] as Map<String, dynamic>).forEach((key, value) {
      countryMap[key] = Country.fromJson(key, value);
    });

    return CountryResponse(
      status: json['status'],
      statusCode: json['status-code'],
      version: json['version'],
      access: json['access'],
      total: json['total'],
      offset: json['offset'],
      limit: json['limit'],
      countries: countryMap,
    );
  }
}

class PostsModel {
  int? userId;
  int? id;
  String? title;
  String? body;

  PostsModel({this.userId, this.id, this.title, this.body});

  PostsModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}

class ApiModel1 {
  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<Data>? data;
  Support? support;

  ApiModel1(
      {this.page,
      this.perPage,
      this.total,
      this.totalPages,
      this.data,
      this.support});

  ApiModel1.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    total = json['total'];
    totalPages = json['total_pages'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    support =
        json['support'] != null ? new Support.fromJson(json['support']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['per_page'] = this.perPage;
    data['total'] = this.total;
    data['total_pages'] = this.totalPages;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.support != null) {
      data['support'] = this.support!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  Data({this.id, this.email, this.firstName, this.lastName, this.avatar});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['avatar'] = this.avatar;
    return data;
  }
}

class Support {
  String? url;
  String? text;

  Support({this.url, this.text});

  Support.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['text'] = this.text;
    return data;
  }
}

class NewsModel {
  String? articleId;
  String? title;
  String? link;
  String? keywords;
  List<String>? creator;
  String? videoUrl;
  String? description;
  String? content;
  String? pubDate;
  String? imageUrl;
  String? sourceId;
  int? sourcePriority;
  String? sourceName;
  String? sourceUrl;
  String? sourceIcon;
  String? language;
  List<String>? country;
  List<String>? category;
  String? aiTag;
  String? sentiment;
  String? sentimentStats;
  String? aiRegion;
  String? aiOrg;
  bool? duplicate;

  NewsModel(
      {this.articleId,
      this.title,
      this.link,
      this.keywords,
      this.creator,
      this.videoUrl,
      this.description,
      this.content,
      this.pubDate,
      this.imageUrl,
      this.sourceId,
      this.sourcePriority,
      this.sourceName,
      this.sourceUrl,
      this.sourceIcon,
      this.language,
      this.country,
      this.category,
      this.aiTag,
      this.sentiment,
      this.sentimentStats,
      this.aiRegion,
      this.aiOrg,
      this.duplicate});

  NewsModel.fromJson(Map<String, dynamic> json) {
    articleId = json['article_id'];
    title = json['title'];
    link = json['link'];
    keywords = json['keywords'];
    creator = json['creator'][0];
    videoUrl = json['video_url'];
    description = json['description'];
    content = json['content'];
    pubDate = json['pubDate'];
    imageUrl = json['image_url'];
    sourceId = json['source_id'];
    sourcePriority = json['source_priority'];
    sourceName = json['source_name'];
    sourceUrl = json['source_url'];
    sourceIcon = json['source_icon'];
    language = json['language'];
    country = json['country'][0];
    category = json['category'][0];
    aiTag = json['ai_tag'];
    sentiment = json['sentiment'];
    sentimentStats = json['sentiment_stats'];
    aiRegion = json['ai_region'];
    aiOrg = json['ai_org'];
    duplicate = json['duplicate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['article_id'] = this.articleId;
    data['title'] = this.title;
    data['link'] = this.link;
    data['keywords'] = this.keywords;
    data['creator'] = this.creator;
    data['video_url'] = this.videoUrl;
    data['description'] = this.description;
    data['content'] = this.content;
    data['pubDate'] = this.pubDate;
    data['image_url'] = this.imageUrl;
    data['source_id'] = this.sourceId;
    data['source_priority'] = this.sourcePriority;
    data['source_name'] = this.sourceName;
    data['source_url'] = this.sourceUrl;
    data['source_icon'] = this.sourceIcon;
    data['language'] = this.language;
    data['country'] = this.country;
    data['category'] = this.category;
    data['ai_tag'] = this.aiTag;
    data['sentiment'] = this.sentiment;
    data['sentiment_stats'] = this.sentimentStats;
    data['ai_region'] = this.aiRegion;
    data['ai_org'] = this.aiOrg;
    data['duplicate'] = this.duplicate;
    return data;
  }
}
