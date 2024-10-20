import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../util/api_service.dart';
import '../post_bloc/post_event.dart';
import '../post_bloc/post_bloc.dart';
import '../post_bloc/post_states.dart';
import '../util/snackbar.dart';
import '../widgets/app_botton.dart';
import '../widgets/app_textField.dart';

class EditPostBloc extends StatelessWidget {
  const EditPostBloc({
    super.key,
    required this.id,
    required this.userId,
  });

  final int id;
  final int userId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostBloc(apiService: ApiService()),
      child: EditPost(
        id: id,
        userId: userId,
      ),
    );
  }
}

class EditPost extends StatefulWidget {
  const EditPost({
    super.key,
    required this.id,
    required this.userId,
  });

  final int id;
  final int userId;

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostBloc, PostState>(
      listener: (context, state) {
        if (state is PostLoading) {
          setState(() {
            isLoading = true;
          });
        } else if (state is AddEditPostLoaded) {
          setState(() {
            isLoading = false;
          });
          showSnackBar(context, "Successfully edited post");
          Navigator.pop(context); // Close the page after success
        } else if (state is PostError) {
          setState(() {
            isLoading = false;
          });
          showSnackBar(context, "Failed to add post: ${state.message}");
        }
      },
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
                  "Edit Post",
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
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    maxRadius: 40,
                    backgroundColor: const Color.fromARGB(255, 190, 210, 194),
                    child: Text(
                      "U${widget.userId}",
                      style: const TextStyle(
                        color: Color(0xFF004C11),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                AppTextField(
                  textFieldHeader: "Title",
                  hintText: "Post title",
                  textFieldController: titleController,
                  onChanged: (value) => setState(() {}),
                ),
                const SizedBox(
                  height: 16,
                ),
                AppTextField(
                  textFieldHeader: "Body",
                  hintText: "Post body",
                  textFieldController: bodyController,
                  onChanged: (value) => setState(() {}),
                ),
                const SizedBox(
                  height: 80,
                ),
                AppPrimaryButton(
                  buttonText: isLoading ? "Loading..." : "Edit",
                  buttonColor: titleController.text.isEmpty ||
                          bodyController.text.isEmpty ||
                          isLoading
                      ? Colors.grey
                      : const Color(0xFF004C11),
                  onPressed: isLoading
                      ? () {} // Disable button during loading
                      : () {
                          if (titleController.text.isEmpty ||
                              bodyController.text.isEmpty) {
                          } else {
                            BlocProvider.of<PostBloc>(context).add(EditPosts(
                              widget.id.toString(),
                              widget.userId.toString(),
                              titleController.text,
                              bodyController.text,
                            ));
                          }
                        },
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
