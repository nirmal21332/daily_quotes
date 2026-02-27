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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Gap(20.h), _topBar(isDark), Gap(30.h), ListOfQuotes()],
            ),
          ),
        ),
      ),
    );
  }

  Widget _topBar(bool isDark) {
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
                      color: isDark ? Colors.white : Colors.black),
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
    final deletedIds = ref.watch(deletedQuotesProvider);

    return listData.when(
      data: (List<Quote> data) {
        final visibleQuotes =
            data.where((q) => !deletedIds.contains(q.id)).toList();

        if (visibleQuotes.isEmpty) {
          return Center(
            child: Column(
              children: [
                Gap(60.h),
                Icon(
                  Icons.format_quote_rounded,
                  size: 60.sp,
                  color: const Color(0xff3B32FF).withOpacity(0.3),
                ),
                Gap(16.h),
                Text(
                  'No quotes left!',
                  style: GoogleFonts.epilogue(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final quote = visibleQuotes[index];
            return _quoteCard(
              context: context,
              ref: ref,
              title: quote.quote,
              author: quote.author,
              id: quote.id,
            );
          },
          itemCount: visibleQuotes.length,
        );
      },
      error: (error, stackTrace) {
        return Text(error.toString());
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(
            color: Color(0xff3B32FF),
          ),
        );
      },
    );
  }

  Widget _quoteCard({
    required BuildContext context,
    required WidgetRef ref,
    required String title,
    required String author,
    required int id,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dismissible(
      key: Key('quote_$id'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.w),
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Icon(Icons.delete_rounded, color: Colors.white, size: 28.sp),
      ),
      onDismissed: (_) {
        ref.read(deletedQuotesProvider.notifier).update((state) {
          return {...state, id};
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Quote deleted',
              style: GoogleFonts.epilogue(color: Colors.white),
            ),
            backgroundColor: Colors.red.shade400,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            margin: EdgeInsets.all(16.w),
            duration: const Duration(seconds: 2),
            action: SnackBarAction(
              label: 'Undo',
              textColor: Colors.white,
              onPressed: () {
                ref.read(deletedQuotesProvider.notifier).update((state) {
                  return state.where((e) => e != id).toSet();
                });
              },
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xff1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.3)
                  : const Color(0xff3B32FF).withOpacity(0.07),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(0.05)
                : const Color(0xff3B32FF).withOpacity(0.08),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quote icon
            Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: const Color(0xff3B32FF).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.format_quote_rounded,
                color: const Color(0xff3B32FF),
                size: 18.sp,
              ),
            ),
            Gap(12.w),
            // Quote content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.epilogue(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white : Colors.black87,
                      height: 1.5,
                    ),
                    maxLines: 10,
                  ),
                  Gap(10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Chip(
                        backgroundColor:
                            const Color.fromARGB(255, 213, 211, 250),
                        padding: EdgeInsets.zero,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        label: Text(
                          'ID: $id',
                          style: GoogleFonts.epilogue(
                              fontSize: 11.sp,
                              color: const Color(0xff3B32FF),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        '— $author',
                        style: GoogleFonts.epilogue(
                          fontSize: 12.sp,
                          fontStyle: FontStyle.italic,
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Gap(8.w),
            // Delete icon button on the right
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    title: Text(
                      'Delete Quote',
                      style: GoogleFonts.epilogue(fontWeight: FontWeight.w600),
                    ),
                    content: Text(
                      'Are you sure you want to delete this quote?',
                      style: GoogleFonts.epilogue(fontSize: 14.sp),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.epilogue(color: Colors.grey),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade400,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          ref
                              .read(deletedQuotesProvider.notifier)
                              .update((state) => {...state, id});
                        },
                        child: Text(
                          'Delete',
                          style: GoogleFonts.epilogue(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.red.shade400,
                  size: 18.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
