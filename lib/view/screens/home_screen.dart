import 'package:daily_quoates/view_model/state_management/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:daily_quoates/model/quote_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Gap(20.h), _topBar(), Gap(30.h), ListOfQuotes()],
            ),
          ),
        ),
      ),
    );
  }

  Widget _topBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: RichText(
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            text: TextSpan(
              text: 'Daily ',
              style: GoogleFonts.epilogue(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff3B32FF)),
              children: [
                TextSpan(
                  text: 'Quotes',
                  style: GoogleFonts.epilogue(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        CircleAvatar(
          radius: 15.r,
          backgroundImage: AssetImage('assets/tom.png'),
        ),
      ],
    );
  }
}

class ListOfQuotes extends ConsumerWidget {
  const ListOfQuotes({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var listData = ref.watch(quoteProvider(context));
    return listData.when(data: (List<Quote> data) {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return _quoteCard(
              title: data[index].quote,
              author: data[index].author,
              id: data[index].id.toString());
        },
        itemCount: data.length,
      );
    }, error: (error, stackTrace) {
      return Text(error.toString());
    }, loading: () {
      return const Center(
        child: Center(
          child: Center(
            child: CircularProgressIndicator(
              color: Color(0xff3B32FF),
            ),
          ),
        ),
      );
    });
  }

  Widget _quoteCard(
      {required String title, required String author, required String id}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.epilogue(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 10,
        ),
        Gap(10.h),
        Chip(
            backgroundColor: const Color.fromARGB(255, 213, 211, 250),
            label: Text(
              'ID:- $id',
              style: GoogleFonts.epilogue(
                  fontSize: 12.sp,
                  color: const Color(0xff3B32FF),
                  fontWeight: FontWeight.w600),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [Text('- ${author}')],
        ),
        Gap(10.h),
      ],
    );
  }
}
