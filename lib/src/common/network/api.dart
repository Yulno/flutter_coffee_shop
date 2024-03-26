class Api {
  static const String _apiUrl = 'coffeeshop.academy.effective.band';
  static const String _apiPath = 'coffeeshop.academy.effective.band/api/v1/';

  Uri _buildUri(
      {required String endpoint,
      required Map<String, dynamic> Function() parameters}) {
    return Uri(
      scheme: "https",
      host: _apiUrl,
      path: "$_apiPath$endpoint",
      queryParameters: parameters(),
    );
  }

  Uri locations({int? page, int? limit}) {
    return _buildUri(
      endpoint: 'locations',
      parameters: () => query(page, limit),
    );
  }

  Uri categories({int? page, int? limit}) {
    return _buildUri(
      endpoint: 'cards/categories',
      parameters: () => query(page, limit),
    );
  }

  Uri cards({int? page, int? limit}) {
    return _buildUri(
      endpoint: 'cards',
      parameters: () => query(page, limit),
    );
  }

  Uri card(int id) {
    return _buildUri(
      endpoint: 'cards/$id',
      parameters: () => {},
    );
  }

  Uri order() {
    return _buildUri(
      endpoint: 'orders',
      parameters: () => {},
    );
  }

  Map<String, dynamic> query(int? page, int? limit) {
    return {'page': page ?? 0, 'limit': limit ?? 25};
  }
}
