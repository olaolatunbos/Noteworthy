// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noteworthy/constants/sizes.dart';
import 'package:noteworthy/features/authentication/data/authentication_repository.dart';
import 'package:noteworthy/features/authentication/presentation/authentication_controller.dart';
import 'package:noteworthy/features/notes/presentation/grids/notes_grids.dart';
import 'package:noteworthy/routing/app_router.dart';

class NotesScreen extends ConsumerStatefulWidget {
  const NotesScreen({super.key});

  @override
  MyWidgetState createState() => MyWidgetState();
}

class MyWidgetState extends ConsumerState<NotesScreen> {
  List<String> items = ["All", "Important", "Bookmarked"];

  List<Widget> widgets = [
    const AllNotesGrid(),
    const ImportantNotesGrid(),
    const BookmarkedNotesGrid()
  ];

  int current = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      AllNotesGrid(
          onPressed: (context, postId) => context.pushNamed(
                AppRoute.editNote.name,
                pathParameters: {'id': postId},
              )),
      ImportantNotesGrid(
          onPressed: (context, postId) => context.pushNamed(
                AppRoute.editNote.name,
                pathParameters: {'id': postId},
              )),
      BookmarkedNotesGrid(
          onPressed: (context, postId) => context.pushNamed(
                AppRoute.editNote.name,
                pathParameters: {'id': postId},
              ))
    ];
    final state = ref.read(authenticationContorllerProvider.notifier);
    final user = ref.read(authRepositoryProvider).currentUser;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(Sizes.p12, Sizes.p44, 0, 0),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    " Hi, ${user!.username ?? ""} ",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: Sizes.p20,
                        fontFamily: "Poppins"),
                  ),
                  IconButton(
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      onPressed: () => state.signOut()),
                ],
              ),
              gapH16,
              const Text("My Notes",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Sizes.p32,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500)),
              gapH24,
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: items.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                current = index;
                              });
                              pageController.animateToPage(
                                current,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.ease,
                              );
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.all(5),
                              width: 120,
                              height: 40,
                              decoration: BoxDecoration(
                                color: current == index
                                    ? Colors.white
                                    : const Color.fromARGB(35, 158, 158, 158),
                                borderRadius: current == index
                                    ? BorderRadius.circular(12)
                                    : BorderRadius.circular(10),
                                border: current == index
                                    ? Border.all(
                                        color: Colors.black, width: 2.5)
                                    : Border.all(
                                        color: const Color.fromARGB(
                                            114, 255, 255, 255)),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      items[index],
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontWeight: current == index
                                              ? FontWeight.w500
                                              : null,
                                          color: current == index
                                              ? Colors.black
                                              : Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),

              /// MAIN BODY
              Container(
                width: double.infinity,
                height: 600,
                child: PageView.builder(
                  itemCount: widgets.length,
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return widgets[index];
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white),
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () => context.pushNamed(AppRoute.addNote.name),
        ),
      ),
    );
  }
}
