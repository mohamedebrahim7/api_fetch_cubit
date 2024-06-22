import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'state.dart';


class ApiFetchCubit extends Cubit<ApiFetchState> {
  ApiFetchCubit() : super(const ApiFetchState()) {
    /// you can use fetch data to fetch data directly
    /// remove it  if you want to wait until user ask for it
    fetchData();
  }

  Future<void> fetchData()  async {

    try {
      emit(state.copyWith(uiState: UIState.inProgress));
       final response = await apiClient.getVenues();
      if (response.code == 200) {
        emit(state.copyWith(uiState: UIState.success, apiResponse: response,));
      } else {
        emit(state.copyWith(uiState: UIState.invalidCredentialsError, failureMessage: response.message,));
      }
    } on DioException catch (e) {
      emit(state.copyWith(uiState: UIState.genericError, failureMessage: e.handleDioError()));
    }
  }

}
