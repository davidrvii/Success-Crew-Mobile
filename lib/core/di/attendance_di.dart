/// File: lib/core/di/attendance_di.dart
/// Generated Documentation for attendance_di.dart

import 'package:get_it/get_it.dart';

import '../network/dio_client.dart';
import '../storage/user_session.dart';

import '../../features/attendance/data/datasources/attendance_remote_datasource.dart';
import '../../features/attendance/data/repositories/attendance_repository_impl.dart';
import '../../features/attendance/domain/repositories/attendance_repository.dart';
import '../../features/attendance/domain/usecases/checkin.dart';
import '../../features/attendance/domain/usecases/checkout.dart';
import '../../features/attendance/domain/usecases/get_attendance_detail.dart';
import '../../features/attendance/domain/usecases/get_attendance_history.dart';
import '../../features/attendance/domain/usecases/get_attendance_basic.dart';
import '../../features/attendance/domain/usecases/get_all_attendance.dart';
import '../../features/attendance/domain/usecases/get_crew_attendance_history.dart';
import '../../features/attendance/domain/usecases/add_attendance.dart';
import '../../features/attendance/domain/usecases/update_attendance.dart';
import '../../features/attendance/domain/usecases/delete_attendance.dart';
import '../../features/attendance/presentation/controllers/attendance_controller.dart';

import '../../features/leave/domain/usecases/get_leave_list.dart';
import '../../features/out_of_office/domain/usecases/get_out_of_office_list.dart';

/// Method `registerAttendanceDi` returning `void`.
/// Handles logic operations related to `registerAttendanceDi`.
void registerAttendanceDi(GetIt sl) {
  // Data Sources
  sl.registerLazySingleton<AttendanceRemoteDataSource>(
    () => AttendanceRemoteDataSourceImpl(sl<DioClient>()),
  );

  // Repositories
  sl.registerLazySingleton<AttendanceRepository>(
    () => AttendanceRepositoryImpl(
      sl<AttendanceRemoteDataSource>(),
      sl<UserSession>(),
    ),
  );

  // UseCases
  sl.registerLazySingleton<CheckInUseCase>(
    () => CheckInUseCase(sl<AttendanceRepository>()),
  );
  sl.registerLazySingleton<CheckOutUseCase>(
    () => CheckOutUseCase(sl<AttendanceRepository>()),
  );
  sl.registerLazySingleton<GetAttendanceDetailUseCase>(
    () => GetAttendanceDetailUseCase(sl<AttendanceRepository>()),
  );
  sl.registerLazySingleton<GetAttendanceHistoryUseCase>(
    () => GetAttendanceHistoryUseCase(sl<AttendanceRepository>()),
  );
  sl.registerLazySingleton<GetAttendanceBasicUseCase>(
    () => GetAttendanceBasicUseCase(sl<AttendanceRepository>()),
  );
  sl.registerLazySingleton<GetAllAttendanceUseCase>(
    () => GetAllAttendanceUseCase(sl<AttendanceRepository>()),
  );
  sl.registerLazySingleton<GetCrewAttendanceHistoryUseCase>(
    () => GetCrewAttendanceHistoryUseCase(sl<AttendanceRepository>()),
  );
  sl.registerLazySingleton<AddAttendanceUseCase>(
    () => AddAttendanceUseCase(sl<AttendanceRepository>()),
  );
  sl.registerLazySingleton<UpdateAttendanceUseCase>(
    () => UpdateAttendanceUseCase(sl<AttendanceRepository>()),
  );
  sl.registerLazySingleton<DeleteAttendanceUseCase>(
    () => DeleteAttendanceUseCase(sl<AttendanceRepository>()),
  );

  // Controllers
  sl.registerFactory<AttendanceController>(
    () => AttendanceController(
      session: sl<UserSession>(),
      checkInUseCase: sl<CheckInUseCase>(),
      checkOutUseCase: sl<CheckOutUseCase>(),
      getAttendanceDetailUseCase: sl<GetAttendanceDetailUseCase>(),
      getAttendanceHistoryUseCase: sl<GetAttendanceHistoryUseCase>(),
      getLeaveListUseCase: sl<GetLeaveListUseCase>(),
      getOutOfOfficeListUseCase: sl<GetOutOfOfficeListUseCase>(),
    ),
  );
}
