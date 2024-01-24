import 'package:bloc/bloc.dart';
import 'package:flutter_cbt_tpa_app/data/datasource/ujian_remote_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'answer_event.dart';
part 'answer_state.dart';
part 'answer_bloc.freezed.dart';

class AnswerBloc extends Bloc<AnswerEvent, AnswerState> {
  final UjianRemoteDatasource ujianRemoteDatasource;
  AnswerBloc(
    this.ujianRemoteDatasource,
  ) : super(const _Initial()) {
    on<_SetAnswer>((event, emit) async {
      emit(const _Loading());
      final response =
          await ujianRemoteDatasource.answer(event.soalId, event.jawaban);
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(const _Success()),
      );
    });
  }
}
