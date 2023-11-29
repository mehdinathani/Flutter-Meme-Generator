import 'package:flutter/material.dart';
import 'package:memegeneraterappusingstacked/app/app.dart';
import 'package:stacked/stacked.dart';

import 'memeview_viewmodel.dart';

class MemeviewView extends StackedView<MemeviewViewModel> {
  const MemeviewView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    MemeviewViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generated Meme"),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            Image.network(viewModel.imageUrl),
          ],
        ),
      ),
    );
  }

  @override
  MemeviewViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MemeviewViewModel();
  @override
  onViewModelReady(MemeviewViewModel viewModel) {
    viewModel.getImageURL();
    super.onViewModelReady(viewModel);
  }
}
