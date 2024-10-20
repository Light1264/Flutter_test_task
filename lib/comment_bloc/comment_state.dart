// Comment_state.dart
import 'package:equatable/equatable.dart';
import 'package:flutter_test_task/models/comments_list_model.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

class CommentLoading extends CommentState {}

class CommentLoaded extends CommentState {
  final List<CommentsListModel> items;

  const CommentLoaded({required this.items});

  @override
  List<Object> get props => [items];
}

class CommentError extends CommentState {
  final String message;

  const CommentError({required this.message});

  @override
  List<Object> get props => [message];
}
