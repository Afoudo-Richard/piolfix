import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';


class PoilfixApi {

  final String baseUrl = 'https://poilfixApi.com/api';

  Uri getUrl({required String url, Map<String, String>? extraParameters}) {
    return Uri.parse('$baseUrl/$url').replace(
      queryParameters: extraParameters,
    );
  }

  // fetch articles //
  // Future<Map<String, dynamic>> fetchArticles(
  //     {int page = 1, int limit = 20, int? topic_id}) async {
  //   try {
  //     final articlesResponse = await http.get(
  //       getUrl(
  //         url: 'articles',
  //         extraParameters: {
  //           'limit': limit.toString(),
  //           'order': 'asc',
  //           'page': page.toString(),
  //           'topic_id': topic_id != null ? topic_id.toString() : "",
  //         },
  //       ),
  //     );

  //     if (articlesResponse.statusCode == 200) {
  //       return json.decode(articlesResponse.body);
  //     } else {
  //       // throw ErrorGettingArticles(message: "Error Fetching articles");
  //     }
  //   } catch (e) {
  //     // throw ErrorGettingArticles(message: "Error Fetching articles");
  //   }
  // }
}
