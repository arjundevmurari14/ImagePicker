import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

class ImageShareExample extends StatefulWidget {
  const ImageShareExample({super.key});

  @override
  _ImageShareExampleState createState() => _ImageShareExampleState();
}

class _ImageShareExampleState extends State<ImageShareExample> {
  File? _selectedImage;

  Future<void> _selectImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error selecting image: $e')),
      );
    }
  }

  Future<void> _shareImage() async {
    if (_selectedImage != null) {
      await Share.shareFiles([_selectedImage!.path]);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image first')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Share'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Aligns children to the center
          children: [
            if (_selectedImage != null)
              Container(
                constraints: BoxConstraints(
                  maxWidth: 400, // Set a maximum width
                  maxHeight: 400, // Set a maximum height
                ),
                child: Image.file(
                  _selectedImage!,
                  fit: BoxFit.contain, // Adjust the fit as needed
                ),
              ),
            const SizedBox(height: 20), // Add space between image and buttons
            ElevatedButton(
              onPressed: _selectImage,
              child: const Text('Select Image'),
            ),
            const SizedBox(height: 10), // Add space between buttons
            ElevatedButton(
              onPressed: _shareImage,
              child: const Text('Share Image'),
            ),
          ],
        ),
      ),
    );
  }
}
