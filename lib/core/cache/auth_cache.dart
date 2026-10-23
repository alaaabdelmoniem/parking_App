import 'dart:developer';
import 'package:parking/core/cache/cache_helper.dart';
import 'package:parking/core/cache/cache_keys.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthCache {
  static Future<void> cacheUser(User user, {String? fallbackEmail}) async {
    await CacheHelper.setValue(key: CacheKeys.uId, value: user.id);
    await CacheHelper.setValue(
      key: CacheKeys.userInfoList,
      value: [
        '${user.userMetadata?[CacheKeys.usernameFieldInSupabase] ?? user.userMetadata?['name']}',
        '${user.email ?? fallbackEmail}',
      ],
    );
    log(
      '${user.email ?? ''}  ${user.userMetadata?[CacheKeys.usernameFieldInSupabase]}',
    );
  }

  static Future<void> removeUser() async {
    await CacheHelper.removeValue(key: CacheKeys.uId);
    await CacheHelper.removeValue(key: CacheKeys.userInfoList);
    log('user cache cleared');
  }
}
