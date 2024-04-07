class Api {
  static const String _apiUrl = 'coffeeshop.academy.effective.band';
  static const String _apiPath = '/api/v1/';

  Uri _buildUri({
    required String endpoint,
    required Map<String, dynamic> Function() parameters,
  }) {
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
      parameters: () => query(page: page, limit: limit),
    );
  }

  Uri categories({int? page, int? limit}) {
    return _buildUri(
      endpoint: 'products/categories',
      parameters: () => query(page: page, limit: limit),
    );
  }

  Uri cards({int? page, int? limit, int? category}) {
    return _buildUri(
      endpoint: 'products',
      parameters: () => query(
        page: page,
        limit: limit,
        category: category,
      ),
    );
  }

  Uri card(int id) {
    return _buildUri(
      endpoint: 'products/$id',
      parameters: () => {},
    );
  }

  Uri order() {
    return _buildUri(
      endpoint: 'orders',
      parameters: () => {},
    );
  }

  Map<String, dynamic> query({int? page, int? limit, int? category}) {
    var par = {'page': page ?? 0, 'limit': limit ?? 25};
    if (category != null) {
      par.addAll({'category': category});
    }
    return par.map(
      (key, value) => MapEntry(
        key,
        value.toString(),
      ),
    );
  }
}
