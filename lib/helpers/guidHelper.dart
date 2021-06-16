import 'package:uuid/uuid.dart';

String getNewGuid() {
  Uuid uuid = Uuid();
  return uuid.v4();
}
