// import 'package:company/models/usermodel.dart';
// import 'package:http/http.dart' as http;

// class AuthService {
//   Future<UserModel> authUser() async {
//     http.Response response = await http.post(
//         Uri.parse('http://192.168.137.1:8080/api/v1/auth/signin'),
//         body: jsonEncode(auth),
//         headers: {'Content-Type': 'application/json;charset=utf-8'});

//     if (!response.body.startsWith("{")) throw Exception('${response.body}');

//     RegisteredUser registeredUser =
//         RegisteredUser.fromJson(jsonDecode(response.body));
//     return registeredUser;
    
//   }
// }