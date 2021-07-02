part of 'controllers.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> _firebaseUser = Rxn<User>();
  Rxn<Users> users = Rxn<Users>();
  var genreUser = <Genre>[];

  var pref = GetStorage();
  var newUser = false.obs;
  String get user => _firebaseUser.value?.email;
  UtilsController utilsController = Get.put(UtilsController());
  @override
  void onInit() {
    super.onInit();
    _firebaseUser.bindStream(_auth.authStateChanges());
  }

  void setPref(Users userr) {
    pref.write('idUser', userr.idUser);
    pref.write('email', userr.email);
    pref.write('noHp', userr.noHp);
    pref.write('namaDepan', userr.namaDepan);
    pref.write('namaBelakang', userr.namaBelakang);
    pref.write('kdGenre', userr.kdGenre);
    pref.write('profilePath', userr.profilePath);
    pref.write('isLogin', true);
  }

  void checkUser(String email, String password) async {
    try {
      List<String> result = await _auth.fetchSignInMethodsForEmail(email);
      print(result);
      if (result.length > 0) {
        Get.snackbar('Email telah terdaftar',
            'Email ini telah pernah di daftarkan di aplikasi ini',
            margin: EdgeInsets.all(12),
            backgroundColor: Colors.white70,
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.back();

        Get.to(RegistrationDataPage(
            RegistrationData(email: email, password: password)));
      }
    } on FirebaseAuthException catch (e) {
      Get.back();
      if (e.code == 'user-not-found') {
        Get.to(RegistrationDataPage(
            RegistrationData(email: email, password: password)));
      } else if (e.code == 'invalid-email') {
        Get.snackbar('Email tidak valid', 'Email yang kamu masukan tidak valid',
            margin: EdgeInsets.all(12),
            backgroundColor: Colors.white70,
            snackPosition: SnackPosition.BOTTOM);
      }
      print(e);
    } catch (e) {
      Get.back();
    }
  }

  void getUser(String userId) async {
    try {
      genreUser.clear();
      Users user = await UserServices.getUser(userId);
      if (user != null) {
        List<Genre> gen = await UtilsServices.getListGenre();
        user.kdGenre.forEach((element) {
          genreUser.add(gen.singleWhere((e) => e.id == int.tryParse(element)));
        });
        Get.back();

        Get.to(EditProfilePage(user));
      } else {
        Get.snackbar('Kesalahan', 'Error login',
            snackPosition: SnackPosition.BOTTOM);
      }
    } on FirebaseAuthException catch (e) {
      Get.back();
      if (e.code == 'user-not-found') {
        Get.snackbar('Email tidak ditemukan', 'Email tersebut tidak terdaftar',
            margin: EdgeInsets.all(12),
            backgroundColor: Colors.white70,
            snackPosition: SnackPosition.BOTTOM);
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Password Salah', 'Password yang kamu masukan salah',
            margin: EdgeInsets.all(12),
            backgroundColor: Colors.white60,
            snackPosition: SnackPosition.BOTTOM);
      } else if (e.code == 'invalid-email') {
        Get.snackbar('Email tidak valid', 'Email yang kamu masukan tidak valid',
            margin: EdgeInsets.all(12),
            backgroundColor: Colors.white70,
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.back();
      Get.snackbar('Kesalahan', e.toString(),
          margin: EdgeInsets.all(12),
          backgroundColor: Colors.white70,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void createUser(RegistrationData registrationData) async {
    try {
      if (registrationData.google) {
        print('id_user' + registrationData.idUser);
        await UserServices.updateUser(registrationData);
        Users userr = await AuthServices().signUpUser(registrationData);
        if (userr != null) {
          setPref(userr);
          Get.off(Root());
        } else {
          Get.snackbar('Kesalahan', 'Error login',
              margin: EdgeInsets.all(12),
              backgroundColor: Colors.white70,
              snackPosition: SnackPosition.BOTTOM);
        }
      } else {
        UserCredential result = await _auth.createUserWithEmailAndPassword(
            email: registrationData.email, password: registrationData.password);
        registrationData.idUser = result.user.uid;
        registrationData.email = result.user.email;

        await UserServices.updateUser(registrationData);
        Users userr = await AuthServices().signUpUser(registrationData);
        if (userr != null) {
          setPref(userr);
          Get.back();
          Get.off(Root());
        } else {
          Get.snackbar('Kesalahan', 'Error login',
              snackPosition: SnackPosition.BOTTOM);
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.back();

        Get.snackbar('Password Lemah', 'Password yang dimasukan terlalu lemah',
            margin: EdgeInsets.all(12),
            backgroundColor: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
      } else if (e.code == 'email-already-in-use') {
        Get.back();

        Get.snackbar('Email telah digunakan',
            'Email ini telah pernah digunakan pada akun lain',
            margin: EdgeInsets.all(12),
            backgroundColor: Colors.white70,
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.back();
      print(e.toString());
      Get.snackbar('Kesalahan', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void login(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      Users user = await UserServices.getUser(result.user.uid);
      if (user != null) {
        setPref(user);
        Get.off(Root());
      } else {
        Get.snackbar('Kesalahan', 'Error login',
            snackPosition: SnackPosition.BOTTOM);
      }
    } on FirebaseAuthException catch (e) {
      Get.back();
      if (e.code == 'user-not-found') {
        Get.snackbar('Email tidak ditemukan', 'Email tersebut tidak terdaftar',
            margin: EdgeInsets.all(12),
            backgroundColor: Colors.white70,
            snackPosition: SnackPosition.BOTTOM);
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Password Salah', 'Password yang kamu masukan salah',
            margin: EdgeInsets.all(12),
            backgroundColor: Colors.white60,
            snackPosition: SnackPosition.BOTTOM);
      } else if (e.code == 'invalid-email') {
        Get.snackbar('Email tidak valid', 'Email yang kamu masukan tidak valid',
            margin: EdgeInsets.all(12),
            backgroundColor: Colors.white70,
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.back();
      Get.snackbar('Kesalahan', e.message,
          margin: EdgeInsets.all(12),
          backgroundColor: Colors.white70,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void sendOtp(RegistrationData registrationData) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+62' + registrationData.noHp,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        // if(e.)
      },
      codeSent: (String verificationId, int resendToken) {
        Get.to(OtpVerificationPage(registrationData));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verifyOtp(String verificationId, String smsCode) {
    AuthCredential result = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
  }

  void loginWithGoogle({RegistrationData data, Widget page}) async {
    try {
      if (!kIsWeb) {
        if (page is SignUpPage) {
          await GoogleSignIn().signOut();
          try {
            final GoogleSignInAccount googleUser =
                await GoogleSignIn().signIn();

            final GoogleSignInAuthentication googleAuth =
                await googleUser.authentication;

            final credential = GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken,
              idToken: googleAuth.idToken,
            );

            UserCredential result =
                await FirebaseAuth.instance.signInWithCredential(credential);

            bool existUser = await AuthServices.getUser(result.user.uid);
            print(existUser);
            if (!result.additionalUserInfo.isNewUser && existUser) {
              Get.back();
              Get.snackbar(
                  'Akun telah ada', 'Akun google ini telah pernah didaftarkan',
                  margin: EdgeInsets.all(12),
                  backgroundColor: Colors.white60,
                  snackPosition: SnackPosition.BOTTOM);
            } else {
              Get.back();
              print('regis id :' + result.user.uid);
              Get.to(RegistrationDataPage(RegistrationData(
                  google: true,
                  idUser: result.user.uid,
                  email: googleUser.email)));
            }
          } catch (error) {
            Get.back();
            Get.snackbar('Masuk dibatalkan', 'Batal untuk masuk ke akun anda',
                margin: EdgeInsets.all(12),
                backgroundColor: Colors.white60,
                snackPosition: SnackPosition.BOTTOM);
          }
        } else {
          await GoogleSignIn().signOut();
          try {
            final GoogleSignInAccount googleUser =
                await GoogleSignIn().signIn();

            final GoogleSignInAuthentication googleAuth =
                await googleUser.authentication;

            final credential = GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken,
              idToken: googleAuth.idToken,
            );

            UserCredential result =
                await FirebaseAuth.instance.signInWithCredential(credential);
            bool existUser = await AuthServices.getUser(result.user.uid);
            print(existUser);
            Get.back();

            if (result.additionalUserInfo.isNewUser ||
                (!result.additionalUserInfo.isNewUser && !existUser)) {
              Get.back();

              print('regis id :' + result.user.uid);
              Get.to(RegistrationDataPage(RegistrationData(
                  google: true,
                  idUser: result.user.uid,
                  email: googleUser.email)));
            } else {
              Users user = await UserServices.getUser(result.user.uid);

              setPref(user);
              Get.offAll(Root());
            }
          } catch (error) {
            Get.back();
            Get.snackbar('Masuk dibatalkan', 'Batal untuk masuk ke akun anda',
                margin: EdgeInsets.all(12),
                backgroundColor: Colors.white60,
                snackPosition: SnackPosition.BOTTOM);
          }
        }
      } else {
        if (page is SignUpPage) {
          GoogleAuthProvider googleProvider = GoogleAuthProvider();

          googleProvider
              .addScope('https://www.googleapis.com/auth/contacts.readonly');
          googleProvider
              .setCustomParameters({'login_hint': 'user@example.com'});

          UserCredential result =
              await FirebaseAuth.instance.signInWithPopup(googleProvider);
          if (!result.additionalUserInfo.isNewUser) {
            Get.back();
            Get.snackbar(
                'Akun telah ada', 'Akun google ini telah pernah didaftarkan',
                margin: EdgeInsets.all(12),
                backgroundColor: Colors.white60,
                snackPosition: SnackPosition.BOTTOM);
          } else {
            Get.back();
            print('regis id :' + result.user.uid);
            Get.to(RegistrationDataPage(RegistrationData(
                google: true,
                idUser: result.user.uid,
                email: result.user.email)));
          }
        } else {
          GoogleAuthProvider googleProvider = GoogleAuthProvider();

          googleProvider
              .addScope('https://www.googleapis.com/auth/contacts.readonly');
          googleProvider
              .setCustomParameters({'login_hint': 'user@example.com'});

          UserCredential result =
              await FirebaseAuth.instance.signInWithPopup(googleProvider);
          Get.back();

          if (result.additionalUserInfo.isNewUser) {
            Get.back();
            print('regis id :' + result.user.uid);
            Get.to(RegistrationDataPage(RegistrationData(
                google: true,
                idUser: result.user.uid,
                email: result.user.email)));
          } else {
            Users user = await UserServices.getUser(result.user.uid);

            setPref(user);
            Get.offAll(Root());
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      Get.back();
      if (e.code == 'user-not-found') {
        Get.snackbar('Email tidak ditemukan', 'Email tersebut tidak terdaftar',
            margin: EdgeInsets.all(12),
            backgroundColor: Colors.white70,
            snackPosition: SnackPosition.BOTTOM);
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Password Salah', 'Password yang kamu masukan salah',
            margin: EdgeInsets.all(12),
            backgroundColor: Colors.white60,
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('A', e.toString(),
            margin: EdgeInsets.all(12),
            backgroundColor: Colors.white60,
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print(e);
      Get.back();
      Get.snackbar('Kesalahan', e.toString(),
          margin: EdgeInsets.all(12),
          backgroundColor: Colors.white70,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void logout() async {
    try {
      pref.remove('isLogin');

      await _auth.signOut();
      await GoogleSignIn().signOut();
      Get.off(LoginPage());
    } catch (e) {
      Get.snackbar('Kesalahan', e.message,
          margin: EdgeInsets.all(12),
          backgroundColor: Colors.white70,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> changePassword(String newPassword) async {
    try {
      User user = FirebaseAuth.instance.currentUser;

      //Pass in the password to updatePassword.
      user.updatePassword(newPassword).then((_) {
        print("Successfully changed password");
      }).catchError((error) {
        print("Password can't be changed" + error.toString());
        //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
      });
      Get.back();
    } on FirebaseAuthException catch (e) {
      Get.back();
      if (e.code == 'invalid-email') {
        Get.snackbar('Email salah',
            'Email yang anda masukan tidak valid,mohon untuk input email yang valid',
            margin: EdgeInsets.all(12),
            backgroundColor: Colors.white70,
            snackPosition: SnackPosition.BOTTOM);
      } else if (e.code == 'user-not-found') {
        Get.snackbar('Pengguna tidak ada',
            'Tidak ditemukan akun yang menggunakan email ini',
            margin: EdgeInsets.all(12),
            backgroundColor: Colors.white60,
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('A', e.toString(),
            margin: EdgeInsets.all(12),
            backgroundColor: Colors.white60,
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.back();
    } on FirebaseAuthException catch (e) {
      Get.back();
      if (e.code == 'invalid-email') {
        Get.snackbar('Email salah',
            'Email yang anda masukan tidak valid,mohon untuk input email yang valid',
            margin: EdgeInsets.all(12),
            backgroundColor: Colors.white70,
            snackPosition: SnackPosition.BOTTOM);
      } else if (e.code == 'user-not-found') {
        Get.snackbar('Pengguna tidak ada',
            'Tidak ditemukan akun yang menggunakan email ini',
            margin: EdgeInsets.all(12),
            backgroundColor: Colors.white60,
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('A', e.toString(),
            margin: EdgeInsets.all(12),
            backgroundColor: Colors.white60,
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print(e);
    }
  }
}
