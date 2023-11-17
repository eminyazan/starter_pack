import 'package:flutter/material.dart';

class AppLoadingShimmer extends StatelessWidget {
  final int count;
  final bool includeTitle;
  final Color backgroundColor;

  const AppLoadingShimmer({
    Key? key,
    this.count = 5,
    this.includeTitle = true,
    this.backgroundColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = context.getSize;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: ListView.builder(
            shrinkWrap: false,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: count,
            itemBuilder: (context, index) {
              return _buildListItem(size);
            }),
      ),
    );
  }

  Widget _buildListItem(Size size) {
    return LoadingShimmerItem(
      height: size.height * 0.13,
      space: size.height * 0.005,
      includeTitle: includeTitle,
    );
  }
}

class LoadingShimmerItem extends StatelessWidget {
  final bool includeTitle;
  final double height, space;

  const LoadingShimmerItem({
    super.key,
    required this.includeTitle,
    required this.height,
    required this.space,
  });

  @override
  Widget build(BuildContext context) {
    Size size = context.getSize;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: size.height * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (includeTitle) _buildTitle(size),
          SizedBox(height: space),
          _buildCard(),
        ],
      ),
    );
  }

  Widget _buildCard() {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  Widget _buildTitle(Size size) {
    return Container(
      width: size.width * 0.5,
      height: size.height * 0.025,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
