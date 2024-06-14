// import 'dart:io';

// import 'package:appwrite/appwrite.dart';
// import 'package:appwrite/models.dart' as awm;
// import 'package:flutter/foundation.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:konekin_consumer_app/core/models/appwrite_credential.dart';
// import 'package:konekin_consumer_app/core/services/remote_config_service.dart';
// import 'package:path_provider/path_provider.dart';

// final appWriteProvider = Provider<AppwriteService>(
//   (ref) {
//     final remoteConfigService = ref.read(remoteConfigProvider);
//     return AppwriteService(
//       remoteConfigService: remoteConfigService,
//     );
//   },
// );

// class AppwriteService {
//   AppwriteService({
//     required RemoteConfigService remoteConfigService,
//   }) : _remoteConfigService = remoteConfigService;

//   final RemoteConfigService _remoteConfigService;

//   AppwriteCredential get _credential => _remoteConfigService.appwriteCredential;

//   bool _isInitialized = false;
//   late Client client;
//   Account? account;

//   Future<void> initialize() async {
//     client = Client();
//     client
//         .setEndpoint(_credential.endpointUrl)
//         .setProject(_credential.projectId)
//         .setSelfSigned();

//     account = Account(client);
//     _isInitialized = true;
//   }

//   Future<String?> uploadFile(String path) async {
//     if (!_isInitialized) return null;
//     final Storage storage = Storage(client);

//     InputFile file;

//     file = InputFile(
//       path: path,
//     );

//     final awm.File response = await storage.createFile(
//       bucketId: _credential.bucketId,
//       fileId: 'unique()',
//       file: file,
//       permissions: <String>[
//         Permission.read(Role.any()),
//       ],
//     );
//     return response.$id.isNotEmpty ? response.$id : null;
//   }

//   Future<File?> getFileView(String id) async {
//     if (!_isInitialized) return null;
//     final Storage storage = Storage(client);

//     final Uint8List imageInUnit8List = await storage.getFileView(
//       bucketId: _credential.bucketId,
//       fileId: id,
//     );
//     final Directory tempDir = await getTemporaryDirectory();
//     final File file = await File('${tempDir.path}/$id.png').create();
//     file.writeAsBytesSync(imageInUnit8List);
//     return file;
//   }

//   Future<File?> getFilePreviiew(String id) async {
//     if (!_isInitialized) return null;
//     final Storage storage = Storage(client);

//     final Uint8List imageInUnit8List = await storage.getFilePreview(
//       bucketId: _credential.bucketId,
//       fileId: id,
//     );
//     final Directory tempDir = await getTemporaryDirectory();
//     final File file = await File('${tempDir.path}/$id-preview.png').create();
//     file.writeAsBytesSync(imageInUnit8List);
//     return file;
//   }
// }
