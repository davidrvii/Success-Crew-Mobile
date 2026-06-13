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
import '../../features/attendance/presentation/controllers/attendance_controller.dart';

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

  // Controllers
  sl.registerFactory<AttendanceController>(
    () => AttendanceController(
      session: sl<UserSession>(),
      checkInUseCase: sl<CheckInUseCase>(),
      checkOutUseCase: sl<CheckOutUseCase>(),
      getAttendanceDetailUseCase: sl<GetAttendanceDetailUseCase>(),
      getAttendanceHistoryUseCase: sl<GetAttendanceHistoryUseCase>(),
    ),
  );
}
