import 'package:emma_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarMarker {
  final DateTime dateTime;
  final Color color;

  const CalendarMarker({this.dateTime, this.color});
}

class Calendar extends StatefulWidget {
  final List<String> weekDays;
  final double viewportFraction;
  final TextStyle daysTextStyle;
  final TextStyle nextDaysTextStyle;
  final double height;
  final double width;
  final TextStyle todayTextStyle;
  final TextStyle selectedDayTextStyle;
  final bool daysHaveCircularBorder;
  final Function(DateTime) onDayPressed;
  final Function(DateTime) onMonthChanged;
  final TextStyle weekdayTextStyle;
  final Color iconColor;
  final List<CalendarMarker> markedDates;
  final double childAspectRatio;
  final EdgeInsets weekDayMargin;
  final TextStyle titleStyle;
  final TextStyle outThisMonthStyle;
  final TextStyle defaultDaysTextStyle;

//  If true then picking two dates will select all days between those days
  final bool isIntervalSelectable;

  Calendar({
    this.weekDays = const ['ПН', 'ВТ', 'СР', 'ЧТ', 'ПТ', 'СБ', 'ВС'],
    this.viewportFraction = 1.0,
    this.daysTextStyle,
    this.nextDaysTextStyle,
    this.height = double.infinity,
    this.width = double.infinity,
    this.todayTextStyle,
    this.selectedDayTextStyle,
    this.daysHaveCircularBorder,
    this.onDayPressed,
    this.onMonthChanged,
    this.weekdayTextStyle,
    this.iconColor = Colors.grey,
    this.markedDates,
    this.childAspectRatio = 1.0,
    this.weekDayMargin = const EdgeInsets.only(bottom: 4.0),
    this.isIntervalSelectable,
    this.titleStyle,
    this.outThisMonthStyle,
    this.defaultDaysTextStyle,
  });

  @override
  CalendarState createState() => CalendarState();
}

class CalendarState extends State<Calendar> {
  PageController _controller;
  List<DateTime> _dates = List(3);
  int _startWeekday = 0;
  int _endWeekday = 0;

  @override
  void initState() {
    super.initState();

    _controller = PageController(
      initialPage: 1,
      keepPage: true,
      viewportFraction: widget.viewportFraction,
    );
    setDate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setDate(page: 0);
                },
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_left,
                    color: widget.iconColor,
                  ),
                ),
              ),
              Text(
                '${DateFormat('LLLL yyyy').format(_dates[1]).toUpperCase()}',
                style: widget.titleStyle,
              ),
              GestureDetector(
                onTap: () => setDate(page: 2),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    color: widget.iconColor,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: renderWeekDays(),
            ),
          ),
          Expanded(
            child: PageView.builder(
              itemCount: 3,
              onPageChanged: (value) {
                setDate(page: value);
              },
              controller: _controller,
              itemBuilder: (context, index) {
                final int totalItemCount = DateTime(
                      _dates[index].year,
                      _dates[index].month + 1,
                      0,
                    ).day +
                    _startWeekday +
                    (7 - _endWeekday);
                final int year = _dates[index].year;
                final int month = _dates[index].month;
                return GridView.count(
                  crossAxisCount: 7,
                  childAspectRatio: widget.childAspectRatio,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: List.generate(
                    totalItemCount,

                    /// last day of month + weekday
                    (index) {
                      final bool isPrevMonthDay = index < _startWeekday;
                      final bool isNextMonthDay = index >=
                          (DateTime(year, month + 1, 0).day) + _startWeekday;

                      final bool isThisMonthDay =
                          !isPrevMonthDay && !isNextMonthDay;

                      DateTime now = DateTime(year, month, 1);
                      TextStyle style;
                      if (isPrevMonthDay) {
                        now = now.subtract(
                          Duration(days: _startWeekday - index),
                        );
                        style = widget.outThisMonthStyle;
                      } else if (isThisMonthDay) {
                        now = DateTime(year, month, index + 2 - _startWeekday);
                        style = widget.defaultDaysTextStyle;
                      } else {
                        now = DateTime(year, month, index + 2 - _startWeekday);
                        style = widget.outThisMonthStyle;
                      }
                      final today = DateTime.now();
                      if (now.isInDay(today)) {
                        style = widget.todayTextStyle;
                      }

                      final marketIndex =
                          isDateMarked(year, month, index + 2 - _startWeekday);

                      return GestureDetector(
                        onTap: () => widget.onDayPressed(now),
                        behavior: HitTestBehavior.opaque,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 5.h),
                              child: Text(
                                '${now.day}',
                                style: style,
                              ),
                            ),
                            if (marketIndex != -1 && isThisMonthDay)
                              Padding(
                                padding: EdgeInsets.only(top: 2.h),
                                child: Container(
                                  width: 8.w,
                                  height: 8.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: widget.markedDates[marketIndex].color,
                                  ),
                                ),
                              )
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
              pageSnapping: true,
            ),
          ),
        ],
      ),
    );
  }

  void setDate({int page}) {
    if (page == null) {
      /// setup dates
      final DateTime date0 =
          DateTime(DateTime.now().year, DateTime.now().month - 1, 1);
      final date1 = DateTime(DateTime.now().year, DateTime.now().month, 1);
      final date2 = DateTime(DateTime.now().year, DateTime.now().month + 1, 1);

      setState(() {
        /// setup current day
        _startWeekday = date1.weekday;
        _endWeekday = date2.weekday;
        _dates = [
          date0,
          date1,
          date2,
        ];
      });
    } else if (page == 1) {
      return;
    } else {
      final dates = _dates;
      if (page == 0) {
        dates[2] = DateTime(dates[0].year, dates[0].month + 1, 1);
        dates[1] = DateTime(dates[0].year, dates[0].month, 1);
        dates[0] = DateTime(dates[0].year, dates[0].month - 1, 1);
        page = page + 1;
        if (widget.onMonthChanged != null) {
          widget.onMonthChanged(dates[1]);
        }
      } else if (page == 2) {
        dates[0] = DateTime(dates[2].year, dates[2].month - 1, 1);
        dates[1] = DateTime(dates[2].year, dates[2].month, 1);
        dates[2] = DateTime(dates[2].year, dates[2].month + 1, 1);
        page = page - 1;
        if (widget.onMonthChanged != null) {
          widget.onMonthChanged(dates[1]);
        }
      }

      setState(() {
        _startWeekday = dates[page].weekday;
        _endWeekday = dates[page + 1].weekday;
        _dates = dates;
      });

      _controller.animateToPage(page,
          duration: const Duration(milliseconds: 1),
          curve: const Threshold(0.0));
    }
  }

  List<Widget> renderWeekDays() {
    final list = <Widget>[];
    for (int i = 0; i < widget.weekDays.length; i++) {
      list.add(
        Text(
          widget.weekDays[i],
          style: widget.weekdayTextStyle?.copyWith(
            color: (i == 5 || i == 6) ? AppColors.cFF3B30 : null,
          ),
        ),
      );
    }
    return list;
  }

  int selectedDayIndex(int year, month, day) {
    return widget.markedDates.map((e) => e.dateTime).toList().lastIndexWhere(
        (e) => e.year == year && e.month == month && e.day == day);
  }

  bool isDateEqual(DateTime date, int year, int month, int day) {
    return date != null &&
        date.year == year &&
        date.month == month &&
        date.day == day;
  }

  int isDateMarked(int year, int month, int day) {
    for (var i = 0; i < widget.markedDates.length; i++) {
      if (isDateEqual(widget.markedDates[i].dateTime, year, month, day)) {
        return i;
      }
    }
    return -1;
  }
}
