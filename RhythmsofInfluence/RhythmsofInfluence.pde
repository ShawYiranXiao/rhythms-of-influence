/*************************************************************************************
 Rhythms of Influence
 
 This project is to analyze the impact of specific music festivals in Seattle (such as Capitol Hill Block Party, Bumbershoot, Belltown Bloom Festival, Beyond Wonderland Seattle, and Northwest Folklife), on the popularity of various music genres in the Seattle Public Library's collection.
 
 Author: Yiran(Shaw) Xiao (c) 2024
 
 Created in M259, instructor George Legrady, Media Arts & Technology, UCSB, Winter 2024
 
 Realized in Processing 4
 *************************************************************************************/

import controlP5.*;
import peasy.*;

PeasyCam cam;
ControlP5 cp5;

boolean showData = true; // Flag to toggle data visualization

boolean isDarkMode = false;

//int textColor = isDarkMode ? 255 : 0;

String hoveredDate = "";

String[][] colorsets = {
  {"#b2ff9e", "#affc41", "#70e000", "#1dd3b0", "#38b000"}, // Hip Hop-bright green
  {"#d10000", "#ff2c55", "#ffcbdd", "#ec5766", "#f7b2b7"}, // Rock-red
  {"#add7f6", "#87bfff", "#9bb1ff", "#788bff", "#5465ff"}, // Jazz-deep blue
  {"#adfda2", "#93f6b0", "#5fe8cb", "#45e1d8", "#2bdae6"}, // electronic-bright cyan
  {"#9729EF", "#FF36AB", "#FF74D4", "#FFB8DE", "#FFDDE1"}, // pop-vibrant pink
  {"#fae3c6", "#ff8fab", "#ffb3c6", "#ff8fab", "#ff4d6d"}, // country- light pink
  {"#f8af86", "#fbc851", "#fcd436", "#fee11b", "#ffed00"}, // folk- warm yellow
  {"#DC98EB", "#A879DA", "#8E69D2", "#7359C9", "#3E39B8"}, // soul-rich purple
  {"#48cae4", "#48cae4", "#65afff", "#0a85ed", "#caf0f8"}, // blues-dark indigo or midnight blue
  {"#ff374e", "#ff6166", "#ffc052", "#ff8c34", "#ff6929"}  // funk- bright orange
};

//genre label circle color set
color[] colors;

HashMap<String, Integer> colorMap = new HashMap<String, Integer>();

String currentGenre = "soul"; // Default genre
int boxWidth = 2800;
int boxHeight = 2200;
int boxDepth = 3200;

int startYear = 2015;
int endYear = 2023;

Table table;
ArrayList<Item> items = new ArrayList<Item>();
ArrayList<Float> map_size = new ArrayList<Float>();

ArrayList<Firework> fireworks;
PVector systemCenter;
float hoverRadius = 50;

int numParticles = 100;
int numLines = 700;
int numDots = 1100;

float fireworksX, fireworksY, fireworksZ;

PVector dateToPosition(int year, int month, int date) {
  float x = map(year, startYear, endYear, -boxWidth / 2, boxWidth / 2);
  float y = map(month, 1, 12, -boxHeight / 2, boxHeight / 2);
  float z = map(date, 1, 31, boxDepth / 2, -boxDepth / 2);
  return new PVector(x, y, z);
}

