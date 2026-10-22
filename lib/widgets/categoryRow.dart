import 'package:flutter/material.dart';
import 'package:newsapp/widgets/newsTab.dart';

const _accent = Colors.black;
const _promoPink = Colors.blue;

class CategoryRow extends StatelessWidget {
  const CategoryRow({
    super.key,
    required this.selected,
    required this.onTap,
  });

  final int selected;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 116,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        scrollDirection: Axis.horizontal,
        itemCount: newsTabs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 35),
        itemBuilder: (context, i) {
          final tab = newsTabs[i];
          final isSelected = i == selected;

          return GestureDetector(
            onTap: () => onTap(i),
            child: SizedBox(
              width: 72,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CategoryAvatar(tab: tab, isSelected: isSelected),
                  const SizedBox(height: 6),
                  Text(
                    tab.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CategoryAvatar extends StatelessWidget {
  const CategoryAvatar({
    super.key,
    required this.tab,
    required this.isSelected,
  });

  final NewsTab tab;
  final bool isSelected;

  IconData get _icon {
    switch (tab.category) {
      case NewsCategory.general:
        return Icons.public;
      case NewsCategory.business:
        return Icons.business_center;
      case NewsCategory.technology:
        return Icons.memory;
      case NewsCategory.sports:
        return Icons.sports_soccer;
      case NewsCategory.health:
        return Icons.health_and_safety;
      case NewsCategory.entertainment:
        return Icons.theaters;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? _accent : Colors.transparent,
          width: 2,
        ),
      ),
      child: CircleAvatar(
        radius: 30,
        backgroundColor: _promoPink,
        child: Icon(_icon, color: _accent, size: 28),
      ),
    );
  }
}