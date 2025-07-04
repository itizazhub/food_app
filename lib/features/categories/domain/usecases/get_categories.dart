import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/categories/domain/entities/category.dart';
import 'package:food_app/features/categories/domain/repositories/category_repository.dart';

class GetCategories {
  GetCategories({required this.categoryRepository});
  CategoryRepository categoryRepository;
  Future<Either<Failure, List<Category>>> call() {
    return categoryRepository.getCategories();
  }
}
