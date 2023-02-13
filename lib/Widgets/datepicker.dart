import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

/// app root
class DateTimePicker extends StatefulWidget {
  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

/// app state
class _DateTimePickerState extends State<DateTimePicker> {
  String? dateCount;
  String? range;

  @override
  void initState() {
    dateCount = '';
    range = '';
    super.initState();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        range =
            DateFormat('dd/MM/yyyy').format(args.value.startDate).toString() +
                ' - ' +
                DateFormat('dd/MM/yyyy')
                    .format(args.value.endDate ?? args.value.startDate)
                    .toString();
      } else if (args.value is DateTime) {
      } else if (args.value is List<DateTime>) {
        dateCount = args.value.length.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SfDateRangePicker(
      onSelectionChanged: _onSelectionChanged,
      selectionMode: DateRangePickerSelectionMode.single,
      minDate: DateTime(1900, 01, 01, 0, 0, 0),
      maxDate: DateTime.now(),
      view: DateRangePickerView.century,
      showNavigationArrow: true,
      monthViewSettings: DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
      initialSelectedRange: PickerDateRange(
          DateTime.now().subtract(const Duration(days: 4)),
          DateTime.now().add(const Duration(days: 3))),
    );
  }
}
