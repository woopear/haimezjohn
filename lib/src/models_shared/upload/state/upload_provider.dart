import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haimezjohn/src/models_shared/upload/state/upload_state.dart';

/// state de la class uploadFile
final uploadFileChange = ChangeNotifierProvider((ref) => UploadFile());