void setup() {
  //size(1000, 800, P3D);
  fullScreen(P3D);
  frameRate(24);

  cam = new PeasyCam(this, 8000);
  cam.setMinimumDistance(200);
  cam.setMaximumDistance(5000);

  cp5 = new ControlP5(this);

  addTextfield("Year", 30, 30);
  addTextfield("Month", 90, 30);
  addTextfield("Day", 150, 30);

  //mode toggle button
  cp5.addButton("toggleMode")
    .setPosition(30, 100)
    .setSize(100, 30)
    .setLabel("Toggle Mode")
    .setColorActive(color(132, 111, 210))
    .setColorForeground(color(132, 111, 210))
    .setColorBackground(color(120))
    .setFont(createFont("Arial", 12))
    .onClick(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      isDarkMode = !isDarkMode;
      updateControlColors();
    }
  }
  );

  cp5.setAutoDraw(false);

  //genre label circle colors
  colors = new color[]{
    color(209, 0, 0), //red-rock
    color(255, 140, 52), //orange- funk
    color(254, 225, 27), //yellow-folk
    color(112, 224, 0), //green-hip hop
    color(95, 232, 203), //cyan-elec
    color(72, 202, 228), //blue-blues
    color(120, 139, 255), //light blue - jazz
    color(168, 121, 218), //purple- soul
    color(255, 54, 171), //pink-pop
    color(255, 143, 171), //light pink-country
  };

  table = loadTable("CheckOutNum_Date.csv", "header");
  for (TableRow row : table.rows()) {
    // Creating a new Item object with the row, which now includes multiple genres
    Item newItem = new Item(row);
    items.add(newItem);
  }
  colorMap.put("hip hop", 0);
  colorMap.put("rock", 1);
  colorMap.put("jazz", 2);
  colorMap.put("electronic", 3);
  colorMap.put("pop", 4);
  colorMap.put("country", 5);
  colorMap.put("folk", 6);
  colorMap.put("soul", 7);
  colorMap.put("blues", 8);
  colorMap.put("funk", 9);

  map_size.add(200.0f); //hip hop
  map_size.add(800.0f); //rock
  map_size.add(400.0f); //jazz
  map_size.add(200.0f); //electronic
  map_size.add(900.0f); //pop
  map_size.add(200.0f); //country
  map_size.add(200.0f); //folk
  map_size.add(200.0f); //soul
  map_size.add(200.0f); //blues
  map_size.add(200.0f); //funk

  fireworks = new ArrayList<Firework>();

  //print(items.get(0).day);
  fireworks.add(new Firework(dateToPosition(2016, 7, 25), new color[]{#b2ff9e, #affc41, #70e000, #1dd3b0, #38b000}, "Capitol Hill Block Party", "07-25-2016", 4600));  //hip hop
  fireworks.add(new Firework(dateToPosition(2019, 7, 19), new color[]{#d10000, #ff2c55, #ffcbdd, #ec5766, #f7b2b7}, "Capitol Hill Block Party", "07-19-2019", 8400));  //rock
  fireworks.add(new Firework(dateToPosition(2020, 9, 5), new color[]{#ff374e, #ff6166, #ffc052, #ff8c34, #ff6929}, "Bumbershoot", "09-05-2020", 8800)); //funk
  fireworks.add(new Firework(dateToPosition(2018, 5, 23), new color[]{#f8af86, #fbc851, #fcd436, #fee11b, #ffed00}, "Northwest Folklife", "05-23-2018", 5800)); //folk
  fireworks.add(new Firework(dateToPosition(2016, 9, 2), new color[]{#9729EF, #FF36AB, #FF74D4, #FFB8DE, #FFDDE1}, "Bumbershoot", "09-02-2016", 8000)); //pop
  fireworks.add(new Firework(dateToPosition(2021, 7, 20), new color[]{#9729EF, #FF36AB, #FF74D4, #FFB8DE, #FFDDE1}, "Capitol Hill Block Party", "07-20-2021", 9000)); //pop
  fireworks.add(new Firework(dateToPosition(2019, 10, 15), new color[]{#48cae4, #48cae4, #65afff, #0a85ed, #caf0f8}, "Earshot Jazz", "10-15-2019", 5000)); //blues
  fireworks.add(new Firework(dateToPosition(2022, 10, 1), new color[]{#add7f6, #87bfff, #9bb1ff, #788bff, #5465ff}, "Earshot Jazz", "10-01-2022", 5600)); //jazz
  fireworks.add(new Firework(dateToPosition(2023, 5, 5), new color[]{#ff374e, #ff6166, #ffc052, #ff8c34, #ff6929}, "Belltown Bloom Festival", "05-05-2023", 8600));//funk
  fireworks.add(new Firework(dateToPosition(2017, 5, 6), new color[]{#DC98EB, #A879DA, #8E69D2, #7359C9, #3E39B8}, "Belltown Bloom Festival", "05-06-2017", 8000));//soul
  fireworks.add(new Firework(dateToPosition(2022, 6, 19), new color[]{#adfda2, #93f6b0, #5fe8cb, #45e1d8, #2bdae6}, "Beyond Wonderland Seattle", "06-19-2022", 4000));//electric
  fireworks.add(new Firework(dateToPosition(2024, 5, 28), new color[]{#f8af86, #fbc851, #fcd436, #fee11b, #ffed00}, "Northwest Folklife", "05-28-2024", 9600));//folk
  fireworks.add(new Firework(dateToPosition(2021, 5, 25), new color[]{#fae3c6, #ff8fab, #ffb3c6, #ff8fab, #ff4d6d}, "Northwest Folklife", "05-25-2021", 9800));//country
}

void draw() {
  //background(250);
  if (isDarkMode) {
    background(20);
  } else {
    background(250);
  }

  cam.beginHUD();
  cp5.draw();
  cam.endHUD();

  String yearStr = cp5.get(Textfield.class, "Year").getText();
  String monthStr = cp5.get(Textfield.class, "Month").getText();
  String dayStr = cp5.get(Textfield.class, "Day").getText();

  int year = yearStr.isEmpty() ? -1 : Integer.parseInt(yearStr);
  int month = monthStr.isEmpty() ? -1 : Integer.parseInt(monthStr);
  int day = dayStr.isEmpty() ? -1 : Integer.parseInt(dayStr);

  hoveredDate = "";
  int index_color = colorMap.get(currentGenre);

  if (showData) {
    for (Item item : items) {
      if ((year == -1 || item.year == year) && (month == -1 || item.month == month) && (day == -1 || item.day == day)) {
        float x = map(item.year, startYear, endYear, -boxWidth / 2, boxWidth / 2);
        float y = map(item.month, 1, 12, -boxHeight / 2, boxHeight / 2);
        float z = map(item.day, 1, 31, boxDepth / 2, -boxDepth / 2);

        float screenX = screenX(x, y, z);
        float screenY = screenY(x, y, z);
        if (dist(mouseX, mouseY, screenX, screenY) < hoverRadius) {
          hoveredDate = item.year + "-" + nf(item.month, 2) + "-" + nf(item.day, 2);
        }

        int checkoutNumber = item.genreCheckouts.get(currentGenre);
        pushMatrix();
        translate(x, y, z);
        drawVisualEffect_with_name(checkoutNumber, index_color);
        popMatrix();
      }
    }
  } else {
    // Fireworks effect
    for (Firework firework : fireworks) {
      firework.update();
      firework.display();
      firework.checkHoverEffect();
      firework.checkAndExplodeAgain();
    }
    //drawMonthLines();
    drawBallsForMonthsAndDates();
  }
  if (!hoveredDate.equals("")) {
    displayHoveredDate(hoveredDate);
  }
  drawLabels();
  drawTitleText();
  drawGenreLabelsAndCircles();
  drawTextWithSquares();
  drawCenteredText(longText, height - 100, width);
}

void drawVisualEffect_with_name(int checkoutNumber, int index) {
  float size = map(checkoutNumber, 0, map_size.get(index), 10, 300);
  float alphaValue = map(checkoutNumber, 0, map_size.get(index), 0, 255);
  float rotationSpeed = map(checkoutNumber, 0, map_size.get(index), 0.01, 0.1);

  int colorIndex = int(random(colorsets[index].length));
  String hexColor = colorsets[index][colorIndex];
  int col = unhex("FF" + hexColor.substring(1));

  stroke(col, alphaValue);
  strokeWeight(2);

  for (int i = 0; i < 360; i += 8) {
    float angle = radians(i);
    float len = sin(frameCount * rotationSpeed + angle) * size;
    //println(frameCount);
    line(0, 0, len * cos(angle), len * sin(angle));
  }
}

class Firework {
  ArrayList<Particle> particles;
  PVector center;
  color[] palette;
  String hoverText;
  String dateText;
  float delay; // delay time in milliseconds
  boolean hasExploded = false;
  float lastExplodeTime = 0;
  float explodeInterval = 1000;

  Firework(PVector center, color[] palette, String hoverText, String dateText, float delay) {
    this.center = center;
    this.palette = palette;
    this.hoverText = hoverText;
    this.dateText = dateText;
    this.delay = delay;
    this.particles = new ArrayList<Particle>();
  }


  void explode() {
    lastExplodeTime = millis();
    for (int i = 0; i < 300; i++) {
      particles.add(new Particle(center.x, center.y, center.z, palette[int(random(palette.length))]));
    }
    for (int i = 0; i < numLines; i++) {
      particles.add(new LineParticle(center.x, center.y, center.z, palette[int(random(palette.length))]));
    }
    for (int i = 0; i < numDots; i++) {
      particles.add(new DotParticle(center.x, center.y, center.z, palette[int(random(palette.length))]));
    }
  }

  class Particle {
    PVector position;
    PVector velocity;
    float lifespan = 255;
    color col;
    boolean isFading = false;

    Particle(float x, float y, float z, color col) {
      this.position = new PVector(x, y, z);
      this.velocity = PVector.random3D();
      //this.velocity.mult(random(6.1, 80.5));
      this.velocity.mult(random(1.1, 35.5));
      this.col = col;
    }

    void update() {
      if (!hasExploded && millis() >= delay) {
        explode();
        hasExploded = true;
      }

      position.add(velocity);
      if (lifespan <= 254 && !isFading) { // Maintains transparency when it is below 254 and is not in a fast disappearing state.
        lifespan -= 0.0000001; // Slowing down the rate of transparency reduction
        if (lifespan <= 254) { // when the transparency is 254, it starts quickly fade
          isFading = true;
        }
      } else {
        lifespan -= 1; // quickly fade
      }
      position.add(velocity);
      //lifespan -= 30;
      lifespan -= 20;
    }

    boolean isFinished() {
      return lifespan <= 0;
    }

    void display() {
      pushMatrix();
      translate(position.x, position.y, position.z);
      fill(col, max(0, lifespan));
      noStroke();
      sphere(4);
      popMatrix();
    }
  }

  void update() {
    for (int i = particles.size() - 1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.update();
      if (p.isFinished()) {
        particles.remove(i);
      }
    }
  }

  void display() {
    for (Particle particle : particles) {
      particle.display();
    }
  }

  class LineParticle extends Particle {
    LineParticle(float x, float y, float z, color col) {
      super(x, y, z, col);
    }

    void display() {
      stroke(col, max(0, lifespan));
      strokeWeight(1);
      PVector endPoint = PVector.add(position, PVector.mult(velocity, 0.8));
      line(position.x, position.y, position.z, endPoint.x, endPoint.y, endPoint.z);
    }
  }

  class DotParticle extends Particle {
    DotParticle(float x, float y, float z, color col) {
      super(x, y, z, col);
    }

    void display() {
      stroke(col, max(0, lifespan));
      strokeWeight(2);
      point(position.x, position.y, position.z);
    }
  }

  void checkHoverEffect() {
    float centerX = screenX(center.x, center.y, center.z);
    float centerY = screenY(center.x, center.y, center.z);
    float distToCenter = dist(mouseX, mouseY, centerX, centerY);
    if (distToCenter < hoverRadius) {
      displayHoverText(hoverText, dateText, mouseX, mouseY);
    }
  }

  void displayHoverText(String hoverText, String dateText, float x, float y) {
    cam.beginHUD();
    textFont(createFont("Arial", 20));
    fill(isDarkMode ? 255 : 0);
    noStroke();
    textAlign(CENTER, CENTER);
    textSize(20);
    text(hoverText, x, y - 40);
    //date text
    textSize(15);
    text(dateText, x, y - 15);

    cam.endHUD();
  }

  void checkAndExplodeAgain() {
    if (particles.isEmpty() && millis() - lastExplodeTime > explodeInterval) {
      explode();
    }
  }
}
