import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

class AppwriteClientHelper {
  static final Logger _logger = Logger('AppwriteClientHelper');

  static final AppwriteClientHelper _instance =
      AppwriteClientHelper._internal();

  factory AppwriteClientHelper() {
    return _instance;
  }

  AppwriteClientHelper._internal();

  static void ensureInitialized(String id) {
    _logger.info('Initializing Appwrite client...');
    endpoint = Uri.parse('https://cloud.appwrite.io/v1');
    projectId = id;
    _instance._initClient(
      endpoint.toString(),
      projectId,
    );

    _instance._account = Account(_instance._client);

    _logger.info('Appwrite client initialized.');
  }

  late Client _client;
  late Account _account;

  void _initClient(String endpoint, String project) {
    _client = Client();
    _client
      ..setEndpoint(endpoint)
      ..setProject(project);

    // if (kDebugMode) {
    //   _client.setSelfSigned();
    // }
  }

  static late Uri endpoint;
  static late String projectId;

  String _jwtToken = '';

  Client get client => _client;
  Account get account => _account;

  // get instance
  static AppwriteClientHelper get instance => _instance;

  Future<String> jwtToken() async {
    if (_jwtToken.isEmpty) {
      _jwtToken = await _generateJWT();
    } else {}

    return _jwtToken;
  }

  static FutureOr<Uri> getFileUrl({
    required String bucketId,
    required String fileId,
  }) async {
    return Uri.https(
      endpoint.host,
      '/v1/storage/buckets/$bucketId/files/$fileId/view',
      {'project': projectId},
    );
  }

  static FutureOr<Map<Uri, String>> getFilePrivateUrl({
    required String bucketId,
    required String fileId,
  }) async {
    final jwtToken = await instance.jwtToken();
    return {
      Uri.https(
        endpoint.host,
        '/v1/storage/buckets/$bucketId/files/$fileId/view',
        {'project': projectId},
      ): jwtToken
    };
  }

  Future<String> _generateJWT() async {
    _logger.warning('JWT token is empty');
    _logger.info('Creating JWT token...');
    final account = Account(_client);

    final jwtToken = await account.createJWT();
    _logger.info('JWT token created.');
    return jwtToken.jwt;
  }
}
