import 'dart:io';

import 'package:kisan/Driver/Auth/authenicatte.dart';
import 'package:kisan/Driver/Auth/locator.dart';
import 'package:kisan/Driver/Auth/storage.dart';
import 'package:kisan/Driver/Auth/user.dart';

class UserController {
  User_d _currentuser;
  AuthService _authService = locator.get<AuthService>();
  StorageRepo _storageRepo = locator.get<StorageRepo>();
  Future init;
  UserController() {
    init = initUser();
  }

  Future<User_d> initUser() async {
    _currentuser = _authService.getUser as User_d;
    return _currentuser;
  }

  User_d get currentUser => _currentuser;

  Future uploadProfilePicture(File image) async {
    _currentuser.avatarUrl = (await _storageRepo.uploadFile(image));
  }

  Future<String> getDownloadUrl() async {
    return await _storageRepo.getUserProfileImageDownloadUrl(currentUser.uid);
  }

  Future signInWithEmailAndPassword({String email, String password}) async {
    _currentuser = await _authService.signInUser(email, password);
    _currentuser.avatarUrl = (await getDownloadUrl());

    print(_currentuser.name);
    print(_currentuser.uid);
    print(_currentuser.avatarUrl);
    print(_currentuser.email);
  }

  Future<void> updateDisplayName(String displayName) {
    _currentuser.name = displayName;
    // _authService.updateDisplayName(displayName);
    _authService.currentUser.name;
  }
}
