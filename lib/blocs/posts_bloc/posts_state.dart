part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();
}

class PostsInitial extends PostsState {
  @override
  List<Object> get props => [];
}
class HasData extends PostsState {
  @override
  List<Object> get props => [];
}
class Loading extends PostsState {
  @override
  List<Object> get props => [];
}
class Update extends PostsState {
  @override
  List<Object> get props => [];
}
class Error extends PostsState {
  @override
  List<Object> get props => [];
}
