import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();


const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';


final emulatorIP = '10.0.2.2:3000'; // 안드로이드
final simulatorIP = '127.0.0.1:3000'; // ios
final ip = Platform.isIOS ? simulatorIP : emulatorIP;
