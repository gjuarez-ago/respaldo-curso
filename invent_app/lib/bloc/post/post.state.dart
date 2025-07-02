import 'package:invent_app/models/post_response.model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<Post> posts;
  PostLoaded(this.posts);
}

class PostError extends PostState {
  final String error;
  PostError(this.error);
}