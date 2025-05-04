import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flower_tracking_app/core/constants/assets_paths/assets_paths.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/country_model.dart';

part 'apply_state.dart';

@injectable
class ApplyCubit extends Cubit<ApplyState> {
  ApplyCubit() : super(const ApplyState());

  Future<void> loadCountries() async {
    try {
      emit(state.copyWith(loadCountryStatus: LoadCountryStatus.loading));

      final String jsonString = await rootBundle.loadString(
        AssetsPaths.countryJson,
      );
      final List<dynamic> jsonList = json.decode(jsonString);
      List<CountryModel> countryList =
          jsonList.map((json) => CountryModel.fromJson(json)).toList();

      emit(
        state.copyWith(
          loadCountryStatus: LoadCountryStatus.success,
          countries: countryList,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          loadCountryStatus: LoadCountryStatus.error,
          error: error,
        ),
      );
    }
  }
}
