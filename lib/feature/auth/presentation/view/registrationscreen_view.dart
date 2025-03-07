import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wholesalehub_app/feature/auth/presentation/view_model/registration/bloc/registration_bloc.dart';

class RegistrationscreenView extends StatefulWidget {
  const RegistrationscreenView({super.key});

  @override
  State<RegistrationscreenView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegistrationscreenView> {
  final _gap = const SizedBox(height: 12);
  final _key = GlobalKey<FormState>();

  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  File? _img;
  Future _browseImage(ImageSource imagesource) async {
    try {
      final image = await ImagePicker().pickImage(source: imagesource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
          context.read<RegistrationBloc>().add(LoadImage(file: _img!));
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Register',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.white,
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (context) => Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.camera, size: 40),
                                onPressed: () {
                                  _browseImage(ImageSource.camera);
                                  Navigator.pop(context);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.image, size: 40),
                                onPressed: () {
                                  _browseImage(ImageSource.gallery);
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: _img != null
                          ? FileImage(_img!)
                          : const AssetImage('assets/images/userlogo.jpg')
                              as ImageProvider,
                    ),
                  ),
                  const SizedBox(height: 25),
                  _buildTextField('First Name', _fnameController),
                  _gap,
                  _buildTextField('Last Name', _lnameController),
                  _gap,
                  _buildTextField('Phone No', _phoneController),
                  _gap,
                  _buildTextField('Email', _emailController),
                  _gap,
                  _buildTextField('Address', _addressController),
                  _gap,
                  _buildTextField('Username', _usernameController),
                  _gap,
                  _buildTextField('Password', _passwordController,
                      obscure: true),
                  _gap,
                  ElevatedButton(
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        final registrationState =
                            context.read<RegistrationBloc>().state;
                        final imageName = registrationState.imageName;
                        context.read<RegistrationBloc>().add(
                              RegisterCustomer(
                                context: context,
                                fName: _fnameController.text,
                                lName: _lnameController.text,
                                phoneNo: _phoneController.text,
                                email: _emailController.text,
                                address: _addressController.text,
                                username: _usernameController.text,
                                password: _passwordController.text,
                                image: imageName,
                              ),
                            );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Register',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool obscure = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.grey[100],
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }
}
