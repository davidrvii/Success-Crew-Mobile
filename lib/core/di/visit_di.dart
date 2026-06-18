import 'package:get_it/get_it.dart';

import '../../features/visitor_tracker/data/datasources/visit_remote_datasource.dart';
import '../../features/visitor_tracker/data/repositories/visit_repository_impl.dart';
import '../../features/visitor_tracker/domain/repositories/visit_repository.dart';
import '../../features/visitor_tracker/domain/usecases/get_visits.dart';
import '../../features/visitor_tracker/domain/usecases/get_visit_stats.dart';
import '../../features/visitor_tracker/domain/usecases/create_visit.dart';
import '../../features/visitor_tracker/domain/usecases/get_visit_detail.dart';
import '../../features/visitor_tracker/domain/usecases/get_followup.dart';
import '../../features/visitor_tracker/domain/usecases/get_product_sold.dart';
import '../../features/visitor_tracker/domain/usecases/get_unit_serviced.dart';
import '../../features/visitor_tracker/domain/usecases/create_followup.dart';
import '../../features/visitor_tracker/domain/usecases/create_product_sold.dart';
import '../../features/visitor_tracker/domain/usecases/create_unit_serviced.dart';
import '../../features/visitor_tracker/domain/usecases/delete_followup.dart';
import '../../features/visitor_tracker/domain/usecases/delete_product_sold.dart';
import '../../features/visitor_tracker/domain/usecases/delete_unit_serviced.dart';
import '../../features/visitor_tracker/domain/usecases/delete_visit.dart';
import '../../features/visitor_tracker/domain/usecases/get_visitors.dart';
import '../../features/visitor_tracker/domain/usecases/get_visitor_detail.dart';
import '../../features/visitor_tracker/domain/usecases/create_visitor.dart';
import '../../features/visitor_tracker/domain/usecases/update_visitor.dart';
import '../../features/visitor_tracker/domain/usecases/delete_visitor.dart';
import '../../features/visitor_tracker/domain/usecases/get_all_units_serviced.dart';
import '../../features/visitor_tracker/domain/usecases/add_unit_serviced.dart';
import '../../features/visitor_tracker/domain/usecases/update_unit_serviced_non_nested.dart';
import '../../features/visitor_tracker/domain/usecases/delete_unit_serviced_non_nested.dart';
import '../../features/visitor_tracker/domain/usecases/get_all_products_sold.dart';
import '../../features/visitor_tracker/domain/usecases/add_product_sold.dart';
import '../../features/visitor_tracker/domain/usecases/update_product_sold_non_nested.dart';
import '../../features/visitor_tracker/domain/usecases/delete_product_sold_non_nested.dart';
import '../../features/visitor_tracker/domain/usecases/get_all_followups.dart';
import '../../features/visitor_tracker/domain/usecases/add_followup.dart';
import '../../features/visitor_tracker/domain/usecases/update_followup_non_nested.dart';
import '../../features/visitor_tracker/domain/usecases/delete_followup_non_nested.dart';

import '../../features/visitor_tracker/presentation/controllers/visit_controller.dart';
import '../../features/visitor_tracker/presentation/controllers/visit_detail_controller.dart';

import '../network/dio_client.dart';

void registerVisitDi(GetIt sl) {
  // datasource
  sl.registerLazySingleton<VisitRemoteDataSource>(
    () => VisitRemoteDataSourceImpl(sl<DioClient>()),
  );

  // repo
  sl.registerLazySingleton<VisitRepository>(() => VisitRepositoryImpl(sl()));

  // usecase
  sl.registerLazySingleton(() => GetVisitsUseCase(sl()));
  sl.registerLazySingleton(() => GetVisitStatsUseCase(sl()));
  sl.registerLazySingleton(() => CreateVisitUseCase(sl()));
  sl.registerLazySingleton(() => GetVisitDetailUseCase(sl()));
  sl.registerLazySingleton(() => GetFollowUpsUseCase(sl()));
  sl.registerLazySingleton(() => GetProductsSoldUseCase(sl()));
  sl.registerLazySingleton(() => GetUnitsServicedUseCase(sl()));
  sl.registerLazySingleton(() => CreateFollowUpUseCase(sl()));
  sl.registerLazySingleton(() => CreateProductSoldUseCase(sl()));
  sl.registerLazySingleton(() => CreateUnitServicedUseCase(sl()));
  sl.registerLazySingleton(() => DeleteFollowUpUseCase(sl()));
  sl.registerLazySingleton(() => DeleteProductSoldUseCase(sl()));
  sl.registerLazySingleton(() => DeleteUnitServicedUseCase(sl()));
  sl.registerLazySingleton(() => DeleteVisitUseCase(sl()));
  sl.registerLazySingleton(() => GetVisitorsUseCase(sl()));
  sl.registerLazySingleton(() => GetVisitorDetailUseCase(sl()));
  sl.registerLazySingleton(() => CreateVisitorUseCase(sl()));
  sl.registerLazySingleton(() => UpdateVisitorUseCase(sl()));
  sl.registerLazySingleton(() => DeleteVisitorUseCase(sl()));
  sl.registerLazySingleton(() => GetAllUnitsServicedUseCase(sl()));
  sl.registerLazySingleton(() => AddUnitServicedUseCase(sl()));
  sl.registerLazySingleton(() => UpdateUnitServicedNonNestedUseCase(sl()));
  sl.registerLazySingleton(() => DeleteUnitServicedNonNestedUseCase(sl()));
  sl.registerLazySingleton(() => GetAllProductsSoldUseCase(sl()));
  sl.registerLazySingleton(() => AddProductSoldUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProductSoldNonNestedUseCase(sl()));
  sl.registerLazySingleton(() => DeleteProductSoldNonNestedUseCase(sl()));
  sl.registerLazySingleton(() => GetAllFollowUpsUseCase(sl()));
  sl.registerLazySingleton(() => AddFollowUpUseCase(sl()));
  sl.registerLazySingleton(() => UpdateFollowUpNonNestedUseCase(sl()));
  sl.registerLazySingleton(() => DeleteFollowUpNonNestedUseCase(sl()));

  // controller
  sl.registerFactory(() => VisitorController(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => VisitDetailController(
        sl(), sl(), sl(), sl(), 
        sl(), sl(), sl(), 
        sl(), sl(), sl(), sl(),
      ));
}
