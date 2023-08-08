import 'package:get/get.dart';
import 'package:transactions/views/transactions/data/transaction_repostiory.dart';

class BaseApiBindings extends GetConnect {
  static const String _tokenGenerator =
      'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyBFiEDfEaaK6lBtIdxLXspmxGux1TGsCmg';
  String? _token;

  String? get token => _token;


  Future<BaseApiBindings> _connectToApi() async {
    if (_token == null) await _getToken();
    httpClient.baseUrl =
        'http://asia-southeast1-marlo-bank-dev.cloudfunctions.net/api_dev/v2/';

    timeout = const Duration(seconds: 30);
    var headers = {'authToken': _token!};
    httpClient.addAuthenticator<dynamic>((request) async {
      request.headers.addAll(headers);
      return request;
    });

    return this;
  }

  _getToken() async {
    try {
      final body = {
        'email': 'geethumahi38+2@gmail.com',
        'password': 'Marlo@123',
        'returnSecureToken': true,
      };
      final response = await post(_tokenGenerator, body);
      _token = response.body['idToken'];
      print('your Token $_token');
    } catch (_) {
      return Exception('Token Generation Failed');
    }
  }

  @override
  Future<BaseApiBindings> onInit() async {
    super.onInit();
    return await _connectToApi();
  }
}

class InitialBinding extends Bindings {
  @override
  void dependencies() async {
    final baseApiService =
        await Get.putAsync(() => BaseApiBindings().onInit(), permanent: true);
    Get.put(TransactionRepository(baseApiService));
  }
}
