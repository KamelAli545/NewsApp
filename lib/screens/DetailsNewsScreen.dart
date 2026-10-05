import 'package:flutter/material.dart';
import 'package:newsapp/model/News.dart';

class DetailsNewsScreen extends StatelessWidget {
  const DetailsNewsScreen({super.key, required this.news});

  final News news;

  @override
  Widget build(BuildContext context) {
    final date = (news.pubDate ?? '').split(' ').first;

    return Scaffold(
      appBar: AppBar(title:
      Text(
          news.sourceName ?? 'News')
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: news.imageUrl == null
                  ? Container(
                height: 220,
                width: double.infinity,
                color: Colors.grey.shade300,
                child: const Icon(Icons.image_not_supported_rounded),
              )
                  : Image.network(
                news.imageUrl!,
                height: 220,
                width: 220,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 220,
                  width: double.infinity,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.broken_image),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              news.title ?? '',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${news.sourceName ?? ''}  •  $date',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Text(
              (news.description == null || news.description!.isEmpty)
                  ? 'No description available.'
                  : news.description!,
              style: const TextStyle(fontSize: 16, height: 1.6),
            ),
          ],
        ),
      ),
    );
  }
}