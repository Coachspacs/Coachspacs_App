import 'package:flutter/material.dart';

import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/features/profile/ui/widgets/account_security_tile.dart';
import 'package:coach_space/features/profile/ui/widgets/edit_profile_header.dart';
import 'package:coach_space/features/profile/ui/widgets/profile_image_picker.dart';
import 'package:coach_space/features/profile/ui/widgets/profile_input_field.dart';
import 'package:coach_space/features/profile/ui/widgets/save_profile_button.dart';
import '../widgets/change_profile_picture_bottom_sheet.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController =
  TextEditingController(text: 'Jane Doe');

  final TextEditingController _emailController =
  TextEditingController(text: 'jane@example.com');

  final TextEditingController _passwordController =
  TextEditingController(text: '••••••••');

  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully'),
        ),
      );
    });
  }

  void _changePassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Change password'),
      ),
    );
  }

  void _changeProfilePicture() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return ChangeProfilePictureBottomSheet(
          onTakePhoto: () {
            Navigator.pop(context);

            ScaffoldMessenger.of(this.context).showSnackBar(
              const SnackBar(
                content: Text('Take a Photo'),
              ),
            );
          },
          onPickFromGallery: () {
            Navigator.pop(context);

            ScaffoldMessenger.of(this.context).showSnackBar(
              const SnackBar(
                content: Text('Upload from Gallery'),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EditProfileHeader(
                      onBack: () => Navigator.pop(context),
                    ),

                    const SizedBox(height: 28),

                    Center(
                      child: ProfileImagePicker(
                        onCameraPressed: _changeProfilePicture,
                      ),
                    ),

                    const SizedBox(height: 32),

                    ProfileInputField(
                      label: 'FULL NAME',
                      hintText: 'Jane Doe',
                      controller: _nameController,
                    ),

                    const SizedBox(height: 18),

                    ProfileInputField(
                      label: 'EMAIL ADDRESS',
                      hintText: 'jane@example.com',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 18),

                    ProfileInputField(
                      label: 'PASSWORD',
                      hintText: '••••••••',
                      controller: _passwordController,
                      obscureText: true,
                    ),

                    const SizedBox(height: 24),

                    AccountSecurityTile(
                      onChangePassword: _changePassword,
                    ),

                    const SizedBox(height: 28),

                    SaveProfileButton(
                      onPressed: _saveChanges,
                      isLoading: _isLoading,
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}