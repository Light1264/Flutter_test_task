// post_state.dart
import 'package:equatable/equatable.dart';
import '../models/post_list_model.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<PostListModel> items;

  const PostLoaded({required this.items});

  @override
  List<Object> get props => [items];
}

class AddEditPostLoaded extends PostState {}

class PostError extends PostState {
  final String message;

  const PostError({required this.message});

  @override
  List<Object> get props => [message];
}
