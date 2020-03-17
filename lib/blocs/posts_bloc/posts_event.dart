part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();
}

class GetPosts extends PostsEvent {
  @override
  List<Object> get props => [];
}

class Search extends PostsEvent {
  final String word;
  Search(this.word);
  @override
  List<Object> get props => [];
}

class GetFavorites extends PostsEvent {
  @override
  List<Object> get props => [];
}

class AddFavorite extends PostsEvent {
  @override
  List<Object> get props => [];
}

class DeleteFavorite extends PostsEvent {
  @override
  List<Object> get props => [];
}

class CallRequest extends PostsEvent {
  @override
  List<Object> get props => [];
}
