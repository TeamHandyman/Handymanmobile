import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  Dio dio = new Dio();

  loginCustomer(email, password) async {
    try {
      return await dio.post(
          'https://projecthandyman.herokuapp.com/loginCustomer',
          data: {"email": email, "password": password, "userType": "customer"},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  checkEmailAvailability(email) async {
    try {
      return await dio.post(
          'https://projecthandyman.herokuapp.com/checkEmailAvailability',
          data: {"email": email});
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  checkPhoneAvailability(phone) async {
    try {
      return await dio.post(
          'https://projecthandyman.herokuapp.com/checkPhoneAvailability',
          data: {"phone": phone});
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  addUserCustomer(data) async {
    try {
      return await dio.post('https://projecthandyman.herokuapp.com/addCustomer',
          data: {
            "fName": data[3],
            "lName": data[4],
            "phone": data[0],
            "email": data[1],
            "password": data[2],
            "gender": data[5],
            "district": data[6],
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  postJobCustomer(data) async {
    try {
      return await dio.post(
          'https://projecthandyman.herokuapp.com/postJobCustomer',
          data: {
            "email": data[0],
            "title": data[1],
            "workerType": data[2],
            "description": data[3],
            "date": data[4],
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  uploadPropic(email, url) async {
    try {
      return await dio.post(
        'https://projecthandyman.herokuapp.com/uploadProPic',
        data: {
          "email": email,
          "url": url,
        },
      );
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  uploadCustJobImage(email, url) async {
    try {
      return await dio.post(
        'https://projecthandyman.herokuapp.com/uploadCustJobImage',
        data: {
          "email": email,
          "url": url,
        },
      );
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  getEmail(token) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      return await dio.get('https://projecthandyman.herokuapp.com/getEmail');
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  // getPropic(email) async {
  //   try {
  //     return await dio
  //         .get('https://projecthandyman.herokuapp.com/getPropic?email=$email');
  //   } on DioError catch (e) {
  //     Fluttertoast.showToast(
  //         msg: e.response.data['msg'],
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         backgroundColor: Colors.red,
  //         textColor: Colors.white,
  //         fontSize: 16.0);
  //   }
  // }
}
