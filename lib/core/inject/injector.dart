import 'package:get_it/get_it.dart';
import 'package:lojaapp/core/services/auth/auth_service.dart';
import 'package:lojaapp/core/services/database/database_service.dart';

import 'package:lojaapp/features/cart/data/datasources/cart_datasources.dart';
import 'package:lojaapp/features/cart/data/datasources/remote/cart_datasources_remote_imp.dart';
import 'package:lojaapp/features/cart/data/repositories/cart_repository_imp.dart';
import 'package:lojaapp/features/cart/domain/repositories/cart_repository.dart';
import 'package:lojaapp/features/cart/domain/usecases/add_item_cart_usecase.dart';
import 'package:lojaapp/features/cart/domain/usecases/add_item_cart_usecase_imp.dart';
import 'package:lojaapp/features/cart/domain/usecases/dec_product_usecase.dart';
import 'package:lojaapp/features/cart/domain/usecases/dec_product_usecase_imp.dart';
import 'package:lojaapp/features/cart/domain/usecases/inc_product_usecase.dart';
import 'package:lojaapp/features/cart/domain/usecases/inc_product_usecase_imp.dart';
import 'package:lojaapp/features/cart/domain/usecases/remove_item_cart_usecase.dart';
import 'package:lojaapp/features/cart/domain/usecases/remove_item_cart_usecase_imp.dart';
import 'package:lojaapp/features/cart/presentation/bloc/cart_bloc.dart';
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
import 'package:lojaapp/features/home/domain/usecases/sign_out_usecase.dart';
import 'package:lojaapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:lojaapp/features/initialize/presentation/bloc/initialize_bloc.dart';
import 'package:lojaapp/features/login/data/datasources/login_datasource.dart';
import 'package:lojaapp/features/login/data/datasources/remote/login_datasource_remote_imp.dart';
import 'package:lojaapp/features/login/data/repositories/login_repository_imp.dart';
import 'package:lojaapp/features/login/domain/repositories/login_repository.dart';
import 'package:lojaapp/features/login/domain/usecases/login_usecase.dart';
import 'package:lojaapp/features/login/domain/usecases/login_usecase_imp.dart';
import 'package:lojaapp/features/login/presentation/bloc/login_bloc.dart';
import 'package:lojaapp/features/products/data/datasources/products_datasource.dart';
import 'package:lojaapp/features/products/data/datasources/remote/products_datasource_remote_imp.dart';
import 'package:lojaapp/features/products/data/repositories/products_repository_imp.dart';
import 'package:lojaapp/features/products/domain/repositories/products_repository.dart';
import 'package:lojaapp/features/products/domain/usecases/add_item_to_cart_usecase.dart';
import 'package:lojaapp/features/products/domain/usecases/add_item_to_cart_usecase_imp.dart';
import 'package:lojaapp/features/products/domain/usecases/get_products_usecase.dart';
import 'package:lojaapp/features/products/domain/usecases/usecase.dart';
import 'package:lojaapp/features/products/presentation/bloc/products_bloc.dart';
import 'package:lojaapp/features/register/data/datasources/register_datasources.dart';
import 'package:lojaapp/features/register/data/datasources/remote/register_datasources_imp.dart';
import 'package:lojaapp/features/register/data/repositories/register_repository_imp.dart';
import 'package:lojaapp/features/register/domain/repositories/register_repository.dart';
import 'package:lojaapp/features/register/domain/usecases/register_usecase.dart';
import 'package:lojaapp/features/register/domain/usecases/register_usecase_imp.dart';
import 'package:lojaapp/features/register/presentation/bloc/register_bloc.dart';

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

    getIt.registerLazySingleton<ProductsDataSource>(
        () => ProductsDataSourceRemoteImp(getIt(), getIt()));

    getIt.registerLazySingleton<CartDataSource>(
        () => CartDataSourcesRemoteImp(getIt(), getIt()));

    //repositories
    getIt.registerLazySingleton<RegisterRepository>(
        () => RegisterRepositoryImp(getIt()));

    getIt.registerLazySingleton<LoginRepository>(
        () => LoginRepositoryImp(getIt()));
    getIt.registerLazySingleton<HomeRepository>(
        () => HomeRepositoryImp(getIt()));
    getIt.registerLazySingleton<CategoriesRepository>(
        () => CategoriesRepositoryImp(getIt()));
    getIt.registerLazySingleton<ProductsRepository>(
        () => ProductsRepositoryImp(getIt()));
    getIt.registerLazySingleton<CartRepository>(
        () => CartRepositoryImp(getIt()));

    //usecases
    getIt.registerLazySingleton<RegisterUseCase>(
        () => RegisterUseCaseImp(getIt()));

    getIt.registerLazySingleton<LoginUseCase>(() => LoginUseCaseImp(getIt()));

    getIt.registerLazySingleton(() => SignOutUseCase(getIt()));
    getIt.registerLazySingleton(() => GetCategoriesUseCase(getIt()));
    getIt.registerLazySingleton<UseCase>(() => GetProductsUseCase(getIt()));
    getIt.registerLazySingleton<AddCartUseCase>(
        () => AddCartUseCaseImp(getIt()));

    getIt.registerLazySingleton<AddItemToCartUseCase>(
        () => AddItemToCartUseCaseImp(getIt()));
    getIt.registerLazySingleton<RemoveItemCartUseCase>(
        () => RemoveItemCartUseCaseImp(getIt()));
    getIt.registerLazySingleton<IncProductUseCase>(
        () => IncProductUseCaseImp(getIt()));
    getIt.registerLazySingleton<DecProductUseCase>(
        () => DecProductUseCaseImp(getIt()));

    //controllers

    getIt.registerFactory<CartBloc>(
        () => CartBloc(getIt(), getIt(), getIt(), getIt()));
    getIt.registerFactory<ProductsBloc>(() => ProductsBloc(getIt(), getIt()));
    getIt.registerFactory<CategoriesBloc>(() => CategoriesBloc(getIt()));
    getIt.registerFactory<HomeBloc>(() => HomeBloc(getIt()));
    getIt.registerFactory<RegisterBloC>(
        () => RegisterBloC(registerUseCase: getIt()));

    getIt.registerFactory<LoginBloc>(() => LoginBloc(getIt()));

    getIt.registerFactory<InitializeBloc>(() => InitializeBloc(getIt()));
  }
}
