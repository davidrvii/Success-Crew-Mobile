import 'package:get_it/get_it.dart';

import '../network/dio_client.dart';
import '../storage/user_session.dart';

import '../../features/leave/data/datasources/leave_remote_datasource.dart';
import '../../features/leave/data/repositories/leave_repository_impl.dart';
import '../../features/leave/domain/repositories/leave_repository.dart';
import '../../features/leave/domain/usecases/get_leave_list.dart';
import '../../features/leave/domain/usecases/get_leave_detail.dart';
import '../../features/leave/domain/usecases/create_leave.dart';
import '../../features/leave/domain/usecases/update_leave.dart';
import '../../features/leave/domain/usecases/delete_leave.dart';
import '../../features/leave/presentation/controllers/leave_controller.dart';

import '../../features/attendance/domain/usecases/get_attendance_history.dart';
import '../../features/out_of_office/domain/usecases/get_out_of_office_list.dart';

void registerLeaveDi(GetIt sl) {
  // Data Sources
  sl.registerLazySingleton<LeaveRemoteDataSource>(
    () => LeaveRemoteDataSourceImpl(sl<DioClient>()),
  );

  // Repositories
  sl.registerLazySingleton<LeaveRepository>(
    () => LeaveRepositoryImpl(sl<LeaveRemoteDataSource>(), sl<UserSession>()),
  );

  // UseCases
  sl.registerLazySingleton<GetLeaveListUseCase>(
    () => GetLeaveListUseCase(sl<LeaveRepository>()),
  );
  sl.registerLazySingleton<GetLeaveDetailUseCase>(
    () => GetLeaveDetailUseCase(sl<LeaveRepository>()),
  );
  sl.registerLazySingleton<CreateLeaveUseCase>(
    () => CreateLeaveUseCase(sl<LeaveRepository>()),
  );
  sl.registerLazySingleton<UpdateLeaveUseCase>(
    () => UpdateLeaveUseCase(sl<LeaveRepository>()),
  );
  sl.registerLazySingleton<DeleteLeaveUseCase>(
    () => DeleteLeaveUseCase(sl<LeaveRepository>()),
  );

  // Controllers
  sl.registerFactory<LeaveController>(
    () => LeaveController(
      getLeaveList: sl<GetLeaveListUseCase>(),
      getLeaveDetail: sl<GetLeaveDetailUseCase>(),
      createLeave: sl<CreateLeaveUseCase>(),
      updateLeave: sl<UpdateLeaveUseCase>(),
      deleteLeave: sl<DeleteLeaveUseCase>(),
      userSession: sl<UserSession>(),
      getAttendanceHistoryUseCase: sl<GetAttendanceHistoryUseCase>(),
      getOutOfOfficeListUseCase: sl<GetOutOfOfficeListUseCase>(),
    ),
  );
}
