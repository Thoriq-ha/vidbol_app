// To parse this JSON data, do
//
//     final footballData = footballDataFromJson(jsonString);

import 'dart:convert';

FootballData footballDataFromJson(String str) => FootballData.fromJson(json.decode(str));

String footballDataToJson(FootballData data) => json.encode(data.toJson());

class FootballData {
    FootballData({
        required this.title,
        required this.competition,
        required this.matchviewUrl,
        required this.competitionUrl,
        required this.thumbnail,
        required this.date,
        required this.videos,
    });

    String title;
    String competition;
    String matchviewUrl;
    String competitionUrl;
    String thumbnail;
    String date;
    List<Video> videos;

    factory FootballData.fromJson(Map<String, dynamic> json) => FootballData(
        title: json["title"],
        competition: json["competition"],
        matchviewUrl: json["matchviewUrl"],
        competitionUrl: json["competitionUrl"],
        thumbnail: json["thumbnail"],
        date: json["date"],
        videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "competition": competition,
        "matchviewUrl": matchviewUrl,
        "competitionUrl": competitionUrl,
        "thumbnail": thumbnail,
        "date": date,
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
    };
}

class Video {
    Video({
        required this.title,
        required this.embed,
    });

    String title;
    String embed;

    factory Video.fromJson(Map<String, dynamic> json) => Video(
        title: json["title"],
        embed: json["embed"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "embed": embed,
    };
}
