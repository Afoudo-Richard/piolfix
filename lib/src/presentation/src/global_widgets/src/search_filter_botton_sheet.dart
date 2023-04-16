import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:poilfix/poilfix.dart';
import 'package:sizer/sizer.dart';

class SearchFilterBottomSheet extends StatefulWidget {
  const SearchFilterBottomSheet({Key? key}) : super(key: key);

  @override
  State<SearchFilterBottomSheet> createState() =>
      _SearchFilterBottomSheetState();
}

class _SearchFilterBottomSheetState extends State<SearchFilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SectionHeader(
              title: "Search & Sort",
              trailing: InkWell(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  LineIcons.times,
                  color: Colors.black,
                  size: 20.sp,
                ),
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  title: TabBar(
                    labelPadding: EdgeInsets.only(bottom: 10),
                    indicatorColor: primaryColor,
                    tabs: [
                      Text(
                        "Search",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Sort",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                body: const TabBarView(
                  children: [
                    Filter(),
                    Sort(),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: paddingSize,
              vertical: 8,
            ),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    backgroundColor: Colors.white,
                    border: const BorderSide(),
                    child: Text(
                      "Reset",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  width: 4.w,
                ),
                Expanded(
                  child: BlocBuilder<AppBottomNavigationBarBloc,
                      AppBottomNavigationBarState>(
                    builder: (context, state) {
                      return CustomButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Apply",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Filter extends StatefulWidget {
  const Filter({Key? key}) : super(key: key);

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  var selectedRange = const RangeValues(1884, 2022);
  bool? checkBoxValue = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Expanded(
        //   child: SingleChildScrollView(
        //     child: Padding(
        //       padding: pagePadding,
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           2.h.ph,
        //           CustomInput(
        //             label: 'From',
        //             inputHintText: '',
        //             backgroundColor: Colors.white.withOpacity(0.7),
        //             onChanged: (value) {},
        //           ),
        //           2.h.ph,
        //           CustomInput(
        //             label: 'To',
        //             inputHintText: '',
        //             backgroundColor: Colors.white.withOpacity(0.7),
        //             onChanged: (value) {},
        //           ),
        //           2.h.ph,
        //           CustomInput(
        //             label: 'Agency',
        //             inputHintText: '',
        //             backgroundColor: Colors.white.withOpacity(0.7),
        //             onChanged: (value) {},
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

class Sort extends StatelessWidget {
  const Sort({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: pagePadding,
          child: Column(
            children: const [
              SortItem(label: "Name (A-Z)"),
              SortItem(label: "Name (Z-A)"),
              SortItem(label: "Price (High-Low)"),
              SortItem(label: "Price (Low-High)"),
            ],
          )),
    );
  }
}

class SortItem extends StatefulWidget {
  const SortItem({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  State<SortItem> createState() => _SortItemState();
}

class _SortItemState extends State<SortItem> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.label,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              isChecked
                  ? const CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.green,
                      child: Icon(
                        LineIcons.check,
                        color: Colors.white,
                        size: 13,
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          const Divider(
            height: 30,
          ),
        ],
      ),
    );
  }
}
