import 'package:flutter/material.dart';
import '../../Model/article_model.dart';

class NewsCard extends StatelessWidget {
  final ArticleModel article; // The ArticleModel object for each news item

  const NewsCard({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime publishedDate = DateTime.now(); // Default to now if parsing fails

    // Parse the publishedAt date string, handle any exceptions
    if (article.publishedAt != null) {
      try {
        publishedDate = DateTime.parse(article.publishedAt!);
      } catch (e) {
        print('Error parsing publishedAt: $e');
      }
    }

    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // News Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // News Source
                Text(
                  article.source?.name ?? "Unknown Source",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 5),

                // News Description or Title
                Text(
                  article.description ?? 'No description available',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 5),

                // Time of publication
                Text(
                  "${DateTime.now().difference(publishedDate).inMinutes} min ago",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),

          // News Image
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              article.urlToImage ?? 'https://via.placeholder.com/150', // Placeholder image if no image URL is available
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
