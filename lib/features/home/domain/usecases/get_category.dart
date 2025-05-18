import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/home/domain/entities/category.dart';
import 'package:food_app/features/home/domain/repositories/category_repository.dart';

class GetCategory {
  GetCategory({required this.categoryRepository});
  CategoryRepository categoryRepository;
  Future<Either<Failure, List<Category>>> call() {
    return categoryRepository.getCategory();
  }
}
