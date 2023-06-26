import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  const CategoryItem({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<SelectTaskBloc>(context)
            .add(SelectTaskServiceChanged(category));
        Navigator.push(
          context,
          SelectTaskerPage.route(),
        );
      },
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicWidth(
            child: CustomContainer(
              padding: EdgeInsets.zero,
              boxShadow: [],
              width: 100.w,
              // height: 100.sp,
              child: SizedBox(
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: LoadingIndicator(),
                  ),
                  imageUrl: category.imageThumbnailUrl != null
                      ? category.imageThumbnailUrl!
                      : "https://ui-avatars.com/api/?name=P+F",
                ),
              ),
            ),
          ),
          1.h.ph,
          BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, settingState) {
              return Text(
                category.name ?? 'N/A',
                style: TextStyle(
                  fontSize: 9.sp,
                  fontWeight: FontWeight.bold,
                  color: settingState.isDarkMode ? Colors.white : Colors.black,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
