import 'package:bloc/bloc.dart';
import 'package:invent_app/bloc/post/post.event.dart';
import 'package:invent_app/bloc/post/post.state.dart';
import 'package:invent_app/services/post.service.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostService service = PostService();

  PostBloc() : super(PostInitial()) {
    on<FetchPosts>(_onFetchPosts);
    // on<DeletePost>(_onDeletePost);
  }

  Future<void> _onFetchPosts(FetchPosts event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      final posts = await service.fetchPosts();
      emit(PostLoaded(posts));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  // Future<void> _onDeletePost(DeletePost event, Emitter<PostState> emit) async {
  //   try {
  //     await service.deletePost(event.postId);
  //     emit(PostDeletedSuccess(event.postId));
  //   } catch (e) {
  //     emit(PostError("Error al eliminar el post"));
  //   }
  // }
}