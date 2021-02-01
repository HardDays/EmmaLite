class PickerTimeRange {
  final int minHour;
  final int maxHour;

  const PickerTimeRange({this.minHour, this.maxHour});

  factory PickerTimeRange.calculate({
    int maxCount,
    int currentNumber,
  }) {
    if (maxCount == 1) {
      return PickerTimeRange(minHour: 0, maxHour: 23);
    }
    if (maxCount == 2) {
      if (currentNumber == 0) {
        return PickerTimeRange(minHour: 0, maxHour: 13);
      }
      if (currentNumber == 1) {
        return PickerTimeRange(minHour: 14, maxHour: 23);
      }
    }
    if (maxCount == 3) {
      if (currentNumber == 0) {
        return PickerTimeRange(minHour: 0, maxHour: 11);
      }
      if (currentNumber == 1) {
        return PickerTimeRange(minHour: 12, maxHour: 16);
      }
      if (currentNumber == 2) {
        return PickerTimeRange(minHour: 17, maxHour: 23);
      }
    }
    if (maxCount == 4) {
      if (currentNumber == 0) {
        return PickerTimeRange(minHour: 0, maxHour: 9);
      }
      if (currentNumber == 1) {
        return PickerTimeRange(minHour: 10, maxHour: 14);
      }
      if (currentNumber == 2) {
        return PickerTimeRange(minHour: 15, maxHour: 18);
      }
      if (currentNumber == 3) {
        return PickerTimeRange(minHour: 19, maxHour: 23);
      }
    }
    if (maxCount == 5) {
      if (currentNumber == 0) {
        return PickerTimeRange(minHour: 0, maxHour: 9);
      }
      if (currentNumber == 1) {
        return PickerTimeRange(minHour: 10, maxHour: 12);
      }
      if (currentNumber == 2) {
        return PickerTimeRange(minHour: 13, maxHour: 16);
      }
      if (currentNumber == 3) {
        return PickerTimeRange(minHour: 17, maxHour: 20);
      }
      if (currentNumber == 4) {
        return PickerTimeRange(minHour: 21, maxHour: 23);
      }
    }
    if (maxCount == 6) {
      if (currentNumber == 0) {
        return PickerTimeRange(minHour: 0, maxHour: 7);
      }
      if (currentNumber == 1) {
        return PickerTimeRange(minHour: 8, maxHour: 10);
      }
      if (currentNumber == 2) {
        return PickerTimeRange(minHour: 11, maxHour: 13);
      }
      if (currentNumber == 3) {
        return PickerTimeRange(minHour: 14, maxHour: 16);
      }
      if (currentNumber == 4) {
        return PickerTimeRange(minHour: 17, maxHour: 19);
      }
      if (currentNumber == 5) {
        return PickerTimeRange(minHour: 20, maxHour: 23);
      }
    }
    return null;
  }
}