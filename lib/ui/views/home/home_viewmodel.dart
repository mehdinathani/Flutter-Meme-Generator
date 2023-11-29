import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:memegeneraterappusingstacked/app/app.locator.dart';
import 'package:memegeneraterappusingstacked/app/app.router.dart';
import 'package:memegeneraterappusingstacked/config/config.dart';
import 'package:memegeneraterappusingstacked/model/template_model.dart';
import 'package:memegeneraterappusingstacked/services/memegenerationservice_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  String templateId = '';
  String text0 = '';
  String text1 = '';
  String username = Config.username;
  String password = Config.password;
  String imageUrl = '';
  List<Meme> memes = memeList;
  // Getter for template names
  List<String> get templateNames => memes.map((meme) => meme.name).toList();

  final MemegenerationserviceService _memeservice =
      locator<MemegenerationserviceService>();

  final navigationService = locator<NavigationService>();

  int getMemeIDbyName(String memeName) {
    Meme? selectedMeme = memes.firstWhere(
      (meme) => meme.name == memeName,
      orElse: () => Meme(id: 0, name: '', description: ''),
    );
    return selectedMeme.id;
  }

  navigateTOMemeView() {
    navigationService.navigateToMemeviewView();
  }

  Future<void> generateMeme() async {
    if (templateId.isEmpty || text0.isEmpty || text1.isEmpty) {
      // Perform validation and show an error message if needed
      // You may use a state variable to manage the error message in your UI
      return;
    }

    setBusy(true);

    try {
      // imageUrl = await MemeService.generateMeme();
      // var response = await Dio().get(
      //   'https://api.imgflip.com/caption_image?template_id=$templateId&text0=$text0&text1=$text1&username=$username&password=$password',
      // );
      // log(
      //   'https://api.imgflip.com/caption_image?template_id=$templateId&text0=$text0&text1=$text1&username=$username&password=$password',
      // );
      // imageUrl = response.data['data']['url'];
      imageUrl = await _memeservice.generateMeme(templateId, text0, text1);
      log(imageUrl);

      // Notify listeners that the data has been changed
      notifyListeners();
    } catch (e) {
      // Handle errors
      debugPrint('Error generating meme: $e');

      // You may set an error message state variable here for user feedback
    } finally {
      setBusy(false);
    }
  }
}
