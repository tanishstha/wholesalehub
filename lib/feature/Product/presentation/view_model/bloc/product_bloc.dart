import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wholesalehub_app/feature/Order/presentation/view_model/order/bloc/order_bloc.dart';
import 'package:wholesalehub_app/feature/Product/domain/entity/product_entity.dart';
import 'package:wholesalehub_app/feature/Product/domain/use_case/create_product_usecase.dart';
import 'package:wholesalehub_app/feature/Product/domain/use_case/delete_product_usecase.dart';
import 'package:wholesalehub_app/feature/Product/domain/use_case/get_all_product_usecase.dart';
import 'package:wholesalehub_app/feature/Product/domain/use_case/upload_image_usecase.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final OrderBloc _orderBloc;
  final CreateProductUseCase _createProductUseCase;
  final GetAllProductUseCase _getAllProductUseCase;
  final DeleteProductUsecase _deleteProductUsecase;
  final UploadProductImageUsecase _uploadProductImageUsecase;

  ProductBloc({
    required OrderBloc orderBloc,
    required CreateProductUseCase createProductUseCase,
    required GetAllProductUseCase getAllProductUseCase,
    required DeleteProductUsecase deleteProductUsecase,
    required UploadProductImageUsecase uploadProductImageUsecase,
  })  : _orderBloc = orderBloc,
        _createProductUseCase = createProductUseCase,
        _getAllProductUseCase = getAllProductUseCase,
        _deleteProductUsecase = deleteProductUsecase,
        _uploadProductImageUsecase = uploadProductImageUsecase,
        super(ProductState.initial()) {
    on<NavigateSingleProductScreenEvent>((event, emit) {
      Navigator.push(
          event.context,
          MaterialPageRoute(
              builder: (context) => MultiBlocProvider(providers: [
                    BlocProvider.value(value: _orderBloc),
                  ], child: event.destination)));
    });
    on<GetAllProduct>(_onGetAllProduct);
    on<AddProduct>(_onAddProduct);
    on<DeleteProduct>(_onDeleteProduct);
    on<LoadProductImage>(_onLoadProductImage);

    // Call this event whenever the bloc is created to load the Productes
    add(GetAllProduct());
  }

  Future<void> _onGetAllProduct(
      GetAllProduct event, Emitter<ProductState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await _getAllProductUseCase.call();
    result.fold(
      (failure) {
        print("Error: ${failure.message}");
        emit(state.copyWith(isLoading: false, error: failure.message));
      },
      (products) => emit(state.copyWith(isLoading: false, product: products)),
    );
  }

  Future<void> _onAddProduct(
      AddProduct event, Emitter<ProductState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _createProductUseCase.call(CreateProductParams(
      productName: event.productName,
      image: state.productimageName ?? '',
      description: event.description,
      type: event.type,
      quantity: event.quantity,
      price: event.price,
    ));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (product) {
        emit(state.copyWith(isLoading: false, error: null));

        add(GetAllProduct());
      },
    );
  }

  Future<void> _onDeleteProduct(
      DeleteProduct event, Emitter<ProductState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _deleteProductUsecase
        .call(DeleteProductParams(productId: event.productId));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (product) {
        emit(state.copyWith(isLoading: false, error: null));
        add(GetAllProduct());
      },
    );
  }

  Future<void> _onLoadProductImage(
    LoadProductImage event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _uploadProductImageUsecase.call(
      UploadProductImageParams(
        file: event.file,
      ),
    );
    result.fold(
      (l) => emit(state.copyWith(isLoading: false, error: l.message)),
      (r) {
        emit(
            state.copyWith(isLoading: false, error: null, productimageName: r));
      },
    );
  }
}
