part of 'get_favorites_bloc.dart';

sealed class GetFavoritesState extends Equatable {
  const GetFavoritesState();
  
  @override
  List<Object> get props => [];
}

final class GetFavoritesInitial extends GetFavoritesState {}
