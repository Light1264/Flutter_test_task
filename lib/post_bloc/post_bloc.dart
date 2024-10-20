// post_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../util/api_service.dart';
import 'post_event.dart';
import '../models/post_list_model.dart';
import 'post_states.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final ApiService apiService;

  PostBloc({required this.apiService}) : super(PostLoading()) {
    on<FetchPosts>(_onFetchPosts);
    on<AddPosts>(_onAddPosts);
    on<DeletePosts>(_onDeletePosts);
    on<EditPosts>(_onEditPosts);
  }

  void _onFetchPosts(FetchPosts event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      final List<PostListModel> posts = await apiService.fetchPosts();
      emit(PostLoaded(items: posts));
    } catch (e) {
      emit(PostError(message: e.toString()));
    }
  }

  void _onAddPosts(AddPosts event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      apiService.addPost(event.userId, event.title, event.body);
      emit(AddEditPostLoaded());
    } catch (e) {
      emit(PostError(message: e.toString()));
    }
  }

  void _onDeletePosts(
      DeletePosts event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      apiService.deletePost(event.id);
    } catch (e) {
      emit(PostError(message: e.toString()));
    }
  }

    void _onEditPosts(
      EditPosts event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      apiService.editPost(event.id, event.userId, event.title, event.body);

      emit(AddEditPostLoaded());
    } catch (e) {
      emit(PostError(message: e.toString()));
    }
  }
}
