part of 'services.dart';

class UserServices {
  static CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');
  static Future<void> updateUser(RegistrationData registrationData) async {
    _userCollection.doc(registrationData.idUser).set({
      'email': registrationData.email,
      'nama_depan': registrationData.namaDepan,
      'nama_belakang': registrationData.namaBelakang,
      'selectedGenres': registrationData.selectedGenres,
      'profilePicture': registrationData.profileImage ?? ""
    });
  }

  static Future<Users> getUser(String id) async {
    DocumentSnapshot snapshot = await _userCollection.doc(id).get();
    Map<String, dynamic> data = snapshot.data();
    print(data);
    return Users(
        idUser: id,
        email: data['email'],
        profilePath: data['profile_path'],
        kdGenre: (data['selectedGenres'] as List)
            ?.map((item) => item as String)
            ?.toList(),
        namaDepan: data['nama_depan'],
        namaBelakang: data['nama_belakang'],
        noHp: data['no_hp']);
  }
}
