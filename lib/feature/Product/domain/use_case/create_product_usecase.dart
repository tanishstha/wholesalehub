import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:wholesalehub_app/app/usecase/usease.dart';
import 'package:wholesalehub_app/core/error/failure.dart';
import 'package:wholesalehub_app/feature/Product/domain/entity/product_entity.dart';
import 'package:wholesalehub_app/feature/Product/domain/repository/product_repository.dart';
// import 'package:softwarica_student_management_bloc/features/batch/domain/repository/batch_repository.dart';

class CreateProductParams extends Equatable {
  final String productName;
  final String image;
  final String description;
  final String type;
  final String quantity;
  final String price;

  const CreateProductParams({
    required this.productName,
    required this.image,
    required this.description,
    required this.type,
    required this.quantity,
    required this.price,
  });

  // Empty constructor
  const CreateProductParams.empty()
      : productName = '_empty.string',
        image = '_empty.image',
        description = '_empty.description',
        type = '_empty.type',
        quantity = '_empty.type',
        price = '_empty.type';

  @override
  List<Object?> get props => [productName];
}

class CreateProductUseCase
    implements UsecaseWithParams<void, CreateProductParams> {
  final IProductRepository productRepository;

  CreateProductUseCase({required this.productRepository});

  @override
  Future<Either<Failure, void>> call(CreateProductParams params) async {
    return await productRepository.createProduct(
      ProductEntity(
        productName: params.productName,
        image: params.image,
        description: params.description,
        type: params.type,
        quantity: params.quantity,
        price: params.price,
      ),
    );
  }
}
