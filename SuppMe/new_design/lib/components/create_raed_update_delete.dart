// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class Crud {
//   getRequest(String url) async {
//     try {
//       var response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         var responsebody = jsonDecode(response.body);
//         return responsebody;
//       } else {
//         print("error ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Error catch $e");
//     }
//   }

//   postRequest(String uri, Map data) async {
//     try {
//       var response = await http.post(Uri.parse(uri), body: data);
//       if (response.statusCode == 200) {
//         var responsebody = jsonDecode(response.body);
//         return responsebody;
//       } else {
//         print("error ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Error catch $e");
//     }
//   }
// }
