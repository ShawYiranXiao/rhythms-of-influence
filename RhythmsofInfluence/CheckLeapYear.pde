// Helper function to check if a given year is a leap year
boolean isLeapYear(int year) {
  return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
}

// Function to calculate the day of the year from a given date
int dayOfYear(int year, int month, int day) {
  int[] daysInMonth = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
  if (isLeapYear(year)) {
    daysInMonth[2] = 29;
  }
  int dayCount = 0;
  for (int i = 1; i < month; i++) {
    dayCount += daysInMonth[i];
  }
  dayCount += day;
  return dayCount;
}
