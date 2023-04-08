import 'package:get_it/get_it.dart';
import '../services/auth/auth_service.dart';
import '../services/database/database_service.dart';
import '../../features/cart/data/datasources/cart_datasources.dart';
import '../../features/cart/data/datasources/remote/cart_datasources_remote_imp.dart';
import '../../features/cart/data/repositories/cart_repository_imp.dart';
import '../../features/cart/domain/repositories/cart_repository.dart';
import '../../features/cart/domain/usecases/add_cart_order_usecase.dart';
import '../../features/cart/domain/usecases/add_cart_order_usecase_imp.dart';
import '../../features/cart/domain/usecases/get_cart_item_usecase.dart';
import '../../features/cart/domain/usecases/get_cart_item_usecase_imp.dart';
import '../../features/cart/domain/usecases/dec_product_usecase.dart';
import '../../features/cart/domain/usecases/dec_product_usecase_imp.dart';
import '../../features/cart/domain/usecases/discount_cart_items_usecase.dart';
import '../../features/cart/domain/usecases/discount_cart_items_usecase_imp.dart';
import '../../features/cart/domain/usecases/inc_product_usecase.dart';
import '../../features/cart/domain/usecases/inc_product_usecase_imp.dart';
import '../../features/cart/domain/usecases/remove_item_cart_usecase.dart';
import '../../features/cart/domain/usecases/remove_item_cart_usecase_imp.dart';
import '../../features/cart/presentation/bloc/cart_bloc.dart';
import '../../features/categories/data/datasources/categories_datasource.dart';
import '../../features/categories/data/datasources/remote/categories_datasource_remote_imp.dart';
import '../../features/categories/data/repositories/categories_repository_imp.dart';
import '../../features/categories/domain/repositories/categories_repository.dart';
import '../../features/categories/domain/usecases/get_categories_usecase.dart';
import '../../features/categories/presentation/bloc/categories_bloc.dart';
import '../../features/home/data/datasources/home_datasources.dart';
import '../../features/home/data/datasources/remote/home_datasources_remote_imp.dart';
import '../../features/home/data/repositories/home_repository_imp.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/usecases/sign_out_usecase.dart';
import '../../features/home/presentation/bloc/home_bloc.dart';
import '../../features/initialize/presentation/bloc/initialize_bloc.dart';
import '../../features/login/data/datasources/login_datasource.dart';
import '../../features/login/data/datasources/remote/login_datasource_remote_imp.dart';
import '../../features/login/data/repositories/login_repository_imp.dart';
import '../../features/login/domain/repositories/login_repository.dart';
import '../../features/login/domain/usecases/login_usecase.dart';
import '../../features/login/domain/usecases/login_usecase_imp.dart';
import '../../features/login/presentation/bloc/login_bloc.dart';
import '../../features/orders/data/datasources/order_datasources.dart';
import '../../features/orders/data/datasources/remote/order_datasources_remote_imp.dart';
import '../../features/orders/data/repositories/order_repository_imp.dart';
import '../../features/orders/domain/repositories/order_repository.dart';
import '../../features/orders/domain/usecases/get_orders_usecase.dart';
import '../../features/orders/domain/usecases/get_orders_usecase_imp.dart';
import '../../features/orders/domain/usecases/mercado_pago_usecase.dart';
import '../../features/orders/domain/usecases/mercado_pago_usecase_imp.dart';
import '../../features/orders/domain/usecases/order_status_usecase.dart';
import '../../features/orders/domain/usecases/order_status_usecase_imp.dart';
import '../../features/orders/presentation/bloc/order_bloc.dart';
import '../../features/products/data/datasources/products_datasource.dart';
import '../../features/products/data/datasources/remote/products_datasource_remote_imp.dart';
import '../../features/products/data/repositories/products_repository_imp.dart';
import '../../features/products/domain/repositories/products_repository.dart';
import '../../features/products/domain/usecases/add_item_to_cart_usecase.dart';
import '../../features/products/domain/usecases/add_item_to_cart_usecase_imp.dart';
import '../../features/products/domain/usecases/get_products_usecase.dart';
import '../../features/products/domain/usecases/usecase.dart';
import '../../features/products/presentation/bloc/products_bloc.dart';
import '../../features/register/data/datasources/register_datasources.dart';
import '../../features/register/data/datasources/remote/register_datasources_imp.dart';
import '../../features/register/data/repositories/register_repository_imp.dart';
import '../../features/register/domain/repositories/register_repository.dart';
import '../../features/register/domain/usecases/register_usecase.dart';
import '../../features/register/domain/usecases/register_usecase_imp.dart';
import '../../features/register/presentation/bloc/register_bloc.dart';

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

    getIt.registerLazySingleton<OrderDataSources>(
        () => OrderDataSourcesRemoteImp(getIt(), getIt()));

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
    getIt.registerLazySingleton<OrderRepository>(
        () => OrderRepositoryImp(getIt()));

    //usecases

    getIt.registerLazySingleton<OrderStatusUseCase>(
        () => OrderStatusUseCaseImp(getIt()));

    getIt.registerLazySingleton<MercadoPagoUseCase>(
        () => MercadoPagoUseCaseImp(getIt()));

    getIt.registerLazySingleton<RegisterUseCase>(
        () => RegisterUseCaseImp(getIt()));

    getIt.registerLazySingleton<LoginUseCase>(() => LoginUseCaseImp(getIt()));

    getIt.registerLazySingleton(() => SignOutUseCase(getIt()));
    getIt.registerLazySingleton(() => GetCategoriesUseCase(getIt()));
    getIt.registerLazySingleton<UseCase>(() => GetProductsUseCase(getIt()));
    getIt.registerLazySingleton<GetItemsCart>(() => AddCartUseCaseImp(getIt()));

    getIt.registerLazySingleton<AddItemToCartUseCase>(
        () => AddItemToCartUseCaseImp(getIt()));
    getIt.registerLazySingleton<RemoveItemCartUseCase>(
        () => RemoveItemCartUseCaseImp(getIt()));
    getIt.registerLazySingleton<IncProductUseCase>(
        () => IncProductUseCaseImp(getIt()));
    getIt.registerLazySingleton<DecProductUseCase>(
        () => DecProductUseCaseImp(getIt()));

    getIt.registerLazySingleton<DiscountCardItemUseCase>(
        () => DiscountCardItemUseCaseImp(getIt()));
    getIt.registerLazySingleton<AddCartOrderUseCase>(
        () => AddCartOrderUseCaseImp(getIt()));
    getIt.registerLazySingleton<GetOrdersUseCase>(
        () => GetOrdersUseCaseImp(getIt()));

    //controllers

    getIt.registerFactory(() => OrderBloc(getIt(), getIt(), getIt()));
    getIt.registerFactory<CartBloc>(
        () => CartBloc(getIt(), getIt(), getIt(), getIt(), getIt(), getIt()));
    getIt.registerFactory<ProductsBloc>(() => ProductsBloc(getIt(), getIt()));
    getIt.registerFactory<CategoriesBloc>(() => CategoriesBloc(getIt()));
    getIt.registerFactory<HomeBloc>(() => HomeBloc(getIt()));
    getIt.registerFactory<RegisterBloC>(
        () => RegisterBloC(registerUseCase: getIt()));

    getIt.registerFactory<LoginBloc>(() => LoginBloc(getIt()));

    getIt.registerFactory<InitializeBloc>(() => InitializeBloc(getIt()));
  }
}
