import 'package:bloc/bloc.dart';
import 'package:bookly/features/books/domain/entities/book_entity.dart';
import 'package:bookly/features/books/domain/usecases/get_featured_books_usecase.dart';
import 'package:meta/meta.dart';

part 'featured_books_state.dart';

class FeaturedBooksCubit extends Cubit<FeaturedBooksState> {
  final GetFeaturedBooksUseCase getFeaturedBooksUseCase;
  FeaturedBooksCubit({required this.getFeaturedBooksUseCase})
      : super(FeaturedBooksInitial());
  List<BookEntity> books = [];
  Future<void> getFeaturedBooks({int pageNumber = 0}) async {
    pageNumber == 0
        ? emit(FeaturedBooksLoading())
        : emit(FeaturedBooksPaginationLoading(books: books));
    final result = await getFeaturedBooksUseCase.call(pageNumber);
    result.fold(
        (failure) => pageNumber == 0
            ? emit(FeaturedBooksFailure(errorMessage: failure.message))
            : emit(FeaturedBooksPaginationFailure(
                errorMessage: failure.message,
                books: books,
              )), (books) {
      this.books = [...this.books, ...books];
      emit(FeaturedBooksSuccess(books: this.books));
    });
  }
}
