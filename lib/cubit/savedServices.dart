import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newsapp/model/News.dart';

class SavedService {
  final _db = FirebaseFirestore.instance;

  String get _uid => FirebaseAuth.instance.currentUser?.uid ?? '';

  CollectionReference<Map<String, dynamic>> get _saved =>
      _db.collection('users').doc(_uid).collection('saved');

  Stream<List<News>> watchSaved() {
    return _saved
        .orderBy('savedAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => _fromDoc(d.data())).toList());
  }

  /// هل الخبر ده محفوظ؟
  Stream<bool> watchIsSaved(String articleId) {
    return _saved.doc(articleId).snapshots().map((d) => d.exists);
  }

  /// لو محفوظ يشيله، لو مش محفوظ يحفظه
  Future<void> toggle(News news) async {
    final id = news.articleId;
    if (id == null || id.isEmpty) return;

    final ref = _saved.doc(id);
    final snap = await ref.get();
    if (snap.exists) {
      await ref.delete();
    } else {
      await ref.set({
        'articleId': id,
        'title': news.title,
        'description': news.description,
        'link': news.link,
        'imageUrl': news.imageUrl,
        'sourceName': news.sourceName,
        'pubDate': news.pubDate,
        'savedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  News _fromDoc(Map<String, dynamic> d) => News(
    articleId: d['articleId'],
    title: d['title'],
    description: d['description'],
    link: d['link'],
    imageUrl: d['imageUrl'],
    sourceName: d['sourceName'],
    pubDate: d['pubDate'],
  );
}