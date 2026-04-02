part of 'remove_favorites_bloc.dart';

sealed class RemoveFavoritesState extends Equatable {
  const RemoveFavoritesState();
  
  @override
  List<Object> get props => [];
}

final class RemoveFavoritesInitial extends RemoveFavoritesState {}
