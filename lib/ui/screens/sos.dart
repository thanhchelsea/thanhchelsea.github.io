import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_earthquake_network/blocs/base_bloc/base.dart';
import 'package:flutter_earthquake_network/blocs/sos_bloc.dart';
import 'package:flutter_earthquake_network/localizations.dart';
import 'package:flutter_earthquake_network/res/dimens.dart';
import 'package:flutter_earthquake_network/utils/common.dart';
import 'package:flutter_sms/flutter_sms.dart';

class SOS extends StatefulWidget {
  @override
  _SOSState createState() => _SOSState();
}

class _SOSState extends State<SOS> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SOSBloc>(
        create: (context) => SOSBloc(),
        child: BlocBuilder<SOSBloc, BaseState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Wrap(
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: <Widget>[
                          Radio(
                            value: 0,
                            // groupValue: model.groupchoiceBank,
                            // onChanged: (int val) {
                            //   model.groupchoiceBank = val;
                            //},
                          ),
                          Text('Email'),
                        ],
                      ),
                      Wrap(
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: <Widget>[
                          Radio(
                            value: 1,
                            // groupValue: model.groupchoiceBank,
                            // onChanged: (int val) {
                            //   model.groupchoiceBank = val;
                            // },
                          ),
                          Text('SMS'),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Center(
                    child: RaisedButton(
                      onPressed: () async {
                        BlocProvider.of<SOSBloc>(context).add(SendingMess());
                      },
                      color: Colors.blue,
                      textColor: Colors.red,
                      child: Text(
                        Language.of(context).getText("home.sos"),
                        style: TextStyle(
                          fontSize: AppDimens.SIZE_50,
                        ),
                      ),
                      padding: EdgeInsets.all(80),
                      shape: CircleBorder(),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment:  Alignment.center,
                    child: BlocBuilder<SOSBloc, BaseState>(
                      builder: (context, state) {
                        if (state is ErrorState<String>) {
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content:
                              Text(Language.of(context).getText(state.data)),
                            ),
                          );
                        }
                        if(state is LoadingState){
                          return CircularProgressIndicator();
                        }
                        return Container();
                      },
                    ),
                  )
                )
              ],
            );
          },
        ));
  }
}
