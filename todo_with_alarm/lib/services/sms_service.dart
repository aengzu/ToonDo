import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo_with_alarm/constants.dart';

class SmsService {
  final String baseUrl = Constants.baseUrl;

  Future<String> sendSmsCode(String phoneNumber) async {
    print(phoneNumber);
    final url = Uri.parse('$baseUrl/sms/send-code?phoneNumber=$phoneNumber');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return "인증번호가 전송되었습니다.";
    } else {
      throw Exception("SMS 전송 실패");
    }
  }

  Future<String> verifySmsCode(String phoneNumber, String code) async {
    final url = Uri.parse('$baseUrl/sms/verify-code?phoneNumber=$phoneNumber&code=$code');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    );
    if (response.statusCode == 200) {
      return "본인인증 성공";
    } else {
      throw Exception("인증번호가 일치하지 않습니다.");
    }
  }
}
