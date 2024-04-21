part of 'menu_bloc_bloc.dart';

@immutable
sealed class MenuEvent extends Equatable {
  const MenuEvent();
}

class LoadCategoryEvent extends MenuEvent {
  const LoadCategoryEvent();

  @override
  String toString() => 'LoadCategoryEvent';

  @override
  List<Object?> get props => [];
}

class LoadPageEvent extends MenuEvent {
  const LoadPageEvent();

  @override
  String toString() => 'LoadPageEvent';

  @override
  List<Object?> get props => [];
}


