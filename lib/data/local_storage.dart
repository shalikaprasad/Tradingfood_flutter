import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final LocalStorage cartPriceStorage = new LocalStorage('cart');

asyncFunc() async { // Async func to handle Futures easier; or use Future.then
  SharedPreferences storage = await SharedPreferences.getInstance();
}

saveDataLocal(String id, String value) async {
  SharedPreferences storage = await SharedPreferences.getInstance();
  storage.setString(id, value);
}

Future<double> getDataLocal(String userId) async {
  SharedPreferences storage = await SharedPreferences.getInstance();
  return storage.getDouble(userId) ?? 0;
}

final LocalStorage tokenStorage = new LocalStorage('token');
final LocalStorage customerStorage = new LocalStorage('customer');