import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_task/post_bloc/post_event.dart';

import 'api_service.dart';
import '../post_bloc/post_bloc.dart';
import 'snackbar.dart';

showMyDialog(
  BuildContext context,
  int id,
) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext dialogContext) {
      return BlocProvider(
        create: (context) => PostBloc(apiService: ApiService()),
        child: Builder(
          // This Builder gives the correct context to access BlocProvider
          builder: (blocContext) {
            return AlertDialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 15),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
              actionsPadding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              content: const Text(
                "Are you sure you want to delete this post",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Use the blocContext from the Builder to access the BlocProvider
                        BlocProvider.of<PostBloc>(blocContext)
                            .add(DeletePosts(id));
                        Navigator.pop(context);
                        Navigator.pop(
                            context); // Close the dialog after deleting
                        showSnackBar(context, "Post deleted");
                      },
                      child: const Text(
                        "Yes",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "No",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Color(0xFF004C11),
                        ),
                      ),
                    )
                  ],
                )
              ],
            );
          },
        ),
      );
    },
  );
}
