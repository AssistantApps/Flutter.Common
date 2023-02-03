import 'package:uuid/uuid.dart';

String getNewGuid() {
  Uuid uuid = const Uuid();
  return uuid.v4();
}
