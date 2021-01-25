import 'dart:convert';
import 'dart:io';

import 'package:food_market/models/models.dart';
import 'package:http/http.dart' as http;

part 'user_services.dart';
part 'food_services.dart';
part 'transaction_services.dart';

// default base url api
String baseUrl = "https://api-fm.niowcode.id/api/";
