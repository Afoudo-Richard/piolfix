import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const TaskPage());
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tasks = categories
        .map(
          (task) => GestureDetector(
            onTap: () {
              Navigator.push(context, SelectTaskerPage.route());
            },
            child: CustomContainer(
              boxShadow: [],
              border: Border.all(color: primaryColor),
              child: Text(
                task,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
        )
        .toList();
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Task',
      ),
      body: SingleChildScrollView(
        padding: pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            3.h.ph,
            CustomInput(
              leading: const Icon(
                LineIcons.search,
                color: primaryColor,
              ),
              inputHintText: 'What are you looking for? 🤔',
            ),
            2.h.ph,
            Text(
              'Popular',
              style: TextStyle(
                fontSize: 18.sp,
              ),
            ),
            3.h.ph,
            BlocBuilder<CategoryListBloc, CategoryListState>(
              builder: (context, state) {
                return Wrap(
                  spacing: 10.sp,
                  runSpacing: 10.sp,
                  children: state.categories
                      .map(
                        (task) => GestureDetector(
                          onTap: () {
                            BlocProvider.of<SelectTaskBloc>(context)
                                .add(SelectTaskServiceChanged(task));

                            Navigator.push(context, SelectTaskerPage.route());
                          },
                          child: CustomContainer(
                            boxShadow: [],
                            border: Border.all(color: primaryColor),
                            child: Text(
                              '${task.name}',
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
            5.h.ph,
          ],
        ),
      ),
    );
  }
}
