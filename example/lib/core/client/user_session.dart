import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';

import '../constants/storage_keys.dart';


abstract class IUserSession{
}

@Singleton(as: IUserSession)
class UserSession extends IUserSession{




}