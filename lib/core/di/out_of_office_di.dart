/// File: lib/core/di/out_of_office_di.dart
/// Generated Documentation for out_of_office_di.dart

import 'package:get_it/get_it.dart';

import '../network/dio_client.dart';
import '../storage/user_session.dart';

import '../../features/out_of_office/data/datasources/out_of_office_remote_datasource.dart';
import '../../features/out_of_office/data/repositories/out_of_office_repository_impl.dart';
import '../../features/out_of_office/domain/repositories/out_of_office_repository.dart';
import '../../features/out_of_office/domain/usecases/get_out_of_office_list.dart';
import '../../features/out_of_office/domain/usecases/get_out_of_office_detail.dart';
import '../../features/out_of_office/domain/usecases/create_out_of_office.dart';
import '../../features/out_of_office/domain/usecases/update_out_of_office.dart';
import '../../features/out_of_office/domain/usecases/delete_out_of_office.dart';
import '../../features/out_of_office/domain/usecases/get_out_of_office_basic_all.dart';
import '../../features/out_of_office/domain/usecases/get_out_of_office_basic_detail.dart';
import '../../features/out_of_office/domain/usecases/update_out_of_office_status.dart';
import '../../features/out_of_office/presentation/controllers/out_of_office_controller.dart';

import '../../features/attendance/domain/usecases/get_attendance_history.dart';
import '../../features/leave/domain/usecases/get_leave_list.dart';

/// Method `registerOutOfOfficeDi` returning `void`.
/// Handles logic operations related to `registerOutOfOfficeDi`.
void registerOutOfOfficeDi(GetIt sl) {
  // Data Sources
  sl.registerLazySingleton<OutOfOfficeRemoteDataSource>(
    () => OutOfOfficeRemoteDataSourceImpl(sl<DioClient>()),
  );

  // Repositories
  sl.registerLazySingleton<OutOfOfficeRepository>(
    () => OutOfOfficeRepositoryImpl(sl<OutOfOfficeRemoteDataSource>(), sl<UserSession>()),
  );

  // UseCases
  sl.registerLazySingleton<GetOutOfOfficeListUseCase>(
    () => GetOutOfOfficeListUseCase(sl<OutOfOfficeRepository>()),
  );
  sl.registerLazySingleton<GetOutOfOfficeDetailUseCase>(
    () => GetOutOfOfficeDetailUseCase(sl<OutOfOfficeRepository>()),
  );
  sl.registerLazySingleton<CreateOutOfOfficeUseCase>(
    () => CreateOutOfOfficeUseCase(sl<OutOfOfficeRepository>()),
  );
  sl.registerLazySingleton<UpdateOutOfOfficeUseCase>(
    () => UpdateOutOfOfficeUseCase(sl<OutOfOfficeRepository>()),
  );
  sl.registerLazySingleton<DeleteOutOfOfficeUseCase>(
    () => DeleteOutOfOfficeUseCase(sl<OutOfOfficeRepository>()),
  );
  sl.registerLazySingleton<GetOutOfOfficeBasicAllUseCase>(
    () => GetOutOfOfficeBasicAllUseCase(sl<OutOfOfficeRepository>()),
  );
  sl.registerLazySingleton<GetOutOfOfficeBasicDetailUseCase>(
    () => GetOutOfOfficeBasicDetailUseCase(sl<OutOfOfficeRepository>()),
  );
  sl.registerLazySingleton<UpdateOutOfOfficeStatusUseCase>(
    () => UpdateOutOfOfficeStatusUseCase(sl<OutOfOfficeRepository>()),
  );

  // Controllers
  sl.registerFactory<OutOfOfficeController>(
    () => OutOfOfficeController(
      getOutOfOfficeList: sl<GetOutOfOfficeListUseCase>(),
      createOutOfOffice: sl<CreateOutOfOfficeUseCase>(),
      updateOutOfOffice: sl<UpdateOutOfOfficeUseCase>(),
      deleteOutOfOffice: sl<DeleteOutOfOfficeUseCase>(),
      userSession: sl<UserSession>(),
      getAttendanceHistoryUseCase: sl<GetAttendanceHistoryUseCase>(),
      getLeaveListUseCase: sl<GetLeaveListUseCase>(),
    ),
  );
}
