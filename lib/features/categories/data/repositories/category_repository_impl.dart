import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/categories/data/datasources/category_firebasedatasource.dart';
import 'package:food_app/features/categories/domain/entities/category.dart';
import 'package:food_app/features/categories/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  CategoryRepositoryImpl({required this.categoryFirebasedatasource});
  CategoryFirebasedatasource categoryFirebasedatasource;
  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    try {
      final failureOrCategories =
          await categoryFirebasedatasource.getCategories();
      return failureOrCategories.fold(
          (failure) => Left(failure),
          (categories) => Right(categories.map((categoryModel) {
                return categoryModel.toEntity();
              }).toList()));
    } catch (error) {
      return Left(SomeSpecificError(error.toString()));
    }
  }
}
