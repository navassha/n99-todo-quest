import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import 'package:n99_todo_quest/extensions/responsive_size.dart';
import 'package:n99_todo_quest/provider/dark_mode.dart';
import 'package:n99_todo_quest/provider/todo.dart';

class HomePage extends ConsumerWidget {
  HomePage({super.key});
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // there is initilizig the darkmode and
    // container hight variables when tap the dark mode is turn on the
    // dark mode on again tap is turn into light mode and defoultly its light mode

    final darkmode = ref.watch(darkMode);

    return Scaffold(
      backgroundColor: darkmode == false
          ? const Color(0xffcccccc)
          : const Color.fromARGB(255, 70, 70, 70),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff003366),
        title: Text(
          "TO DO",
          style: TextStyle(
            fontSize: context.width(22),
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              // there is the working of the dark mode and light mode
              ref.read(darkMode.notifier).state = !darkmode;
            },
            icon: darkmode == false
                ? Icon(
                    CupertinoIcons.lightbulb,
                    size: context.width(25),
                  )
                : Icon(
                    CupertinoIcons.lightbulb_slash,
                    size: context.width(25),
                  ),
          ),
          Gap(
            context.width(10),
          )
        ],
      ),
      // the is the starting of the body
      body: Padding(
        padding: EdgeInsets.all(context.width(10)),
        child: ref.watch(todoListProvider).isEmpty
            ? Center(
                child: Text(
                  "NO TO DO'S ARE THERE",
                  style: TextStyle(
                    fontSize: context.width(19),
                  ),
                ),
              )
            : ListView.separated(
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Colors.transparent,
                        content: Container(
                          width: context.width(300),
                          color: darkmode == false
                              ? Colors.white
                              : const Color.fromARGB(255, 115, 115, 115),
                          child: Padding(
                            padding: EdgeInsets.all(
                              context.width(20),
                            ),
                            child: Text(
                              ref.watch(todoListProvider)[index].title,
                              style: TextStyle(
                                  color: darkmode == false
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: context.width(20),
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    height: context.width(70),
                    decoration: BoxDecoration(
                      color: darkmode == false
                          ? Colors.white
                          : const Color.fromARGB(255, 33, 33, 33),
                      borderRadius: BorderRadius.circular(
                        context.width(10),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.width(5),
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            Gap(context.width(10)),
                            SizedBox(
                              width: context.width(340),
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                ref.watch(todoListProvider)[index].title,
                                style: TextStyle(
                                  fontSize: context.width(19),
                                  color: darkmode == false
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                ref
                                    .read(todoListProvider.notifier)
                                    .removeTodo(index);
                              },
                              icon: Icon(
                                CupertinoIcons.xmark_circle,
                                size: context.width(25),
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => Gap(context.width(10)),
                itemCount: ref.watch(todoListProvider).length,
              ),
      ),
      // there is the floating action button for add todos to the list
      // and it will show to the ui at the time
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff003366),
        onPressed: () {
          showAlertDailog(context, darkmode, ref);
        },
        child: Icon(
          CupertinoIcons.add,
          size: context.width(25),
        ),
      ),
    );
  }
  // there is the adding the todo when tap the floting action button its show a alert dailog
  // and we can add todo in the app showing into ui

  Future<dynamic> showAlertDailog(
      BuildContext context, bool darkmode, WidgetRef ref) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        content: Container(
          width: context.width(300),
          height: context.width(150),
          decoration: BoxDecoration(
            color: darkmode == false
                ? Colors.white
                : const Color.fromARGB(255, 115, 115, 115),
            borderRadius: BorderRadius.circular(
              context.width(10),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(context.width(10)),
            child: Column(
              children: [
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: "ADD TO DOS",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              darkmode == false ? Colors.black : Colors.white),
                      borderRadius: BorderRadius.circular(
                        context.width(10),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        context.width(10),
                      ),
                    ),
                  ),
                ),
                Gap(
                  context.width(15),
                ),
                Row(
                  children: [
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                    Gap(context.width(10)),
                    ElevatedButton(
                      onPressed: () {
                        if (controller.text.isNotEmpty) {
                          ref
                              .read(todoListProvider.notifier)
                              .addTodo(controller.text);

                          Navigator.pop(context);
                          controller.clear();
                        }
                      },
                      child: const Text("Add"),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
