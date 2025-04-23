// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';
import 'package:talent_showcase_app/core/core_exports.dart'
    show AppColors, AppTextField;

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController _contentController = TextEditingController();
  bool _isPosting = false;
  bool _isFileAttached = false;

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  /// Handles the post submission logic
  Future<void> _submitPost() async {
    if (_contentController.text.isEmpty && !_isFileAttached) {
      _showSnackbar('Please provide content or attach a file');
      return;
    }

    setState(() => _isPosting = true);

    await Future.delayed(
      const Duration(seconds: 2),
    ); // Simulated delay for posting

    setState(() => _isPosting = false);

    _showSnackbar('Post created successfully!');
    Navigator.pop(context);
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _attachFile() {
    // Simulate file attachment process
    setState(() => _isFileAttached = true);
    _showSnackbar('File attached successfully');
  }

  /// Removes the attached file
  void _removeFile() {
    setState(() => _isFileAttached = false);
    _showSnackbar('File removed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Post',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.check, color: Colors.white),
            onPressed: _isPosting ? null : _submitPost, // Submit the post
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'What’s on your mind?',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.fontGray,
              ),
            ),
            const SizedBox(height: 12),
            AppTextField(
              controller: _contentController,
              hintText: 'Share your thoughts here...',
              maxLines: 6,
              label: '',
            ),
            const SizedBox(height: 16),
            _isFileAttached
                ? _buildAttachedFilePreview()
                : _buildFileUploadButton(),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isPosting ? null : _submitPost,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.surface,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child:
                  _isPosting
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                        'Post',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileUploadButton() {
    return ElevatedButton.icon(
      onPressed: _attachFile,
      icon: const Icon(Icons.attach_file),
      label: const Text('Attach File'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(vertical: 14),
        side: const BorderSide(color: AppColors.primary, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildAttachedFilePreview() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.primary, width: 1.5),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Row(
            children: <Widget>[
              Icon(Icons.insert_drive_file, color: AppColors.primary),
              SizedBox(width: 8),
              Text(
                'Attached File',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          IconButton(
            onPressed: _removeFile,
            icon: const Icon(Icons.close, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
