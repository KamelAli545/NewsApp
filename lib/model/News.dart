class News {
  News({
      this.articleId, 
      this.link, 
      this.title, 
      this.description, 
      this.content, 
      this.keywords, 
      this.creator, 
      this.language, 
      this.country, 
      this.category, 
      this.datatype, 
      this.pubDate, 
      this.pubDateTZ, 
      this.fetchedAt, 
      this.imageUrl, 
      this.videoUrl, 
      this.sourceId, 
      this.sourceName, 
      this.sourcePriority, 
      this.sourceUrl, 
      this.sourceIcon, 
      this.sentiment, 
      this.sentimentStats, 
      this.aiTag, 
      this.aiRegion, 
      this.aiOrg, 
      this.aiSummary, 
      this.duplicate,});

  News.fromJson(dynamic json) {
    articleId = json['article_id'];
    link = json['link'];
    title = json['title'];
    description = json['description'];
    content = json['content'];
    keywords = json['keywords'];
    creator = json['creator'] != null ? json['creator'].cast<String>() : [];
    language = json['language'];
    country = json['country'] != null ? json['country'].cast<String>() : [];
    category = json['category'] != null ? json['category'].cast<String>() : [];
    datatype = json['datatype'];
    pubDate = json['pubDate'];
    pubDateTZ = json['pubDateTZ'];
    fetchedAt = json['fetched_at'];
    imageUrl = json['image_url'];
    videoUrl = json['video_url'];
    sourceId = json['source_id'];
    sourceName = json['source_name'];
    sourcePriority = json['source_priority'];
    sourceUrl = json['source_url'];
    sourceIcon = json['source_icon'];
    sentiment = json['sentiment'];
    sentimentStats = json['sentiment_stats'];
    aiTag = json['ai_tag'];
    aiRegion = json['ai_region'];
    aiOrg = json['ai_org'];
    aiSummary = json['ai_summary'];
    duplicate = json['duplicate'];
  }
  String? articleId;
  String? link;
  String? title;
  String? description;
  String? content;
  dynamic keywords;
  List<String>? creator;
  String? language;
  List<String>? country;
  List<String>? category;
  String? datatype;
  String? pubDate;
  String? pubDateTZ;
  String? fetchedAt;
  String? imageUrl;
  dynamic videoUrl;
  String? sourceId;
  String? sourceName;
  int? sourcePriority;
  String? sourceUrl;
  String? sourceIcon;
  String? sentiment;
  String? sentimentStats;
  String? aiTag;
  String? aiRegion;
  String? aiOrg;
  String? aiSummary;
  bool? duplicate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['article_id'] = articleId;
    map['link'] = link;
    map['title'] = title;
    map['description'] = description;
    map['content'] = content;
    map['keywords'] = keywords;
    map['creator'] = creator;
    map['language'] = language;
    map['country'] = country;
    map['category'] = category;
    map['datatype'] = datatype;
    map['pubDate'] = pubDate;
    map['pubDateTZ'] = pubDateTZ;
    map['fetched_at'] = fetchedAt;
    map['image_url'] = imageUrl;
    map['video_url'] = videoUrl;
    map['source_id'] = sourceId;
    map['source_name'] = sourceName;
    map['source_priority'] = sourcePriority;
    map['source_url'] = sourceUrl;
    map['source_icon'] = sourceIcon;
    map['sentiment'] = sentiment;
    map['sentiment_stats'] = sentimentStats;
    map['ai_tag'] = aiTag;
    map['ai_region'] = aiRegion;
    map['ai_org'] = aiOrg;
    map['ai_summary'] = aiSummary;
    map['duplicate'] = duplicate;
    return map;
  }

}