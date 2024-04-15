String? addCommasToNumber(int number) {
  if (number == 0) {
    return null;
  }

  String numString = number.toString();
  String result = '';
  int count = 0;

  for (int i = numString.length - 1; i >= 0; i--) {
    result = numString[i] + result;
    count++;
    if (count % 3 == 0 && i > 0) {
      result = ',$result';
    }
  }

  return result;
}
