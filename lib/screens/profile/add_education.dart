import "package:flutter/material.dart";
import 'package:linkup/components/rounded_button.dart';
import 'package:linkup/components/rounded_text_field.dart';
import 'package:linkup/components/rounded_textarea_field.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../constants.dart';

class AddEducation extends StatefulWidget {
  const AddEducation({Key key}) : super(key: key);

  @override
  _AddEducationState createState() => _AddEducationState();
}

class _AddEducationState extends State<AddEducation> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add education",
          style: TextStyle(fontFamily: fontFamilySFPro),
        ),
        backgroundColor: colorDarkMidGround,
        elevation: 0.0,
      ),
      backgroundColor: colorDarkBackground,
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: orientation == Orientation.landscape
                ? size.width * 0.8
                : size.width,
            height: orientation == Orientation.landscape
                ? size.height * 1.15
                : size.height * 0.8,
            padding: const EdgeInsets.all(0.0),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Form(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    RoundedTextField(
                      text: "Course*",
                      onChange: (value) {
                        print(value);
                      },
                      isRequired: true,
                      backgroundColor: colorDarkBackground,
                      textAreaColor: colorDarkMidGround,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RoundedTextField(
                      text: "School/ Institute name*",
                      onChange: (value) {
                        print(value);
                      },
                      isRequired: true,
                      backgroundColor: colorDarkBackground,
                      textAreaColor: colorDarkMidGround,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, bottom: 5),
                        child: Text(
                          "Period",
                          style: TextStyle(
                            fontFamily: fontFamilySFPro,
                            fontSize: 16,
                            color: colorTextPrimary,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.88,
                      child: SfDateRangePicker(
                        showNavigationArrow: false,
                        onSelectionChanged: (value) {
                          print("VALUE: " + value.value.toString());
                        },
                        monthViewSettings:
                            const DateRangePickerMonthViewSettings(
                          showWeekNumber: false,
                          firstDayOfWeek: 1,
                          viewHeaderStyle: DateRangePickerViewHeaderStyle(
                            textStyle: TextStyle(
                              color: colorTextPrimary,
                            ),
                          ),
                          weekNumberStyle: DateRangePickerWeekNumberStyle(
                            textStyle: TextStyle(fontStyle: FontStyle.italic),
                            backgroundColor: Colors.purple,
                          ),
                        ),
                        backgroundColor: colorDarkMidGround,
                        yearCellStyle: const DateRangePickerYearCellStyle(
                          textStyle: TextStyle(
                            color: colorTextPrimary,
                          ),
                        ),
                        monthCellStyle: const DateRangePickerMonthCellStyle(
                          weekendTextStyle: TextStyle(
                            color: Colors.red,
                          ),
                          textStyle: TextStyle(
                            color: colorTextPrimary,
                          ),
                        ),
                        headerStyle: const DateRangePickerHeaderStyle(
                          backgroundColor: colorDarkForground,
                          textStyle: TextStyle(
                            color: colorTextPrimary,
                          ),
                        ),
                        selectionTextStyle: const TextStyle(
                          color: colorTextPrimary,
                        ),
                        rangeTextStyle: const TextStyle(
                          color: colorTextPrimary,
                        ),
                        selectionMode: DateRangePickerSelectionMode.range,
                        view: DateRangePickerView.year,
                        initialSelectedRange: PickerDateRange(
                          DateTime.now().subtract(
                            const Duration(days: 4),
                          ),
                          DateTime.now().add(
                            const Duration(days: 3),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: RoundedButton(
                        color: colorDarkForground,
                        text: "Save",
                        width: size.width * 0.9,
                        height: 40,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
