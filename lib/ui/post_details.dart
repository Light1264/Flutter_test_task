import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_task/comment_bloc/comment_bloc.dart';
import 'package:flutter_test_task/comment_bloc/comment_state.dart';
import 'package:flutter_test_task/ui/edit_post.dart';
import 'package:flutter_test_task/util/dialog.dart';
import '../util/api_service.dart';
import '../comment_bloc/comment_event.dart';

class PostDetails extends StatelessWidget {
  const PostDetails({
    super.key,
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });
  final int id;
  final int userId;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            CommentBloc(apiService: ApiService())..add(FetchComments(userId)),
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 239, 239, 239),
          appBar: AppBar(
            toolbarHeight: 80,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back),
                  ),
                  const Spacer(),
                  const Text(
                    "Post Details",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Spacer(),
                ],
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 190, 210, 194),
            shadowColor: const Color.fromARGB(255, 111, 111, 111),
            elevation: 0.2,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    maxRadius: 40,
                    backgroundColor: const Color.fromARGB(255, 190, 210, 194),
                    child: Text(
                      "U$userId",
                      style: const TextStyle(
                        color: Color(0xFF004C11),
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Color(0xFF004C11),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          body,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditPostBloc(id: id, userId: userId,),
                                    ));
                              },
                              child: Container(
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF004C11),
                                    borderRadius: BorderRadius.circular(5)),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Edit",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                showMyDialog(context, id);
                              },
                              child: Container(
                                height: 40,
                                width: 120,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.red,
                                    ),
                                    borderRadius: BorderRadius.circular(5)),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      color: Color.fromARGB(255, 223, 62, 50),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Delete",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey[400],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Comments",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Color(0xFF004C11),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<CommentBloc, CommentState>(
                    builder: (context, state) {
                      if (state is CommentLoading) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Color(0xFF004C11),
                        )); // Show a loading spinner
                      } else if (state is CommentError) {
                        return Center(
                            child: Text(
                                'Error: ${state.message}')); // Show error message
                      } else if (state is CommentLoaded) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.items.length,
                          itemBuilder: (BuildContext context, int index) {
                            final comment = state.items[index];
                            return SizedBox(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            width: 2,
                                            color: const Color.fromARGB(
                                                255, 208, 194, 0),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "C${comment.id}",
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 208, 194, 0),
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              comment.name,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18,
                                                color: Color(0xFF004C11),
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              comment.email,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              comment.body,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 40),
                                    child: Divider(
                                        height: 1, color: Colors.grey[400]),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                      return Container(); // In case no valid state is found
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
