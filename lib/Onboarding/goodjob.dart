import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handyman/CustomerScreens/navigation.dart';
import 'package:handyman/Onboarding/login.dart';
import 'package:handyman/services/authservice.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:mongo_dart/mongo_dart.dart' show Db, GridFS;
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:cloudinary_client/cloudinary_client.dart';
// import 'package:cloudinary_client/models/CloudinaryResponse.dart';

class Goodjobscreen extends StatefulWidget {
  static const routeName = '/goodjob';
  @override
  State<Goodjobscreen> createState() => _GoodjobscreenState();
}

class _GoodjobscreenState extends State<Goodjobscreen> {
  // Uint8List propicDecoded;
  // Image provider;
  // Dio dio = Dio();
  // List<dynamic> propic;

  // getData() async {
  //   // setState(() {
  //   //    loading = true;  //make loading true to show progressindicator
  //   // });

  //   String url = "https://projecthandyman.herokuapp.com/getPropic";
  //   //don't use "http://localhost/" use local IP or actual live URL

  //   var response = await dio.get(url);

  //   propicDecoded = response.data['image']['data'];
  //   provider = Image.memory(propicDecoded);
  //   // print(provider);
  //   // propicDecoded = Base64Decoder().convert(response.data['image']['data']);

  //   // propics = response.data; //get JSON decoded data from response
  //   // _allUsers= apidata;
  //   if (response.statusCode == 200) {
  //     //fetch successful
  //     // if(apidata["error"]){ //Check if there is error given on JSON
  //     //     error = true;
  //     //     errmsg  = apidata["msg"]; //error message from JSON
  //     // }
  //   } else {
  //     // error = true;
  //     // errmsg = "Error while fetching data.";
  //   }

  //   // loading = false;
  //   setState(() {}); //refresh UI
  // }

  // @override
  // void initState() {
  //   getData();
  //   // print(propics); //fetching data
  //   super.initState();
  // }

  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     Response json = AuthService().getPropic('abc@gmail.com');
  //     propics = json.data;
  //     // if (val.data['success']) {
  //     // var js = jsonEncode(json);
  //     // Map<String, dynamic> userMap = jsonDecode(json);
  //     // var user = User.fromJson(userMap);
  //     print(propics);
  //     // String propic = val.data['msg'];
  //     // print(propic);
  //     // propicDecoded = Base64Decoder().convert(propic);
  //     // }
  //   });
  // }

  File _image;

