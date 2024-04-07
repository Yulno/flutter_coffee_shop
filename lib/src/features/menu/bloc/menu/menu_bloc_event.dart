part of 'menu_bloc_bloc.dart';

@immutable
sealed class MenuEvent{
  const MenuEvent();
}

class LoadCategoryEvent extends MenuEvent {
  const LoadCategoryEvent();

  @override
  String toString() => 'LoadCategoryEvent';

}

class LoadPageEvent extends MenuEvent {

  const LoadPageEvent();

  @override
  String toString() => 'LoadPageEvent';

}