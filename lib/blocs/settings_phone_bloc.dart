import 'package:flutter/material.dart';
import 'package:flutter_earthquake_network/blocs/base_bloc/base.dart';
import 'package:flutter_earthquake_network/utils/common.dart';

class PhoneSetting extends BaseBloc {
  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    // TODO: implement mapEventToState

    if (event is LoadPhone) {
      List<String> data =[];
      data= await Common.getListPhone();
      yield ShowListPhone(data: data);
    }
    if (event is ChangPhone) {
      print("show");
      yield ShowBtnSave();
    }
    if (event is SaveListPhone) {
      Common.saveListPhone(event.dsPhone);
      yield SavedPhone();
    }
  }

  PhoneSetting();
}

class ShowListPhone<T> extends BaseState {
  T data;

  ShowListPhone({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];
}

class SavedPhone extends BaseState {}

class ShowBtnSave extends BaseState {
  ShowBtnSave();
}

class LoadPhone extends BaseEvent {
  @override
  List<Object> get props => [];
}

class ChangPhone extends BaseEvent {
  List<String> ds;
  ChangPhone(this.ds);
  @override
  List<Object> get props => [ds];
}

class SaveListPhone extends BaseEvent {
  List<String> dsPhone;

  SaveListPhone(this.dsPhone);
  @override
  List<Object> get props => [dsPhone];
}
