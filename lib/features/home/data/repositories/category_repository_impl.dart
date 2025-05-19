import 'package:dartz/dartz.dart';
import 'package:food_app/features/core/error/failures.dart';
import 'package:food_app/features/home/data/datasources/category_firebasedatasource.dart';
import 'package:food_app/features/home/data/models/category_model.dart';
import 'package:food_app/features/home/domain/entities/category.dart';
import 'package:food_app/features/home/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  CategoryRepositoryImpl({required this.categoryFirebasedatasource});
  CategoryFirebasedatasource categoryFirebasedatasource;
  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    try {
      List<CategoryModel> categories =
          await categoryFirebasedatasource.getCategories();
      return Right(categories.map((categoryModel) {
        return categoryModel.toEntity();
      }).toList());
    } catch (error) {
      return Left(SomeSpecificError(error.toString()));
    }
  }
}
