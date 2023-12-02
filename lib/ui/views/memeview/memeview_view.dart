import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'memeview_viewmodel.dart';

class MemeviewView extends StackedView<MemeviewViewModel> {
  const MemeviewView({super.key});

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                  // decorate the border of the container to make the container border visible
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 5,
                    ),
                  ),
                  child: Image.network(viewModel.imageUrl)),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () async {
                  await viewModel.shareAndSaveImage();
                },
                icon: const Icon(Icons.share),
                label: const Text("Share"),
              ),
              const SizedBox(height: 16),
            ],
          ),
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
