enum NewsCategory { general, business, technology, sports, health, entertainment }

class NewsTab {
  final String title;
  final NewsCategory category;

  const NewsTab(this.title, this.category);
}

const List<NewsTab> newsTabs = [
  NewsTab('General', NewsCategory.general),
  NewsTab('Business', NewsCategory.business),
  NewsTab('Technology', NewsCategory.technology),
  NewsTab('Sports', NewsCategory.sports),
  NewsTab('Health', NewsCategory.health),
  NewsTab('Entertainment', NewsCategory.entertainment),
];