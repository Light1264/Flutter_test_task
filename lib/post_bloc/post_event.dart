// post_event.dart

abstract class PostEvent {}

class FetchPosts extends PostEvent {}

class EditPosts extends PostEvent {
    EditPosts(
      this.id,
    this.userId,
    this.title,
    this.body,
  );
  
  final String id;
  final String userId;
  final String title;
  final String body;
}

class DeletePosts extends PostEvent {
  DeletePosts(
    this.id,
  );

  final int id;
}

class AddPosts extends PostEvent {
  AddPosts(
    this.userId,
    this.title,
    this.body,
  );

  final String userId;
  final String title;
  final String body;
}
