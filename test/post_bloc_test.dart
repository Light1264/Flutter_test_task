import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_task/comment_bloc/comment_bloc.dart';
import 'package:flutter_test_task/comment_bloc/comment_event.dart';
import 'package:flutter_test_task/comment_bloc/comment_state.dart';
import 'package:flutter_test_task/models/comments_list_model.dart';
import 'package:flutter_test_task/models/post_list_model.dart';
import 'package:flutter_test_task/post_bloc/post_bloc.dart';
import 'package:flutter_test_task/post_bloc/post_event.dart';
import 'package:flutter_test_task/post_bloc/post_states.dart';
import 'package:mockito/mockito.dart';
import 'api_service_mock.mocks.dart';

void main() {
  late PostBloc postBloc;
  late CommentBloc commentBloc;
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
    postBloc = PostBloc(apiService: mockApiService);
    commentBloc = CommentBloc(apiService: mockApiService);
  });

  tearDown(() {
    postBloc.close();
    commentBloc.close();
  });

  group('fetchPosts event', () {
    // Test when fetchPosts is successful
    blocTest<PostBloc, PostState>(
      'emits [PostLoading, PostLoaded] when fetchPosts is successful',
      build: () {
        when(mockApiService.fetchPosts()).thenAnswer((_) async => [
              const PostListModel(
                  id: 1, title: 'Post 1', body: 'Body 1', userId: 1),
              const PostListModel(
                  id: 2, title: 'Post 2', body: 'Body 2', userId: 1),
            ]);
        return postBloc;
      },
      act: (bloc) => bloc.add(FetchPosts()),
      expect: () => [
        PostLoading(),
        const PostLoaded(items: [
          PostListModel(id: 1, title: 'Post 1', body: 'Body 1', userId: 1),
          PostListModel(id: 2, title: 'Post 2', body: 'Body 2', userId: 1),
        ]),
      ],
    );

    // Test when fetchPosts fails
    blocTest<PostBloc, PostState>(
      'emits [PostLoading, PostError] when fetchPosts fails',
      build: () {
        when(mockApiService.fetchPosts())
            .thenThrow(Exception('Failed to fetch posts'));
        return postBloc;
      },
      act: (bloc) => bloc.add(FetchPosts()),
      expect: () => [
        PostLoading(),
        const PostError(message: 'Exception: Failed to fetch posts'),
      ],
    );
  });

  group('AddPosts event', () {
    const userId = "1";
    const title = 'Test title';
    const body = 'Test body';

    // Test when AddPost is successful
    blocTest<PostBloc, PostState>(
      'emits [PostLoading, PostLoaded] when AddPosts is successful',
      build: () {
        when(mockApiService.addPost(userId.toString(), title, body)).thenAnswer(
            (_) async => {
                  "id": 101,
                  "title": title,
                  "body": body,
                  "userId": userId.toString()
                });
        return postBloc;
      },
      act: (bloc) => bloc.add(AddPosts(userId, title, body)),
      expect: () => [
        PostLoading(),
        AddEditPostLoaded(),
      ],
      verify: (_) {
        verify(mockApiService.addPost(userId.toString(), title, body))
            .called(1);
      },
    );

    // Test when AddPosts fails
    blocTest<PostBloc, PostState>(
      'emits [PostLoading, PostError] when AddPosts fails',
      build: () {
        when(mockApiService.addPost(userId.toString(), title, body))
            .thenThrow(Exception('Failed to add post'));
        return postBloc;
      },
      act: (bloc) => bloc.add(AddPosts(userId, title, body)),
      expect: () => [
        PostLoading(),
        isA<PostError>(),
      ],
      verify: (_) {
        verify(mockApiService.addPost(userId.toString(), title, body))
            .called(1);
      },
    );
  });

  group('EditPost event', () {
    const userId = "1";
    const title = 'Test title';
    const body = 'Test body';
    const id = "1";

    // Test when EditPost is successful
    blocTest<PostBloc, PostState>(
      'emits [PostLoading, PostLoaded] when AddPosts is successful',
      build: () {
        when(mockApiService.editPost(id, userId.toString(), title, body))
            .thenAnswer((_) async => {
                  "id": id,
                  "title": title,
                  "body": body,
                  "userId": userId.toString()
                });
        return postBloc;
      },
      act: (bloc) => bloc.add(EditPosts(id, userId, title, body)),
      expect: () => [
        PostLoading(),
        AddEditPostLoaded(),
      ],
      verify: (_) {
        verify(mockApiService.editPost(id, userId.toString(), title, body))
            .called(1);
      },
    );

    // Test when EditPosts fails
    blocTest<PostBloc, PostState>(
      'emits [PostLoading, PostError] when AddPosts fails',
      build: () {
        when(mockApiService.editPost(id, userId.toString(), title, body))
            .thenThrow(Exception('Failed to add post'));
        return postBloc;
      },
      act: (bloc) => bloc.add(EditPosts(id, userId, title, body)),
      expect: () => [
        PostLoading(),
        isA<PostError>(),
      ],
      verify: (_) {
        verify(mockApiService.editPost(id, userId.toString(), title, body))
            .called(1);
      },
    );
  });

  group('DeletePosts event', () {
    const postId = 1;
    // Test when DeletePost is successful

    blocTest<PostBloc, PostState>(
      'emits [PostLoading, PostLoaded] when DeletePost is successful',
      build: () {
        when(mockApiService.deletePost(postId))
            .thenAnswer((_) async => "Post deleted");
        return postBloc;
      },
      act: (bloc) => bloc.add(DeletePosts(postId)),
      expect: () => [
        PostLoading(),
        // PostLoaded(),
      ],
      verify: (_) {
        verify(mockApiService.deletePost(postId)).called(1);
      },
    );

    // Test when DeletePost fails

    blocTest<PostBloc, PostState>(
      'emits [PostLoading, PostError] when DeletePost fails',
      build: () {
        when(mockApiService.deletePost(postId))
            .thenThrow(Exception('Failed to delete post'));
        return postBloc;
      },
      act: (bloc) => bloc.add(DeletePosts(postId)),
      expect: () => [
        PostLoading(),
        isA<PostError>(),
      ],
      verify: (_) {
        verify(mockApiService.deletePost(postId)).called(1);
      },
    );
  });

  group('fetchComments event', () {
    // Test when fetchComment is successful
    blocTest<CommentBloc, CommentState>(
      'emits [PostLoading, PostLoaded] when fetchPosts is successful',
      build: () {
        when(mockApiService.fetchComments("posts/1/comments"))
            .thenAnswer((_) async => [
                  const CommentsListModel(
                    postId: 1,
                    id: 1,
                    name: 'Post 1',
                    email: "email1@gmail.com",
                    body: 'Body 1',
                  ),
                  const CommentsListModel(
                    postId: 2,
                    id: 2,
                    name: 'Post 2',
                    email: "email2@gmail.com",
                    body: 'Body 2',
                  ),
                ]);
        return commentBloc;
      },
      act: (bloc) => bloc.add(FetchComments(1)),
      expect: () => [
        CommentLoading(),
        const CommentLoaded(items: [
          CommentsListModel(
            postId: 1,
            id: 1,
            name: 'Post 1',
            email: "email1@gmail.com",
            body: 'Body 1',
          ),
          CommentsListModel(
            postId: 2,
            id: 2,
            name: 'Post 2',
            email: "email2@gmail.com",
            body: 'Body 2',
          ),
        ]),
      ],
    );

    // Test when fetchComments fails
    blocTest<CommentBloc, CommentState>(
      'emits [PostLoading, PostError] when fetchComments fails',
      build: () {
        when(mockApiService.fetchComments("posts/1/comments"))
            .thenThrow(Exception('Failed to fetch comments'));
        return commentBloc;
      },
      act: (bloc) => bloc.add(FetchComments(1)),
      expect: () => [
        CommentLoading(),
        const CommentError(message: 'Exception: Failed to fetch comments'),
      ],
    );
  });
}
