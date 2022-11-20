import 'dart:convert';

UrlModel urlModelFromJson(String str) => UrlModel.fromJson(json.decode(str));

String urlModelToJson(UrlModel data) => json.encode(data.toJson());

class UrlModel {
  UrlModel({
    required this.meta,
    required this.url,
  });

  final Meta meta;
  final Url url;

  factory UrlModel.fromJson(Map<String, dynamic> json) => UrlModel(
        meta: Meta.fromJson(json['meta']),
        url: Url.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'meta': meta,
        'data': url,
      };
}

class Url {
  Url({
    required this.id,
    required this.originUrl,
    required this.shortUrl,
  });

  final int id;
  final String originUrl;
  final String shortUrl;

  factory Url.fromJson(Map<String, dynamic> json) => Url(
        id: json['id'] ?? -1,
        originUrl: json['origin_url'] ?? '',
        shortUrl: json['short_url'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'origin_url': originUrl,
        'short_url': shortUrl,
      };
}

class Meta {
  Meta({
    required this.message,
    required this.code,
    required this.status,
  });

  final String message;
  final int code;
  final String status;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        message: json['message'] ?? '',
        code: json['code'] ?? -1,
        status: json['status'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'code': code,
        'status': status,
      };
}
