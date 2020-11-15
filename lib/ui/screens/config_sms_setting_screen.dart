import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_earthquake_network/blocs/blocs.dart';
import 'package:flutter_earthquake_network/constants.dart';
import 'package:flutter_earthquake_network/localizations.dart';
import 'package:flutter_earthquake_network/res/colors.dart';
import 'package:flutter_earthquake_network/res/dimens.dart';
import 'package:flutter_earthquake_network/ui/widgets/widgets.dart';
import 'package:flutter_earthquake_network/utils/device.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SMSSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PhoneSetting>(
      create: (context)=>PhoneSetting(),
      child: Container(
        child: BlocBuilder<PhoneSetting,BaseState>(
          builder: (context, state) {
            return ConfigSMSSetting();
          },
        )
      ),
    );
  }
}

class ConfigSMSSetting extends StatefulWidget {

  @override
  _ConfigSMSSettingState createState() => _ConfigSMSSettingState();
}

class _ConfigSMSSettingState extends State<ConfigSMSSetting> {
  final num1 = new TextEditingController();
  final num2 = new TextEditingController();
  final num3 = new TextEditingController();
  final num4 = new TextEditingController();
  final num5 = new TextEditingController();
  List<TextEditingController> dscontrol = [];
  List<String> dsphone = [];

  Widget itemPhone(BuildContext context, int count,
      {TextEditingController controler, String number}) {

    controler.selection = TextSelection.fromPosition(TextPosition(offset: controler.text.length));
    return BlocBuilder<PhoneSetting, BaseState>(
      builder: (context, state) {
        if (number != "") controler.text = number + "";
        return Container(
          padding: EdgeInsets.only(
              top: AppDimens.SIZE_5,
              left: AppDimens.SIZE_15,
              bottom: AppDimens.SIZE_5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                count.toString() + "st number",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              TextFormField(
                controller: controler,
                cursorColor: Colors.black,
                onChanged: (value) {
                  print(controler.text);
                  BlocProvider.of<PhoneSetting>(context)
                      .add(ChangPhone(dsphone));
                },
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: number != "" ? number : "enter number"),
              ),
              Divider(
                color: Colors.black,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    // List ds=_getList() as List;
    super.initState();

    //_getList();
    dscontrol.add(num1);
    dscontrol.add(num2);
    dscontrol.add(num3);
    dscontrol.add(num4);
    dscontrol.add(num5);
    //print(dsphone.length);
    BlocProvider.of<PhoneSetting>(context).add(LoadPhone());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<PhoneSetting,BaseState>(
          listener: (context, state) {
            if(state is ShowListPhone){
              dsphone=state.data;
            }
          },
          builder:(context, state) {
            return BaseScreenMethod(
              title: "settings.sms",
              body: Container(
                margin: EdgeInsets.only(top: AppDimens.SIZE_30),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: List.generate(
                            5,
                                (i) {
                              print(dscontrol.length);
                              //return Text(i.toString());
                              if (i < dsphone.length) {
                                return itemPhone((context), i + 1,
                                    number: dsphone[i], controler: dscontrol[i]);
                              } else
                                return itemPhone((context), i + 1,
                                    number: "", controler: dscontrol[i]);
                            },
                          ),
                        ),
                      ),
                      BlocBuilder<PhoneSetting, BaseState>(
                        builder: (context, state) {
                          if (state is ShowBtnSave) {
                            return Container(
                              width: DeviceUtil.getDeviceWidth(context),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      // _getList();

                                      List<String> dsPhone = [];
                                      if (num1.text.isNotEmpty) dsPhone.add(num1.text);
                                      if (num2.text.isNotEmpty) dsPhone.add(num2.text);
                                      if (num3.text.isNotEmpty) dsPhone.add(num3.text);
                                      if (num4.text.isNotEmpty) dsPhone.add(num4.text);
                                      if (num5.text.isNotEmpty) dsPhone.add(num5.text);
                                      BlocProvider.of<PhoneSetting>(context).add(SaveListPhone(dsPhone));
                                    },
                                    child: Container(
                                      child: Text(
                                        Language.of(context)
                                            .getText("settings.save"),
                                        style: TextStyle(color: AppColors.white),
                                      ),
                                      margin:
                                      EdgeInsets.only(right: AppDimens.SIZE_30),
                                      padding: EdgeInsets.only(
                                          left: AppDimens.SIZE_25,
                                          right: AppDimens.SIZE_25,
                                          top: AppDimens.SIZE_10,
                                          bottom: AppDimens.SIZE_10),
                                      decoration: BoxDecoration(
                                        color: AppColors.blue,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        border: Border.all(width: 0.5),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          } else
                            return Container();
                        },
                      ),
                      BlocConsumer<PhoneSetting,BaseState>(
                        listener: (context, state) {
                          if (state is SavedPhone) {
                           // BlocProvider.of(context).add(LoadPhone());
                             Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(Language.of(context).getText("settings.saved")),
                            ));
                             BlocProvider.of<PhoneSetting>(context).add(LoadPhone());
                          }
                        },
                        builder: (context, state) {
                          return Container();
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
  }
}
