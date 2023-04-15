import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';

class CategoryListPage extends StatelessWidget {
  const CategoryListPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const CategoryListPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'List Category',
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(context, CategoryAddPage.route());
            },
            child: const Text(
              'Add',
              style: TextStyle(
                color: secondaryColor,
              ),
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        color: primaryColor,
        onRefresh: () => Future.sync(
          () => BlocProvider.of<CategoryListBloc>(context).add(
            CategoryListFetched(refresh: true),
          ),
        ),
        child: Column(
          children: [
            2.h.ph,
            Padding(
              padding: pagePadding,
              child: CustomInput(
                inputHintText: 'Search Category',
              ),
            ),
            2.h.ph,
            Expanded(
              child: BlocBuilder<CategoryListBloc, CategoryListState>(
                builder: (context, state) {
                  switch (state.categoryListStatus) {
                    case CategoryListStatus.initial:
                    case CategoryListStatus.refresh:
                      return Center(
                        child: LoadingIndicator(),
                      );

                    case CategoryListStatus.failure:
                      return const Center(
                          child: Text("Failed to fetch services. Refresh"));
                    case CategoryListStatus.success:
                      return state.categories.isEmpty
                          ? Center(
                              child: GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<CategoryListBloc>(context)
                                        .add(
                                            CategoryListFetched(refresh: true));
                                  },
                                  child: Text("No Services found")),
                            )
                          : ListView.separated(
                              padding: pagePadding,
                              itemBuilder: (context, index) {
                                final service = state.categories[index];
                                return CustomContainer(
                                  boxShadow: [],
                                  border: Border.all(color: primaryColor),
                                  child: Row(
                                    children: [
                                      CustomContainer(
                                        padding: EdgeInsets.zero,
                                        boxShadow: [],
                                        height: 15.h,
                                        width: 25.w,
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => Center(
                                            child: LoadingIndicator(),
                                          ),
                                          imageUrl:
                                              service.imageThumbnail!.url ??
                                                  "some image default image",
                                        ),
                                      ),
                                      1.w.pw,
                                      Expanded(
                                        child: Text(
                                          service.name ?? 'N/A',
                                          style: TextStyle(
                                            color: primaryColor,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ),
                                      2.w.pw,
                                      const Icon(
                                        LineIcons.trash,
                                        color: Colors.red,
                                      ),
                                      2.w.pw,
                                      const Icon(
                                        LineIcons.pen,
                                        color: Colors.blue,
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return 2.h.ph;
                              },
                              itemCount: state.categories.length,
                            );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
