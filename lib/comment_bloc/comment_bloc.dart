// post_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_task/comment_bloc/comment_event.dart';
import 'package:flutter_test_task/models/comments_list_model.dart';
import '../util/api_service.dart';
import 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final ApiService apiService;

  CommentBloc({required this.apiService}) : super(CommentLoading()) {
    on<FetchComments>(_onFetchComments);
  }


  void _onFetchComments(FetchComments event, Emitter<CommentState> emit) async {
    emit(CommentLoading());
    try {
      final List<CommentsListModel> comments = await apiService.fetchComments("posts/${event.userId}/comments");
      emit(CommentLoaded(items: comments));
    } catch (e) {
      emit(CommentError(message: e.toString()));
    }
  }
}
