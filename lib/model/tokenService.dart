// import 'dart:convert';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:http/http.dart' as http;
// import 'package:Medaran/model/failure.dart';
// import 'package:Medaran/model/tokenModel.dart';

// class TokenService {
//   Future<Either<Failure, TokenModel>> getToken() async {
//     var apiUrl = dotenv.env['BASE_URL'] ?? '';

//     // Payload
//     var payload = {
//       "id": DateTime.now().millisecondsSinceEpoch, // Unique Id
//       "productName": "Mentos Marbels",
//       "price": 2500,
//       "quantity": 2
//     };

//     var payloadJson = jsonEncode(payload);

//     try {
//       var response = await http.post(
//         Uri.parse(apiUrl),
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//         },
//         body: payloadJson,
//       );

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         var jsonResponse = jsonDecode(response.body);
//         return right(TokenModel(token: jsonResponse['token']));
//       } else {
//         return left(ServerFailure(
//             data: response.body,
//             code: response.statusCode,
//             message: 'Unknown Error'));
//       }
//     } catch (e) {
//       return left(ServerFailure(
//           data: e.toString(), code: 400, message: 'Unknown Error'));
//     }
//   }
// }
