import 'package:bookly/core/api/api_service.dart';
import 'package:bookly/features/books/data/datasources/books_local_data_source.dart';
import 'package:bookly/features/books/data/datasources/books_remote_data_source.dart';
import 'package:bookly/features/books/data/repositories/books_repository_impl.dart';
import 'package:bookly/features/books/domain/repositories/books_repository.dart';
import 'package:bookly/features/books/domain/usecases/get_featured_books_usecase.dart';
import 'package:bookly/features/books/domain/usecases/get_newest_books_usecase.dart';
import 'package:bookly/features/books/presentation/manager/featured_books_cubit/featured_books_cubit.dart';
import 'package:bookly/features/books/presentation/manager/newest_books_cubit/newest_books_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<ApiService>(() => ApiService());
  getIt.registerLazySingleton<BooksRemoteDataSource>(
    () => BooksRemoteDataSourceImpl(apiService: getIt<ApiService>()),
  );
  getIt.registerLazySingleton<BooksLocalDataSource>(
    () => const BooksLocalDataSourceImpl(),
  );
  getIt.registerLazySingleton<BooksRepository>(
    () => BooksRepositoryImpl(
      remoteDataSource: getIt<BooksRemoteDataSource>(),
      localDataSource: getIt<BooksLocalDataSource>(),
    ),
  );
  getIt.registerLazySingleton<GetFeaturedBooksUseCase>(
    () => GetFeaturedBooksUseCase(booksRepository: getIt<BooksRepository>()),
  );
  getIt.registerLazySingleton<GetNewestBooksUseCase>(
    () => GetNewestBooksUseCase(booksRepository: getIt<BooksRepository>()),
  );
  getIt.registerFactory<FeaturedBooksCubit>(
    () => FeaturedBooksCubit(
        getFeaturedBooksUseCase: getIt<GetFeaturedBooksUseCase>()),
  );
  getIt.registerFactory<NewestBooksCubit>(
    () =>
        NewestBooksCubit(getNewestBooksUseCase: getIt<GetNewestBooksUseCase>()),
  );
}
