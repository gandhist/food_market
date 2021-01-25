part of 'models.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String email;
  final String address;
  final String houseNumber;
  final String phoneNumber;
  final String city;
  final String picturePath;
  static String token;

  User(
      {this.id,
      this.name,
      this.email,
      this.address,
      this.houseNumber,
      this.phoneNumber,
      this.city,
      this.picturePath});

  // handle jika data kosong
  User copyWith(
          {int id,
          String name,
          String email,
          String address,
          String houseNumber,
          String phoneNumber,
          String city,
          String picturePath}) =>
      User(
          // jika id kosong maka akan mengambil id yang ada di method ini
          id: id ?? this.id,
          name: name ?? this.name,
          email: email ?? this.email,
          address: address ?? this.address,
          houseNumber: houseNumber ?? this.houseNumber,
          phoneNumber: phoneNumber ?? this.phoneNumber,
          city: city ?? this.city,
          picturePath: picturePath ?? this.picturePath);

  @override
  // TODO: implement props
  // properti yang akan di bandingkan
  List<Object> get props =>
      [id, name, email, address, houseNumber, phoneNumber, city, picturePath];
}

// mock user
User mockUser = User(
    id: 1,
    name: 'Park Chae-Young',
    address: 'jl jendral sudirman',
    houseNumber: '123',
    phoneNumber: '08123456789',
    email: 'jonsnow@gmail.com',
    city: 'Jakarta',
    picturePath: 'https://wallpapercave.com/wp/wp3154727.jpg');
