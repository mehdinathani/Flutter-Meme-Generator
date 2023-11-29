import 'dart:developer';

import 'package:memegeneraterappusingstacked/app/app.locator.dart';
import 'package:memegeneraterappusingstacked/services/memegenerationservice_service.dart';
import 'package:stacked/stacked.dart';

class MemeviewViewModel extends BaseViewModel {
  MemegenerationserviceService _memeservice =
      locator<MemegenerationserviceService>();

  String imageUrl = "";

  getImageURL() {
    imageUrl = _memeservice.imageUrl;
    log(imageUrl);
  }
}
