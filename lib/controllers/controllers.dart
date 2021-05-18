import 'dart:io';
import 'dart:math';

import 'package:cek_film_app/models/models.dart';
import 'package:cek_film_app/services/services.dart';
import 'package:cek_film_app/ui/pages/pages.dart';
import 'package:cek_film_app/utils/root.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cek_film_app/extensions/extensions.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
part 'auth_controller.dart';
part 'utils_controller.dart';
part 'movie_controller.dart';
part 'nobar_controller.dart';
part 'review_controller.dart';
