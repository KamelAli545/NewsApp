import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:newsapp/cubit/savedServices.dart';
import 'package:newsapp/model/News.dart';
import 'package:newsapp/screens/DetailsNewsScreen.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = SavedService();

    return Scaffold(
      backgroundColor:  Colors.white,
      appBar: AppBar(
        backgroundColor:  Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('Saved', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: StreamBuilder<List<News>>(
        stream: service.watchSaved(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(
              child: Text(
                '${snap.error}',
                style: const TextStyle(color: Colors.white),
              ),
            );
          }
          final newsList = snap.data ?? [];
          if (newsList.isEmpty) {
            return Center(
              child: Lottie.asset("assets/animations/not found.json"),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: newsList.length,
            itemBuilder: (context, i) {
              final item = newsList[i];
              final imageUrl = item.imageUrl;

              return Card(
                color: Colors.blue,
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(8),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: (imageUrl == null || imageUrl.isEmpty)
                        ? const SizedBox(
                      width: 56,
                      height: 80,
                      child: Icon(Icons.article, color: Colors.white54),
                    )
                        : Image.network(
                      imageUrl,
                      width: 56,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const SizedBox(
                        width: 56,
                        height: 80,
                        child: Icon(Icons.broken_image,
                            color: Colors.white54),
                      ),
                    ),
                  ),
                  title: Text(
                    item.title ?? '',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    '${item.sourceName ?? '-'}  •  ${item.pubDate ?? '-'}',
                    style: const TextStyle(color: Colors.white54),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline,
                        color: Colors.black),
                    onPressed: () => service.toggle(item),
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailsNewsScreen(news: item),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}