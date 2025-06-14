part of 'notifications_bloc.dart';

sealed class NotificationsState extends Equatable {
  const NotificationsState({
    this.notifications = const [],
  });

  final List<Notification> notifications;

  @override
  List<Object> get props => [];
}

final class NotificationsLoaded extends NotificationsState {
  const NotificationsLoaded({
    super.notifications,
  });
}

final class NotificationsLoading extends NotificationsState {
  const NotificationsLoading({
    super.notifications,
  });
}

final class NotificationsError extends NotificationsState {
  const NotificationsError({
    super.notifications,
    this.error,
  });

  final Object? error;
}
