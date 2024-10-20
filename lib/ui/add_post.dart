import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../util/api_service.dart';
import '../post_bloc/post_event.dart';
import '../post_bloc/post_bloc.dart';
import '../post_bloc/post_states.dart';
import '../util/snackbar.dart';
import '../widgets/app_botton.dart';
import '../widgets/app_textField.dart';

class AddPostBloc extends StatelessWidget {
  const AddPostBloc({super.key});

  @override
  Widget build(BuildContext context) {
   return BlocProvider(
      create: (context) => PostBloc(apiService: ApiService()),
      child: const AddPost(),
    );
  }
}

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  TextEditingController userIdController = TextEditingController();
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
          showSnackBar(context, "Successfully added post");
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
                  "Add Post",
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
                const SizedBox(
                  height: 24,
                ),
                AppTextField(
                  textFieldHeader: "UserId",
                  hintText: "1",
                  textInputType: TextInputType.number,
                  textFieldController: userIdController,
                  onChanged: (value) => setState(() {}),
                ),
                const SizedBox(
                  height: 16,
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
                  buttonText: isLoading ? "Loading..." : "Add",
                  buttonColor: userIdController.text.isEmpty ||
                          titleController.text.isEmpty ||
                          bodyController.text.isEmpty ||
                          isLoading
                      ? Colors.grey
                      : const Color(0xFF004C11),
                  onPressed: isLoading
                      ? () {} // Disable button during loading
                      : () {
                          if (userIdController.text.isEmpty ||
                              titleController.text.isEmpty ||
                              bodyController.text.isEmpty) {
                          } else {
                            BlocProvider.of<PostBloc>(context).add(AddPosts(
                              userIdController.text,
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
