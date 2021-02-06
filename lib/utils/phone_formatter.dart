import 'package:flutter/services.dart';

class PhoneTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final StringBuffer newTextBuffer = new StringBuffer();
    int selectionIndex = newValue.selection.end;

    if (newValue.text == '+7 (')
      return new TextEditingValue(
        text: newTextBuffer.toString(),
        selection: TextSelection.collapsed(offset: selectionIndex),
      );
    if (newValue.text.length == 19) {
      {
        return new TextEditingValue(
          text: oldValue.text,
          selection: TextSelection.collapsed(offset: oldValue.selection.end),
        );
      }
    }

    List<String> newString = newValue.text
        .replaceAll(RegExp(r'\D'), '')
        .replaceFirst('7', '')
        .split('');
    List<String> newText = [
      '+',
      '7',
      ' ',
      '(',
      ' ',
      ' ',
      ' ',
      ')',
      ' ',
      ' ',
      ' ',
      ' ',
      '-',
      ' ',
      ' ',
      '-',
      ' ',
      ' ',
    ];
    int newStringEnd = 0;
    for (var i = 0; i < newString.length; i++) {
      int n = getNumberSelection(i);
      newText[n] = newString[i];
      newStringEnd = i;
    }
    newStringEnd = getNumberSelection(newStringEnd + 1);

    selectionIndex = (getNumberTransfer(newValue.selection.end,
        oldValue.selection.end > newValue.selection.end));
    if (selectionIndex > getNumberSelection(newString.length)) {
      if (getNumberSelection(newString.length) != 0)
        selectionIndex = getNumberSelection(newString.length);
    }

    newTextBuffer.write(newText
        .toString()
        .replaceAll(', ', '')
        .replaceAll('[', '')
        .replaceAll(']', '')
        .substring(0, newStringEnd));
    return new TextEditingValue(
      text: newTextBuffer.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }

  int getNumberSelection(int i) {
    int n = 0;
    switch (i) {
      case 0:
        n = 4;
        break;
      case 1:
        n = 5;
        break;
      case 2:
        n = 6;
        break;
      case 3:
        n = 9;
        break;
      case 4:
        n = 10;
        break;
      case 5:
        n = 11;
        break;
      case 6:
        n = 13;
        break;
      case 7:
        n = 14;
        break;
      case 8:
        n = 16;
        break;
      case 9:
        n = 17;
        break;
      case 10:
        n = 18;
        break;
      default:
    }
    return n;
  }

  int getNumberTransfer(int i, bool isBack) {
    int n = 0;
    switch (i) {
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
        n = 5;
        break;
      case 6:
        n = 6;
        break;
      case 7:
        isBack ? n = 7 : n = 9;
        break;
      case 8:
        isBack ? n = 7 : n = 10;
        break;
      case 9:
        n = 7;
        break;
      case 10:
        n = 10;
        break;
      case 11:
        n = 11;
        break;
      case 12:
        isBack ? n = 12 : n = 13;
        // n = 13;
        break;
      case 13:
        isBack ? n = 12 : n = 14;
        break;
      case 14:
        n = 14;
        break;
      case 15:
        isBack ? n = 15 : n = 16;
        break;
      case 16:
        isBack ? n = 15 : n = 17;
        break;
      case 17:
        n = 17;
        break;
      case 18:
        n = 18;
        break;
      default:
        n = 18;

        break;
    }
    return n;
  }
}