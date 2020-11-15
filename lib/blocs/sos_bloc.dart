import 'package:flutter_earthquake_network/utils/common.dart';
import 'package:flutter_sms/flutter_sms.dart';

import 'base_bloc/base.dart';

class SOSBloc extends BaseBloc {
  int currentGroupValueSOS;

  SOSBloc({this.currentGroupValueSOS});

  Future<bool> _sendSMS() async {// FUNTION gui tin nhan
    List<String> recipents = await Common.getListPhone();
    // Common.saveMessageSOS("Cứu tao với");
    if (recipents.length == 0) {
      return false;
    } else {
      String message = await Common.getMessageSOS();
      String message1 = await Common.getUserLocation();
      if (message == null) message = "help me !!!!!!";
      message = message + "\n" + message1;
      String _result =
          await FlutterSms.sendSMS(message: message, recipients: recipents)
              .catchError((onError) {
        print(onError);
      });
      return true;
    }
  }

  @override
  // TODO: implement initialState
  BaseState get initialState => GroupValueSOSState(currentGroupValueSOS);

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is GroupValueSOSEvent) {
      if (currentGroupValueSOS != event.groupValue) {
        currentGroupValueSOS = event.groupValue;

        yield GroupValueSOSState(currentGroupValueSOS);
      }
    }
    if (event is SendingMess) {
      yield LoadingState();
      if (await _sendSMS() == true) {
        _sendSMS();
        yield InitState();
      } else {
        print("k co gi ca");
        print("voa day");
        yield ErrorState<String>(data: "settings.error_null_phone");
        yield InitState();
      }
    }
  }
}

class GroupValueSOSEvent extends BaseEvent {
  int groupValue;
  GroupValueSOSEvent(this.groupValue);
}

class GroupValueSOSState extends BaseState {
  int groupValue;
  GroupValueSOSState(this.groupValue);

  @override
  // TODO: implement props
  List<Object> get props => [groupValue];
}

class SendingMess extends BaseEvent {}

