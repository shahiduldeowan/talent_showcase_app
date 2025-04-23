// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';
import 'package:talent_showcase_app/core/core_exports.dart' show AppColors;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isAccountActivated = true; // Tracks account activation toggle
  final List<PostModel> _userPosts =
      <PostModel>[]; // User-specific posts for testing

  @override
  void initState() {
    super.initState();
    _fetchUserPosts(); // Simulate fetching user posts
  }

  /// Simulate fetching posts specific to the user
  Future<void> _fetchUserPosts() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulated delay
    final List<PostModel> posts = List.generate(
      5,
      (int index) => PostModel(
        id: index,
        title: 'Post $index',
        type: <String>['VIDEO', 'IMAGE', 'FILE'][index % 3],
        content: 'This is the content of post $index.',
        likeCount: index * 3,
      ),
    );
    setState(() => _userPosts.addAll(posts));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary, // Consistent app theme
        actions: _buildAppBarActions(context),
      ),
      body: Column(
        children: <Widget>[
          _buildProfileHeader(context),
          const Divider(), // Separates the header from the posts
          _buildUserPostList(),
        ],
      ),
    );
  }

  /// Builds the AppBar actions for settings and logout
  List<Widget> _buildAppBarActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.settings, color: Colors.white),
        onPressed: () {
          // Navigate to Settings screen
          Navigator.pushNamed(context, '/settings');
        },
      ),
      IconButton(
        icon: const Icon(Icons.logout, color: Colors.white),
        onPressed: () {
          // Navigate back to Login screen
          Navigator.pushReplacementNamed(context, '/login');
        },
      ),
    ];
  }

  /// Builds the profile header with avatar, username, and toggle for account activation
  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 40,
            backgroundColor: AppColors.primary,
            child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 40,
            ), // Placeholder for user avatar
          ),
          const SizedBox(height: 8),
          Text(
            'John Doe', // Replace with actual user data
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.fontGray,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Account Activated:'),
              Switch(
                value: _isAccountActivated,
                onChanged: (bool value) {
                  setState(() => _isAccountActivated = value);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Builds the list of user posts
  Widget _buildUserPostList() {
    return Expanded(
      child:
          _userPosts.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: _userPosts.length,
                itemBuilder: (BuildContext context, int index) {
                  return PostCard(
                    post: _userPosts[index],
                  ); // Reusable PostCard widget
                },
              ),
    );
  }
}

class PostCard extends StatelessWidget {
  final PostModel post; // Data model for the post

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 8),
            Text(
              post.content,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.fontGray),
            ),
            const SizedBox(height: 12),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  /// Builds the header with the post title and type
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            post.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Chip(
          label: Text(post.type, style: const TextStyle(color: Colors.white)),
          backgroundColor: AppColors.surface,
        ),
      ],
    );
  }

  /// Builds the footer with like, comment, and share buttons
  Widget _buildFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                // Handle like action
                _showSnackbar(context, 'Liked post: ${post.title}');
              },
              icon: const Icon(Icons.thumb_up_alt_outlined),
              color: AppColors.primary,
            ),
            Text(
              '${post.likeCount}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        IconButton(
          onPressed: () {
            // Handle comment action (e.g., open comment modal)
            _showSnackbar(context, 'Commenting on post: ${post.title}');
          },
          icon: const Icon(Icons.comment_outlined),
          color: AppColors.primary,
        ),
        IconButton(
          onPressed: () {
            // Handle share action
            _showSnackbar(context, 'Sharing post: ${post.title}');
          },
          icon: const Icon(Icons.share_outlined),
          color: AppColors.primary,
        ),
      ],
    );
  }

  /// Helper function to show a snackbar for demo purposes
  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

class PostModel {
  final int id; // Unique identifier for the post
  final String title; // Title of the post
  final String type; // Type of the post (VIDEO, IMAGE, FILE)
  final String content; // Main content or description of the post
  final int likeCount; // Number of likes on the post

  // You can add other fields like:
  // - String imageUrl; (for media posts)
  // - DateTime timestamp;

  const PostModel({
    required this.id,
    required this.title,
    required this.type,
    required this.content,
    required this.likeCount,
  });

  // Factory constructor to create a PostModel from JSON (useful for API integration)
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] as int,
      title: json['title'] as String,
      type: json['type'] as String,
      content: json['content'] as String,
      likeCount: json['likeCount'] as int,
    );
  }

  // Method to convert the PostModel to JSON (useful for sending data to an API)
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'type': type,
      'content': content,
      'likeCount': likeCount,
    };
  }
}
