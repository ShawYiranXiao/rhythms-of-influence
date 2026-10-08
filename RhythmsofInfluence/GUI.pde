// Function to draw year
void drawYears(int startYear, int endYear, float depthPosition) {
  for (int year = startYear; year <= endYear; year++) {
    pushMatrix();
    float x = map(year, startYear, endYear, -boxWidth / 2, boxWidth / 2);
    translate(x, boxHeight / 2 + 230, depthPosition);
    text(year, 0, 0);
    popMatrix();
  }
}

// Function to draw month
void drawMonths(String[] months, float depthPosition) {
  for (int month = 1; month <= 12; month++) {
    pushMatrix();
    float y = map(month, 1, 12, -boxHeight / 2, boxHeight / 2);
    translate(-boxWidth / 2 - 320, y, depthPosition);
    text(months[month - 1], 0, 0);
    popMatrix();
  }
}

// Function to draw date
void drawDates(int step, float yOffset) {
  for (int date = 1; date <= 31; date += step) {
    pushMatrix();
    float z = map(date, 1, 31, boxDepth / 2, -boxDepth / 2);
    translate(boxWidth / 2 + 300, yOffset, z);
    text(date, 0, 0);
    popMatrix();
  }
}

void drawLabels() {
  textFont(createFont("Arial", 60));
  textSize(60); // text size for labels
  fill(isDarkMode ? 255 : 0); // color for text

  // Years along the x-axis
  drawYears(startYear, endYear, boxDepth / 2);
  drawYears(startYear, endYear, -boxDepth / 2);

  // Months along the y-axis
  String[] months = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
  drawMonths(months, -boxDepth / 2);
  drawMonths(months, boxDepth / 2);

  // Dates along the z-axis
  int step = 5;
  drawDates(step, -boxHeight / 2);
  drawDates(step, boxHeight / 2);
}

// Function to draw lines based on months
//void drawMonthLines() {
//  stroke(10);
//  strokeWeight(1);
//  for (int month = 1; month <= 12; month++) {
//    float y = map(month, 1, 12, -boxHeight / 2, boxHeight / 2);
//    line(-boxWidth / 2, y, -boxDepth/2, boxWidth / 2, y, -boxDepth/2);
//  }
//}

void drawBallsForMonthsAndDates() {
  //float ballSize = 50;
  float crossSize = 30;
  float lineWeight = 1;

  for (int year = startYear; year <= endYear; year+=4) {
    float x = map(year, startYear, endYear, -boxWidth / 2, boxWidth / 2);

    for (int month = 0; month < 12; month+=5) {
      float y = map(month, 0, 11, -boxHeight / 2, boxHeight / 2);

      for (int date = 1; date <= 31; date+=10) {
        float z = map(date, 1, 31, boxDepth / 2, -boxDepth / 2);

        pushMatrix();
        translate(x, y, z);
        //fill(10);
        //noStroke();
        //sphere(ballSize);
        stroke(isDarkMode ? 255 : 0);
        strokeWeight(lineWeight);

        line(-crossSize / 2, 0, 0, crossSize / 2, 0, 0);
        line(0, -crossSize / 2, 0, 0, crossSize / 2, 0);

        popMatrix();
      }
    }
  }
}
