import 'package:flutter/material.dart';
import 'package:talent_showcase_app/core/core_exports.dart' show AppColors;
import 'package:talent_showcase_app/features/profile/presentaion/pages/profile_page.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final List<PostModel> _posts = <PostModel>[]; // Stores posts dynamically
  bool _isLoading = false; // Tracks whether posts are being loaded
  String _selectedFilter = 'ALL'; // Tracks the selected post type filter

  @override
  void initState() {
    super.initState();
    _fetchPosts(); // Fetch initial posts
  }

  /// Simulates fetching posts from an API or local data
  Future<void> _fetchPosts({bool isFiltering = false}) async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 2)); // Simulated delay
    // final List<dynamic> fetchedPosts = List.generate(
    //   10,
    //   (int index) => PostModel(
    //     id: index,
    //     title: 'Post $index',
    //     type: <String>['VIDEO', 'IMAGE', 'FILE'][index % 3],
    //     content: 'This is the content of post $index.',
    //     likeCount: index * 3,
    //   ),
    // );

    if (isFiltering) {
      _posts.clear(); // Clear existing posts if filtering
    }
    setState(() {
      // _posts.addAll(fetchedPosts);
      _isLoading = false;
    });
  }

  /// Filters posts by their type
  void _filterPosts(String type) {
    setState(() {
      _selectedFilter = type;
      _fetchPosts(isFiltering: true); // Simulated filtering process
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'Talent Showcase',
      //     style: Theme.of(context).textTheme.titleLarge?.copyWith(
      //       color: Colors.white,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      //   centerTitle: true,
      //   backgroundColor: AppColors.primary,
      //   actions: _buildAppBarActions(context),
      // ),
      body: Column(
        children: <Widget>[
          // _buildFilterBar(),
          Expanded(child: _buildPostList()),
        ],
      ),
    );
  }

  /// Builds AppBar actions for navigation
  List<Widget> _buildAppBarActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search, color: Colors.white),
        onPressed: () {
          // Navigate to Search Screen
          Navigator.pushNamed(context, '/search');
        },
      ),
      IconButton(
        icon: const Icon(Icons.settings, color: Colors.white),
        onPressed: () {
          // Navigate to Settings Screen
          Navigator.pushNamed(context, '/settings');
        },
      ),
    ];
  }

  /// Builds the filter bar for post types
  Widget _buildFilterBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:
            <String>['ALL', 'VIDEO', 'IMAGE', 'FILE']
                .map(
                  (String type) => GestureDetector(
                    onTap: () => _filterPosts(type),
                    child: Chip(
                      backgroundColor:
                          _selectedFilter == type
                              ? AppColors.surface
                              : Colors.white,
                      label: Text(
                        type,
                        style: TextStyle(
                          color:
                              _selectedFilter == type
                                  ? Colors.white
                                  : AppColors.fontGray,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }

  /// Builds the post list with lazy-loading
  Widget _buildPostList() {
    final List<dynamic> filteredPosts =
        _selectedFilter == 'ALL'
            ? _posts
            : _posts
                .where((PostModel post) => post.type == _selectedFilter)
                .toList();

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
            !_isLoading) {
          _fetchPosts(); // Load more posts when scrolling reaches the end
        }
        return false;
      },
      child:
          _isLoading && _posts.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: filteredPosts.length + (_isLoading ? 1 : 0),
                itemBuilder: (BuildContext context, int index) {
                  if (index == filteredPosts.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return PostCard(post: filteredPosts[index]);
                },
              ),
    );
  }
}
