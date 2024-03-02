import 'package:naqla/core/type_definitions.dart';

import '../../../auth/data/model/auth_model.dart';

abstract class ProfileRepository {
  FutureResult<User> getPersonalInfo();
}
