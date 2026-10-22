import 'package:flutter/material.dart';
import 'package:newsapp/model/News.dart';
import 'package:newsapp/screens/DetailsNewsScreen.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key, required this.news});

  final News news;

  @override
  Widget build(BuildContext context) {
    final date = (news.pubDate ?? '').split(' ').first;
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => DetailsNewsScreen(news: news)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: news.imageUrl == null
                ? Center(
                  child: Container(
                                height: 200,
                                width: double.infinity,
                                color: Colors.grey.shade300,
                                child: const Icon(Icons.image_not_supported_rounded),
                              ),
                )
                : Center(
                  child: Image.network(
                                news.imageUrl!,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                  height: 100,
                  width: double.infinity,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.broken_image),
                                ),
                              ),
                ),
          ),
          const SizedBox(height: 8),
          Text(
            news.title ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            '${news.sourceName ?? ''}  •  $date',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}