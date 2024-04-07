import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/features/blog/presentation/widget/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const AddNewBlogPage(),
      );
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<String> selectTopics = [];

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DottedBorder(
                borderType: BorderType.RRect,
                color: AppPallete.borderColor,
                radius: const Radius.circular(12),
                dashPattern: const [20, 4],
                strokeCap: StrokeCap.round,
                child: const SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.folder_open_rounded,
                        size: 40,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Slect Image',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    'Bussiness',
                    'Technology',
                    'Programming',
                    'General',
                    'Health',
                    'Science',
                    'Sports',
                    'Entertainment',
                  ].map((e) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        onTap: () {
                          if (selectTopics.contains(e)) {
                            selectTopics.remove(e);
                          } else {
                            selectTopics.add(e);
                          }
                          setState(() {});
                          print(selectTopics);
                        },
                        child: Chip(
                            color: selectTopics.contains(e)
                                ? const MaterialStatePropertyAll(
                                    AppPallete.gradient1)
                                : null,
                            label: Text(e),
                            side: selectTopics.contains(e)
                                ? null
                                : const BorderSide(
                                    color: AppPallete.borderColor,
                                  )),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BlogEditor(
                controller: titleController,
                hintText: "Title",
              ),
              const SizedBox(
                height: 10,
              ),
              BlogEditor(
                controller: contentController,
                hintText: "Blog Content",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
