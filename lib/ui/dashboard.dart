import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_post.dart';
import '../post_bloc/post_bloc.dart';
import '../post_bloc/post_event.dart';
import '../util/api_service.dart';
import '../post_bloc/post_states.dart';
import 'post_details.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PostBloc(apiService: ApiService())..add(FetchPosts()),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 239, 239, 239),
        appBar: AppBar(
          toolbarHeight: 120,
          title: const Padding(
            padding: EdgeInsets.only(top: 80),
            child: Text(
              "Posts",
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 190, 210, 194),
          shadowColor: const Color.fromARGB(255, 111, 111, 111),
          elevation: 0.2,
        ),
        body: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostLoading) {
              return const Center(
                  child: CircularProgressIndicator(color: Color(0xFF004C11),)); // Show a loading spinner
            } else if (state is PostError) {
              return Center(
                  child: Text('Error: ${state.message}')); // Show error message
            } else if (state is PostLoaded) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: state.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    final post = state.items[index];
                    return GestureDetector(
                      onTap: () {
                        // Navigate to post details
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PostDetails(
                              id: post.id,
                              userId: post.userId,
                              title: post.title,
                              body: post.body,
                            ),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  maxRadius: 20,
                                  backgroundColor:
                                      const Color.fromARGB(255, 190, 210, 194),
                                  child: Text(
                                    "U${post.userId}",
                                    style: const TextStyle(
                                      color: Color(0xFF004C11),
                                      fontSize: 16,
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
                                        post.title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          color: Color(0xFF004C11),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        post.body,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
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
                              child:
                                  Divider(height: 1, color: Colors.grey[400]),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            return Container(); // In case no valid state is found
          },
        ),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: const Color(0xFF004C11),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddPostBloc(),
                ));
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

