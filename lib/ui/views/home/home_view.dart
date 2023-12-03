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
          // backgroundColor: Colors.deepPurpleColor[100],
          appBar: AppBar(
            backgroundColor: Colors.purple,
            centerTitle: true,
            title: const Text(
              "Meme Generator",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: SafeArea(
            child: Form(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        SizedBox(
                          // color: Colors.purple,
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: DropdownButtonFormField<String>(
                            isExpanded: true,
                            items: viewModel.templateNames
                                .map((String templateName) {
                              return DropdownMenuItem<String>(
                                value: templateName,
                                child: Text(
                                  templateName,
                                  style: const TextStyle(),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              viewModel.templateId = viewModel
                                  .getMemeIDbyName(newValue!)
                                  .toString();
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              labelText: 'Select Theme',
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Text0 Input
                        TextFormField(
                          // set border color and radius

                          onChanged: (value) => viewModel.text0 = value,
                          decoration: const InputDecoration(
                            labelText: '1st Text',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                          ),
                          validator: (value) {
                            // You can add validation rules here if needed
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Text1 Input
                        TextFormField(
                          onChanged: (value) => viewModel.text1 = value,
                          decoration: const InputDecoration(
                            labelText: '2nd Text',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                          ),
                          validator: (value) {
                            // You can add validation rules here if needed
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),

                        // Generate Meme Button
                        ElevatedButton(
                          style: ButtonStyle(
                            fixedSize:
                                MaterialStateProperty.all(const Size(350, 60)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.purple),
                          ),
                          onPressed: () async {
                            // Validate all fields before generating the meme
                            await viewModel.generateMeme();
                            viewModel.navigateTOMemeView();
                          },
                          child: viewModel.isBusy
                              ? const CircularProgressIndicator() // Show loading indicator
                              : const Text(
                                  'Generate Meme',
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.white),
                                ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Container(
                    width: MediaQuery.of(context).size.width * 1,
                    color: Colors.purple,
                    // padding: EdgeInsets.symmetric(horizontal: 5),
                    alignment: Alignment.bottomCenter,
                    child: const Center(
                      child: Text(
                        'Made with ❤️ by mehdinathani,\n Copyright © 2023 All rights reserved.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
