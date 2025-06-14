import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vasd/repositories/auth/auth.dart';
import 'package:vasd/repositories/notification/notification.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final AuthInterface _authRepo;
  final NotificationSupabaseRepo _notificationSupabaseRepo;

  NotificationsBloc({
    required AuthInterface authRepo,
    required NotificationSupabaseRepo notificationSupabaseRepo,
  })  : _notificationSupabaseRepo = notificationSupabaseRepo,
        _authRepo = authRepo,
        super(const NotificationsLoaded()) {
    on<NotificationsLoad>((event, emit) async {
      emit(NotificationsLoading(notifications: state.notifications));

      try {
        if (_authRepo.user == null) {
          throw Exception("User is null");
        }

        List<Notification> notifications = await _notificationSupabaseRepo.getNotificationsByUser(userId: _authRepo.user!.id);

        emit(NotificationsLoaded(notifications: notifications));
      } catch (e) {
        emit(NotificationsError(notifications: state.notifications, error: e));
      }
    });
  }
}
