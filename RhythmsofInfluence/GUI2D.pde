String[] genreLabels = {
  "Rock-Press'r'",
  "Funk-Press'f'",
  "Folk-Press'o'",
  "Hip Hop-Press'h'",
  "Electronic-Press'e'",
  "Blues-Press'b'",
  "Jazz-Press'j'",
  "Soul-Press's'",
  "Pop-Press'p'",
  "Country-Press'c'"
};

String[] lines = {
  "Press \'x\' to display festivals",
  "Press \'q\' to save canvas",
  //"Double-click to return to initial view"
};

String longText = "The observe of checkout fluctuations during and around music festivals aims to analyze whether there is a direct correlation between these cultural events and shifts in genre popularity at SPL. The data will reveal broader trends in music consumption and genre popularity over the years, offering a historical perspective on how music interests have evolved in the era of digital transformation.";

void drawTitleText() {
  cam.beginHUD();
  textFont(createFont("Arial", 36));
  fill(isDarkMode ? 255 : 0);
  textAlign(CENTER, CENTER);
  textSize(36);
  //textFont(createFont("SansSerif.bold", 36));

  float textX = width / 2;
  float textY = 70;
  //float textZ = -boxDepth / 2;

  text("RHYTHMS OF INFLUENCE", textX, textY);

  textSize(24);
  //textFont(createFont("SansSerif", 24));
  text(" Tracing music festival echoes in Seattle Public Library (SPL)", textX, textY + 50);

  cam.endHUD();
}

void drawGenreLabelsAndCircles() {
  cam.beginHUD();
  textFont(createFont("Arial", 15));
  textAlign(LEFT, CENTER);
  textSize(15);

  //float startX = width - 30;
  float startX = 180;
  float startY = height - 23 * genreLabels.length;

  for (int i = 0; i < genreLabels.length; i++) {
    fill(colors[i % colors.length]);
    noStroke();
    ellipse(startX - 130, startY + i * 20 + 10, 10, 10);

    fill(isDarkMode ? 255 : 0);
    text(genreLabels[i], startX-110, startY + i * 20 + 7 );
  }
  cam.endHUD();
}

void drawTextWithSquares() {
  cam.beginHUD();
  textFont(createFont("Arial", 15));
  fill(isDarkMode ? 255 : 0);
  textSize(15);
  textAlign(LEFT, CENTER);

  int startX = width - 100;
  int startY = height - 33 * lines.length;

  for (int i = 0; i < lines.length; i++) {
    rect(startX-140, startY + 20 * i, 8, 8);
    text(lines[i], startX-120, startY + 20 * i + 2);
  }
  cam.endHUD();
}

void drawCenteredText(String text, float y, float boxWidth) {
  cam.beginHUD();
  float margin = 360;
  float maxWidth = boxWidth - 2 * margin;
  String[] words = text.split(" ");
  String currentLine = "";
  ArrayList<String> lines = new ArrayList<String>();
  textFont(createFont("Arial", 13));
  textAlign(CENTER, TOP);
  textSize(13);

  for (String word : words) {
    String testLine = currentLine + word + " ";
    if (textWidth(testLine) < maxWidth) {
      currentLine = testLine;
    } else {
      lines.add(currentLine);
      currentLine = word + " ";
    }
  }
  lines.add(currentLine);

  float textBlockHeight = lines.size() * (textAscent() + textDescent() - 26);
  float startY = y - textBlockHeight / 2;

  for (int i = 0; i < lines.size(); i++) {
    text(lines.get(i), width / 2, startY + i * (textAscent() + textDescent() -2));
  }
  cam.endHUD();
}

void displayHoveredDate(String date) {
  cam.beginHUD();
  textFont(createFont("Arial", 16));
  fill(isDarkMode ? 255 : 0);
  textAlign(RIGHT, TOP);
  textSize(16);
  text(date, width - 30, 30);
  cam.endHUD();
}

void addTextfield(String name, int x, int y) {
  cp5.addTextfield(name)
    .setPosition(x, y)
    .setSize(50, 20)
    .setFont(createFont("Arial", 14))
    .setColor(isDarkMode ? 255 : 0)
    .setColorActive(color(239, 68, 127))
    .setColorForeground(color(isDarkMode ? 255 : 0))
    .setColorBackground(color(230))
    .setLabel(" " + name)
    .getCaptionLabel().setFont(createFont("Arial", 14)).toUpperCase(false).setSize(14).setColor(isDarkMode ? 255 : 0);
}

void updateControlColors() {
  int textColor = isDarkMode ? 255 : 0;
  int bgColor = isDarkMode ? color(120) : color(230);

  updateTextfieldColors("Year", textColor, bgColor);
  updateTextfieldColors("Month", textColor, bgColor);
  updateTextfieldColors("Day", textColor, bgColor);
}

void updateTextfieldColors(String name, int textColor, int bgColor) {
  cp5.get(Textfield.class, name)
    .setColor(textColor)
    .setColorForeground(textColor)
    .setColorBackground(bgColor)
    .getCaptionLabel().setColor(textColor);
}
