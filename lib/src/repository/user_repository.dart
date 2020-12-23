import 'dart:convert';

import 'package:carwash/src/models/usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../repository/user_repository.dart' as userRepo;

ValueNotifier<Usuario> currentUser = new ValueNotifier(Usuario());
FirebaseAuth _auth = FirebaseAuth.instance;
User user;
GoogleSignIn _googleSignIn = new GoogleSignIn();
Usuario usuario = new Usuario();

Future<Usuario> login() async {
  GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
  GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  AuthCredential credential = GoogleAuthProvider.credential(
    idToken: googleSignInAuthentication.idToken,
    accessToken: googleSignInAuthentication.accessToken,
  );

  UserCredential result = (await _auth.signInWithCredential(credential));

  user = result.user;

  if (user.emailVerified) {
    usuario.uid = user.uid;
    usuario.displayName = user.displayName;
    usuario.email = user.email;
    usuario.phoneNumber = user.phoneNumber;
    usuario.photoUrl = user.photoURL;
    usuario.verifyEmail = user.emailVerified;
    setCurrentUser(json.encode(usuario));
    currentUser.value = usuario;
  } else {
    throw new Exception('Ocurrio un error');
  }
  return currentUser.value;
}

// Future<User> register(User user) async {
//   final String url =
//       '${GlobalConfiguration().getString('api_base_url')}register';
//   final client = new http.Client();
//   final response = await client.post(
//     url,
//     headers: {HttpHeaders.contentTypeHeader: 'application/json'},
//     body: json.encode(user.toMap()),
//   );
//   if (response.statusCode == 200) {
//     setCurrentUser(response.body);
//     currentUser.value = User.fromJSON(json.decode(response.body)['data']);
//   } else {
//     throw new Exception(response.body);
//   }
//   return currentUser.value;
// }

// Future<bool> resetPassword(User user) async {
//   final String url =
//       '${GlobalConfiguration().getString('api_base_url')}send_reset_link_email';
//   final client = new http.Client();
//   final response = await client.post(
//     url,
//     headers: {HttpHeaders.contentTypeHeader: 'application/json'},
//     body: json.encode(user.toMap()),
//   );
//   if (response.statusCode == 200) {
//     return true;
//   } else {
//     throw new Exception(response.body);
//   }
// }

Future<void> logout() async {
  currentUser.value = new Usuario();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('current_user');
  await _auth.signOut().then((onValue) {
    _googleSignIn.signOut();
  });
}

Future<String> getUsuario() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.get('usuario');
}

Future<void> setUsuario(String usuario) async {
  if (usuario != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('usuario', usuario);
  }
}

void setCurrentUser(jsonString) async {
  if (json.decode(jsonString) != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_user', json.encode(json.decode(jsonString)));
  }
}

// Future<void> setCreditCard(CreditCard creditCard) async {
//   if (creditCard != null) {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('credit_card', json.encode(creditCard.toMap()));
//   }
// }

Future<Usuario> getCurrentUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //prefs.clear();
  if (currentUser.value.verifyEmail == null &&
      prefs.containsKey('current_user')) {
    currentUser.value =
        Usuario.fromJson(json.decode(await prefs.get('current_user')));
    currentUser.value.verifyEmail = true;
  } else {
    currentUser.value.verifyEmail = false;
  }
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  currentUser.notifyListeners();
  return currentUser.value;
}

// Future<CreditCard> getCreditCard() async {
//   CreditCard _creditCard = new CreditCard();
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   if (prefs.containsKey('credit_card')) {
//     _creditCard = CreditCard.fromJSON(json.decode(await prefs.get('credit_card')));
//   }
//   return _creditCard;
// }

// Future<User> update(User user) async {
//   final String _apiToken = 'api_token=${currentUser.value.apiToken}';
//   final String url =
//       '${GlobalConfiguration().getString('api_base_url')}users/${currentUser.value.id}?$_apiToken';
//   final client = new http.Client();
//   final response = await client.post(
//     url,
//     headers: {HttpHeaders.contentTypeHeader: 'application/json'},
//     body: json.encode(user.toMap()),
//   );
//   setCurrentUser(response.body);
//   currentUser.value = User.fromJSON(json.decode(response.body)['data']);
//   return currentUser.value;
// }

// Future<Stream<Address>> getAddresses() async {
//   User _user = currentUser.value;
//   final String _apiToken = 'api_token=${_user.apiToken}&';
//   final String url =
//       '${GlobalConfiguration().getString('api_base_url')}delivery_addresses?$_apiToken&search=user_id:${_user.id}&searchFields=user_id:=&orderBy=updated_at&sortedBy=desc';
//   //print(url);
//   final client = new http.Client();
//   final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

//   return streamedRest.stream.transform(utf8.decoder).transform(json.decoder).map((data) => Helper.getData(data)).expand((data) => (data as List)).map((data) {
//     return Address.fromJSON(data);
//   });
// }

// Future<Address> addAddress(Address address) async {
//   User _user = userRepo.currentUser.value;
//   final String _apiToken = 'api_token=${_user.apiToken}';
//   address.userId = _user.id;
//   final String url = '${GlobalConfiguration().getString('api_base_url')}delivery_addresses?$_apiToken';
//   final client = new http.Client();
//   final response = await client.post(
//     url,
//     headers: {HttpHeaders.contentTypeHeader: 'application/json'},
//     body: json.encode(address.toMap()),
//   );
//   return Address.fromJSON(json.decode(response.body)['data']);
// }

// Future<Address> updateAddress(Address address) async {
//   User _user = userRepo.currentUser.value;
//   final String _apiToken = 'api_token=${_user.apiToken}';
//   address.userId = _user.id;
//   final String url = '${GlobalConfiguration().getString('api_base_url')}delivery_addresses/${address.id}?$_apiToken';
//   final client = new http.Client();
//   final response = await client.put(
//     url,
//     headers: {HttpHeaders.contentTypeHeader: 'application/json'},
//     body: json.encode(address.toMap()),
//   );
//   return Address.fromJSON(json.decode(response.body)['data']);
// }

// Future<Address> removeDeliveryAddress(Address address) async {
//   User _user = userRepo.currentUser.value;
//   final String _apiToken = 'api_token=${_user.apiToken}';
//   final String url = '${GlobalConfiguration().getString('api_base_url')}delivery_addresses/${address.id}?$_apiToken';
//   final client = new http.Client();
//   final response = await client.delete(
//     url,
//     headers: {HttpHeaders.contentTypeHeader: 'application/json'},
//   );
//   return Address.fromJSON(json.decode(response.body)['data']);
// }
