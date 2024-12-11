import 'package:app/model/article.dart';
import 'package:app/services/api_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Articles'),
      ),
      body: FutureBuilder<List<ArticleModel>>(
        future: ApiService().fetchArticles(),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final articles = snapshot.data!;

            return ListView.builder(
              itemCount: articles.length, // Safely handle null data
              itemBuilder: (context, index) {
                final article = articles[index];
                return ListTile(
                  leading: article.urlToImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            // height: double.infinity
                            width: MediaQuery.of(context).size.width / 3,
                            child: Image.network(
                              article.urlToImage!,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Image.network(
                              'https://via.placeholder.com/150',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                  title: Text(article.title ?? 'No Title'),
                  subtitle: Text(article.description ?? 'No Description'),
                );
              },
            );
          } else {
            return const Center(child: Text('No articles available.'));
          }
        },
      ),
    );
  }
}
