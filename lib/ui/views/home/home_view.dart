import 'package:flutter/material.dart';
import 'package:memegeneraterappusingstacked/ui/views/home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Meme Generator"),
          ),
          body: SafeArea(
            child: Form(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: DropdownButtonFormField<String>(
                        items:
                            viewModel.templateNames.map((String templateName) {
                          return DropdownMenuItem<String>(
                            value: templateName,
                            child: Text(templateName),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          viewModel.templateId =
                              viewModel.getMemeIDbyName(newValue!).toString();
                        },
                        decoration: const InputDecoration(
                            labelText: 'Select Theme Name'),
                      ),
                    ),
                    // TextFormField(
                    //   onChanged: (value) => viewModel.templateId = value,
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please enter a template ID';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    const SizedBox(height: 16),

                    // Text0 Input
                    TextFormField(
                      onChanged: (value) => viewModel.text0 = value,
                      decoration: const InputDecoration(labelText: '1st Text'),
                      validator: (value) {
                        // You can add validation rules here if needed
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Text1 Input
                    TextFormField(
                      onChanged: (value) => viewModel.text1 = value,
                      decoration: const InputDecoration(labelText: '2nd Text'),
                      validator: (value) {
                        // You can add validation rules here if needed
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // Generate Meme Button
                    ElevatedButton(
                      onPressed: () async {
                        // Validate all fields before generating the meme
                        await viewModel.generateMeme();
                        viewModel.navigateTOMemeView();
                      },
                      child: viewModel.isBusy
                          ? const CircularProgressIndicator() // Show loading indicator
                          : const Text('Generate Meme'),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
