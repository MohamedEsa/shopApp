import '../../modules/shop_App/login/shop_login_screen.dart';
import '../network/local/cache_helper.dart';

import 'components.dart';

String token = '';
void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    navigateAndFinish(context, ShopLoginScreen());
  });
}

String? uId = '';
