import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/NewsCard.dart';
import 'package:newsapp/cubit/news_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/widgets/categoryRow.dart';
import 'package:newsapp/widgets/drawer.dart';
import 'package:newsapp/widgets/newsTab.dart';


class HomesScreen extends StatefulWidget {
  const HomesScreen({super.key});

  @override
  State<HomesScreen> createState() => _HomesScreenState();
}

class _HomesScreenState extends State<HomesScreen> {
  final searchController = TextEditingController();
  String searchQuery = '';
  int _selectedTab=0;


  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _selectTab(int index) {
    searchController.clear();
    setState(() {
      _selectedTab = index;
      searchQuery = '';
    });
    context.read<NewsCubit>().loadCategory(newsTabs[index].category);  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("Newsify",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            color: Colors.blue
          ),),
        actions: [
          IconButton(onPressed: () {}
              , icon: Icon(Icons.notifications_outlined))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              style: TextStyle(color: Colors.black),
              controller: searchController,
              onChanged: (value) {
                setState(() => searchQuery = value);
                context.read<NewsCubit>().searchNews(value);
              },
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search),
                hintText: "Search New",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
              ),
            ),
          ),
          CategoryRow(
            selected: _selectedTab,
            onTap: _selectTab,
          ),
            SizedBox(height: 10,),
          Expanded(child:
          BlocBuilder<NewsCubit, NewsState>(
            builder: (context, state) {
              if (state is NewsLoading) {
                return Center(child: CircularProgressIndicator(),);
              }
              if (state is NewsError) {
                return Center(
                  child: Text(state.message),
                );
              }
              if (state is NewsSuccess) {
                if (state.news.isEmpty) {
                  return Center(child: Text("No News Found"),);
                }
                return SizedBox(
                  height: 200,
                  child: ListView.separated(
                    itemCount: state.news.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(
                          width: 16,),
                    itemBuilder: (context, index) =>
                        NewsCard(news: state.news[index]),

                  ),
                );
              }
              return SizedBox.shrink();
            }
          )
          )
        ],
      ),
    );
  }
}
