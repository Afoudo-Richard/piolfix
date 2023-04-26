import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';

class MyTaskersPage extends StatelessWidget {
  const MyTaskersPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const MyTaskersPage());
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: trans(context)!.my_taskers,
        actions: [
          BlocBuilder<FavouriteBloc, FavouriteState>(
            builder: (context, state) {
              return state.taskers.isNotEmpty
                  ? TextButton(
                      onPressed: () {
                        BlocProvider.of<FavouriteBloc>(context)
                            .add(ClearedFavourite());
                      },
                      child: Text(
                        trans(context)!.clear,
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    )
                  : const SizedBox.shrink();
            },
          ),
        ],
      ),
      // body: ListView.separated(
      //   physics: const NeverScrollableScrollPhysics(),
      //   shrinkWrap: true,
      //   itemBuilder: (context, index) {
      //     return IndividualReview();
      //   },
      //   separatorBuilder: (context, index) {
      //     return Divider(
      //       height: 10,
      //     );
      //   },
      //   itemCount: 7,
      // ),

      body: BlocBuilder<FavouriteBloc, FavouriteState>(
        builder: (context, state) {
          if (state.taskers.isEmpty) {
            return Center(
              child: FetchEmpty(
                message: trans(context)!.no_favourite_added_yet,
              ),
            );
          } else {
            return ListView.separated(
              padding:
                  EdgeInsets.symmetric(vertical: 2.h, horizontal: paddingSize),
              itemBuilder: (context, index) {
                final tasker = state.taskers[index];
                return TaskerItem(
                  user: tasker,
                );
              },
              separatorBuilder: (context, index) {
                return 2.h.ph;
              },
              itemCount: state.taskers.length,
            );
          }
        },
      ),
    );
  }
}
