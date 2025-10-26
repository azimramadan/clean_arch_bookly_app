import 'package:bloc/bloc.dart';
import 'package:bookly/features/books/domain/entities/book_entity.dart';
import 'package:bookly/features/books/domain/usecases/get_newest_books_usecase.dart';
import 'package:meta/meta.dart';

part 'newest_books_state.dart';

class NewestBooksCubit extends Cubit<NewestBooksState> {
  final GetNewestBooksUseCase getNewestBooksUseCase;
  NewestBooksCubit({required this.getNewestBooksUseCase})
      : super(NewestBooksInitial());
  List<BookEntity> newestBooks = [];
  Future<void> getNewestBooks({int pageNumber = 0}) async {
    pageNumber == 0
        ? emit(NewestBooksLoading())
        : emit(NewestBooksPaginationLoading(newestBooks: newestBooks));
    final result = await getNewestBooksUseCase.call(pageNumber);
    result.fold(
        (failure) => pageNumber == 0
            ? emit(NewestBooksFailure(errorMessage: failure.message))
            : emit(NewestBooksPaginationFailure(
                errorMessage: failure.message,
                newestBooks: newestBooks,
              )), (books) {
      newestBooks = [...newestBooks, ...books];
      emit(NewestBooksSuccess(newestBooks: newestBooks));
    });
  }
}
