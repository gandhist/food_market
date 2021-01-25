part of 'services.dart';

class UserServices {
  static Future<ApiReturnValue<User>> signIn(
      String email, String password) async {
    await Future.delayed(Duration(milliseconds: 500));
    return ApiReturnValue(value: mockUser);
    // return ApiReturnValue(message: "Wrong email or password");
  }

  // services baru untuk signup
  static Future<ApiReturnValue<User>> signUp(User user, String password,
      {File pictureFile, http.Client client}) async {
    // jika http client null maka inisialiasai ulang
    if (client == null) {
      client = http.Client();
    }
    String url = baseUrl + "register";
    print(url);
    var response = await client.post(url,
        headers: {
          "Content-Type": "application/json"
          // buat mapstring untuk body json nya
        },
        body: jsonEncode(<String, String>{
          'name': user.name,
          'email': user.email,
          'password': password,
          'password_confirmation': password,
          'address': user.address,
          'city': user.city,
          'houseNumber': user.houseNumber,
          'phoneNumber': user.phoneNumber
        }));
    // handle jika status code != 200
    if (response.statusCode != 200) {
      print(response.statusCode);
      return ApiReturnValue(message: 'something went wrong');
    }

    // jika status code 200
    var data = jsonDecode(response.body);

    // simpan token
    User.token = data['data']['access_token'];
    // assign variable value
    User value = data['data']['user'];

    // todo: upload PP
    // cek jika ada file pp
    if (pictureFile != null) {
      ApiReturnValue<String> result = await uploadProfilePicture(pictureFile);
      if (result.value != null) {
        value = value.copyWith(
            picturePath: "https://api-fm.niowcode.id/storage" + result.value);
      }
    }

    // return value api jika berhasil
    return ApiReturnValue(value: value);
  }

  // service untuk upload profile picture
  static Future<ApiReturnValue<String>> uploadProfilePicture(File pictureFile,
      {http.MultipartRequest request}) async {
    String url = baseUrl + "user/photo";
    var uri = Uri.parse(url);
    if (request == null) {
      request = http.MultipartRequest("POST", uri)
        ..headers["Content-Type"] = "application/json"
        ..headers["Authorization"] = "Bearer ${User.token}";
    }

    // buat multipart file
    var multipartFile =
        await http.MultipartFile.fromPath('file', pictureFile.path);
    request.files.add(multipartFile);

    var response = await request.send();

    // cek jika response berhasil
    if (response.statusCode == 200) {
      String resposeBody = await response.stream.bytesToString();
      var data = jsonDecode(resposeBody);
      String imagePath = data['data'][0];
      return ApiReturnValue(value: imagePath);
    } else {
      // jika gagal
      return ApiReturnValue(message: "Failed while uploading picture");
    }
  }
}
