import 'package:clinic/core/services/data_service.dart';
import 'package:clinic/features/home/data/repos/home_repo_impl.dart';
import 'package:clinic/features/home/domain/repos/home_repo.dart';
import 'package:clinic/features/home/presentation/bloc/home_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupHomeDependencies() {
  // Home Repository
  if (!getIt.isRegistered<HomeRepo>()) {
    getIt.registerSingleton<HomeRepo>(
      HomeRepoImpl(
        databaseService: getIt<DatabaseService>(),
      ),
    );
  }

  // Home Bloc
  if (!getIt.isRegistered<HomeBloc>()) {
    getIt.registerFactory<HomeBloc>(
      () => HomeBloc(
        homeRepo: getIt<HomeRepo>(),
      ),
    );
  }
}
