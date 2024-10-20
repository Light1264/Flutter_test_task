// post_event.dart

abstract class CommentEvent {}


class FetchComments extends CommentEvent {
  final int userId;

  FetchComments(this.userId);
}