  // Future<void> getImage() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.gallery);

  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }

  // void upload(File file) async {
  //   String fileName = file.path.split('/').last;
  //   // final bytes = await file.readAsBytes();
  //   // String encoded = base64Encode(bytes);

  //   AuthService()
  //       .uploadPropic(
  //           "C:/Users/Deelaka Pushpakumara/Pictures/Screenshots/Far Cry 5 Screenshot 2020.10.31 - 23.17.47.10.png",
  //           'fileName')
  //       .then((val) {
  //     if (val.data['success']) {
  //       print('success');
  //     }
  //   });
  // }
  String propicUrl;
  var pickedImage;
  void selectFile() async {
    final picker = ImagePicker();
    try {
      pickedImage = await picker.getImage(source: ImageSource.gallery);
      setState(() {
        if (pickedImage != null) {
          _image = File(pickedImage.path);
        } else {
          print('No image selected.');
        }
      });
    } on PlatformException catch (e, s) {
    } on Exception catch (e, s) {}
  }

  Future<CloudinaryResponse> prepareUpload() async {
    CloudinaryResponse response;
    if (pickedImage != null) {
      if (pickedImage.path != null) {
        response = await uploadFileOnCloudinary(
          filePath: pickedImage.path,
          resourceType: CloudinaryResourceType.Auto,
        );
        propicUrl = response.url;
        uploadFileDataOnMongo(data[3], propicUrl);
      }
    }
    return response;
  }

  Future<CloudinaryResponse> uploadFileOnCloudinary(
      {String filePath, CloudinaryResourceType resourceType}) async {
    CloudinaryResponse response;
    try {
      var cloudinary =
          CloudinaryPublic('projecthandyman', 'p5r8psil', cache: false);
      response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(filePath, resourceType: resourceType),
      );
    } on CloudinaryException catch (e, s) {
      print(e.message);
      print(e.request);
    }
    return response;
  }

  void uploadFileDataOnMongo(email, url) {
    AuthService().uploadPropic(email, url).then((val) {
      if (val.data['success']) {
        print('Successfully Uploaded');
      }
    });
  }

  // bool isloaded = false;
  // var result;

  // fetch() async {
  //   var response =
  //       await http.get('https://projecthandyman.herokuapp.com/image');
  //   result = jsonDecode(response.body);
  //   print(result[0]['image']);
  //   setState(() {
  //     isloaded = true;
  //   });
  // }

  String valueChooseGen, valueChooseDis;
  List genders = ['Male', 'Female'];
  List districts = [
    'Colombo',
    'Gampaha',
    'Kalutara',
    'Kandy',
    'Matale',
    'Nuwara Eliya',
    'Galle',
    'Matara',
    'Hambantota',
    'Jaffna',
    'Kilinochchi',
    'Mannar',
    'Vavuniya',
    'Mullativu',
    'Batticaloa',
    'Ampara',
    'Trincomalee',
    'Kurunegala',
    'Puttalam',
    'Anuradhapura',
    'Polonnaruwa',
    'Badulla',
    'Moneragala',
    'Ratnapura',
    'Kegalle'
  ];
  List data;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments as List;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 15, bottom: 30),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 0, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Good job',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).buttonColor,
                        fontSize: 40),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 5),
              child: Text(
                'Thank you for signing up for Handyman. To give you a personalised experience we would like to know more about you',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: CircleAvatar(
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () {
                          selectFile();
                        },
                        icon: const Icon(Icons.camera_alt, size: 30),
                      ),
                      backgroundColor: Colors.grey,
                      backgroundImage: _image == null
                          ? AssetImage('assets/images/Handyman.png')
                          : FileImage(_image),
                      radius: 50,
                    ),
                  ),
                ),
                Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                        child: Column(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15, top: 5, bottom: 5),
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5)),
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                  Icons.male,
                                  color: Theme.of(context).buttonColor,
                                )),
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Theme.of(context).buttonColor,
                                ),
                                hint: Text("Gender",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                dropdownColor:
                                    Theme.of(context).backgroundColor,
                                isExpanded: true,
                                style: TextStyle(color: Colors.white),
                                value: valueChooseGen,
                                onChanged: (newValue) {
                                  setState(() {
                                    valueChooseGen = newValue;
                                  });
                                },
                                items: genders.map((valueItem) {
                                  return DropdownMenuItem(
                                      value: valueItem, child: Text(valueItem));
                                }).toList(),
                              ),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15, top: 5, bottom: 5),
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5)),
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                  Icons.location_on,
                                  color: Theme.of(context).buttonColor,
                                )),
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Theme.of(context).buttonColor,
                                ),
                                hint: Text("District",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                dropdownColor:
                                    Theme.of(context).backgroundColor,
                                isExpanded: true,
                                style: TextStyle(color: Colors.white),
                                value: valueChooseDis,
                                onChanged: (newValue) {
                                  setState(() {
                                    valueChooseDis = newValue;
                                  });
                                },
                                items: districts.map((valueItem) {
                                  return DropdownMenuItem(
                                      value: valueItem, child: Text(valueItem));
                                }).toList(),
                              ),
                            )),
                      ],
                    ))),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    bottom: 10,
                    left: 15,
                    right: 15,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      var result = prepareUpload();
                      if (result != null) {}

                      data.addAll([valueChooseGen, valueChooseDis]);
                      AuthService().addUserCustomer(data).then((val) {
                        if (val.data['success']) {
                          Navigator.of(context)
                              .pushNamed(LoginScreen.routeName);

                          Fluttertoast.showToast(
                              msg: 'Successfully Registered',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Theme.of(context).buttonColor,
                              textColor: Theme.of(context).shadowColor,
                              fontSize: 16.0);
                        }
                      });
                    },
                    child: Container(
                      height: 46,
                      width: width,
                      decoration: BoxDecoration(
                        color: Theme.of(context).buttonColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text('Let\'s Go',
                            style: TextStyle(
                                color: Theme.of(context).backgroundColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
