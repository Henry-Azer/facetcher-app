import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/image/network_image_loader.dart';
import '../../../../data/models/user-submission/user_submission.dart';

class UserSubmissionsListWidget extends StatefulWidget {
  final List<UserSubmission> submissions;

  const UserSubmissionsListWidget({Key? key, required this.submissions}) : super(key: key);

  @override
  State<UserSubmissionsListWidget> createState() => _UserSubmissionsListWidgetState();
}

class _UserSubmissionsListWidgetState extends State<UserSubmissionsListWidget> {
  final ScrollController _scrollController = ScrollController();
  int _currentMaxIndex = 9;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isLoading) { _loadMoreItems(); }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadMoreItems() async {
    if (_isLoading) return;
    setState(() { _isLoading = true; });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _isLoading = false;
      _currentMaxIndex += 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
        child: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent && !_isLoading) { _loadMoreItems(); }
            return false;
          },
          child: CustomScrollView(
            scrollDirection: Axis.horizontal,
            slivers: [
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final submissionIndex = index % widget.submissions.length;
                    final UserSubmission submission = widget.submissions[submissionIndex];
                    return NetworkImageLoader(
                      width: 150,
                      height: 185,
                      url: submission.outputImage.imageUrl,
                      loader: LoadingAnimationWidget.threeArchedCircle(color: Colors.white, size: 40,),
                    );
                  },
                  childCount: _currentMaxIndex < widget.submissions.length
                      ? _currentMaxIndex
                      : widget.submissions.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 16 / 10,
                ),
                // controller: _scrollController,
              ),
              if (_isLoading)
                SliverFillRemaining(
                  child: Container(
                    alignment: Alignment.center,
                    child: LoadingAnimationWidget.hexagonDots(
                      color: AppColors.textPrimary,
                      size: 45,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
