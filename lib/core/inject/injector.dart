import 'package:get_it/get_it.dart';
import 'package:lojaapp/core/services/auth/auth_service.dart';
import 'package:lojaapp/core/services/database/database_service.dart';
import 'package:lojaapp/features/categories/data/datasources/categories_datasource.dart';
import 'package:lojaapp/features/categories/data/datasources/remote/categories_datasource_remote_imp.dart';
import 'package:lojaapp/features/categories/data/repositories/categories_repository_imp.dart';
import 'package:lojaapp/features/categories/domain/repositories/categories_repository.dart';
import 'package:lojaapp/features/categories/domain/usecases/get_categories_usecase.dart';
import 'package:lojaapp/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:lojaapp/features/home/data/datasources/home_datasources.dart';
import 'package:lojaapp/features/home/data/datasources/remote/home_datasources_remote_imp.dart';
import 'package:lojaapp/features/home/data/repositories/home_repository_imp.dart';
import 'package:lojaapp/features/home/domain/repositories/home_repository.dart';
import 'package:lojaapp/features/home/domain/usecases/use_case.dart';
import 'package:lojaapp/features/home/domain/usecases/sign_out_usecase.dart';
import 'package:lojaapp/features/home/presentation/controllers/home_bloc.dart';
import 'package:lojaapp/features/initialize/presentation/controllers/initialize_bloc.dart';
import 'package:lojaapp/features/login/data/datasources/login_datasource.dart';
import 'package:lojaapp/features/login/data/datasources/remote/login_datasource_remote_imp.dart';
import 'package:lojaapp/features/login/data/repositories/login_repository_imp.dart';
import 'package:lojaapp/features/login/domain/repositories/login_repository.dart';
import 'package:lojaapp/features/login/domain/usecases/login_usecase.dart';
import 'package:lojaapp/features/login/domain/usecases/login_usecase_imp.dart';
import 'package:lojaapp/features/login/presentation/controllers/login_bloc.dart';
import 'package:lojaapp/features/register/data/datasources/register_datasources.dart';
import 'package:lojaapp/features/register/data/datasources/remote/register_datasources_imp.dart';
import 'package:lojaapp/features/register/data/repositories/register_repository_imp.dart';
import 'package:lojaapp/features/register/domain/repositories/register_repository.dart';
import 'package:lojaapp/features/register/domain/usecases/register_usecase.dart';
import 'package:lojaapp/features/register/domain/usecases/register_usecase_imp.dart';
import 'package:lojaapp/features/register/presentation/controllers/register_bloc.dart';

class Injector {
  static initialize() async {
    final getIt = GetIt.I;

    //core
    getIt.registerLazySingleton<AuthService>(() => AuthService());
    getIt.registerLazySingleton<DatabaseService>(() => DatabaseService());

    //datasources
    getIt.registerLazySingleton<RegisterDataSource>(() =>
        RegisterDataSourceImp(authService: getIt(), databaseService: getIt()));

    getIt.registerLazySingleton<LoginDataSource>(
        () => LoginDataSourceRemoteImp(getIt()));
    getIt.registerLazySingleton<HomeDataSource>(
        () => HomeDataSourceRemoteImp(getIt()));
    getIt.registerLazySingleton<CategoriesDataSource>(
        () => CategoriesDataSourceRemoteImp(getIt()));

    //repositories
    getIt.registerLazySingleton<RegisterRepository>(
        () => RegisterRepositoryImp(getIt()));

    getIt.registerLazySingleton<LoginRepository>(
        () => LoginRepositoryImp(getIt()));
    getIt.registerLazySingleton<HomeRepository>(
        () => HomeRepositoryImp(getIt()));
    getIt.registerLazySingleton<CategoriesRepository>(
        () => CategoriesRepositoryImp(getIt()));

    //usecases
    getIt.registerLazySingleton<RegisterUseCase>(
        () => RegisterUseCaseImp(getIt()));

    getIt.registerLazySingleton<LoginUseCase>(() => LoginUseCaseImp(getIt()));

    getIt.registerLazySingleton(() => SignOutUseCase(getIt()));
    getIt.registerLazySingleton(() => GetCategoriesUseCase(getIt()));

    //controllers

    getIt.registerFactory<CategoriesBloc>(() => CategoriesBloc(getIt()));
    getIt.registerFactory<HomeBloc>(() => HomeBloc(getIt()));
    getIt.registerFactory<RegisterBloC>(
        () => RegisterBloC(registerUseCase: getIt()));

    getIt.registerFactory<LoginBloc>(() => LoginBloc(getIt()));

    getIt.registerFactory<InitializeBloc>(() => InitializeBloc());
  }
}
