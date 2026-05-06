import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'data/managers/dio/api_manager.dart';
import 'data/managers/dio/data_source.dart';
import 'data/managers/dio/dio_factory.dart';
import 'data/managers/dio/network_info.dart';
import 'data/managers/preferences/preference_manager.dart';
import 'data/repositories/brief_repository_impl.dart';
import 'domain/repositories/brief_repository.dart';
import 'domain/usecases/analyze_brief_usecase.dart';
import 'domain/usecases/extract_pdf_usecase.dart';
import 'presentation/bloc/brief/brief_bloc.dart';
import 'presentation/bloc/theme/theme_bloc.dart';
import 'presentation/bloc/ticket/ticket_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> initDependencies() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  sl.registerLazySingleton<SharedPreferences>(() => prefs);
  sl.registerLazySingleton<Connectivity>(Connectivity.new);
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<PreferenceManager>(() => PreferenceManager(sl()));
  sl.registerLazySingleton(() => DioFactory.create());
  sl.registerLazySingleton<ApiManager>(() => ApiManager(sl()));
  sl.registerLazySingleton<BriefRemoteDataSource>(() => BriefRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<BriefRepository>(() => BriefRepositoryImpl(sl()));

  sl.registerLazySingleton<AnalyzeBriefUseCase>(() => AnalyzeBriefUseCase(sl()));
  sl.registerLazySingleton<ExtractPdfUseCase>(() => ExtractPdfUseCase(sl()));

  sl.registerFactory<ThemeBloc>(ThemeBloc.new);
  sl.registerFactory<TicketBloc>(TicketBloc.new);
  sl.registerFactory<BriefBloc>(
    () => BriefBloc(
      analyzeBriefUseCase: sl(),
      extractPdfUseCase: sl(),
    ),
  );
}
