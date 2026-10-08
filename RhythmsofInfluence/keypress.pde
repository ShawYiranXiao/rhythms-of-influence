void keyPressed() {
  if (key == 'h' || key == 'H') {
    currentGenre = "hip hop";
    println("Genre switched to Hip Hop");
  } else if (key == 'r' || key == 'R') {
    currentGenre = "rock";
    println("Genre switched to Rock");
  } else if (key == 'j' || key == 'J') {
    currentGenre = "jazz";
    println("Genre switched to Jazz");
  } else if (key == 'e' || key == 'E') {
    currentGenre = "electronic";
    println("Genre switched to Electronic");
  } else if (key == 'p' || key == 'P') {
    currentGenre = "pop";
    println("Genre switched to Pop");
  } else if (key == 'c' || key == 'C') {
    currentGenre = "country";
    println("Genre switched to Country");
  } else if (key == 'o' || key == 'O') {
    currentGenre = "folk";
    println("Genre switched to Folk");
  } else if (key == 's' || key == 'S') {
    currentGenre = "soul";
    println("Genre switched to Soul");
  } else if (key == 'b' || key == 'B') {
    currentGenre = "blues";
    println("Genre switched to Blues");
  } else if (key == 'f' || key == 'F') {
    currentGenre = "funk";
    println("Genre switched to Funk");
  } else if (key == 'x' || key == 'X') {
    showData = !showData;
    println("Hover over to view music festival and event date. Press 'x' again to toggle.");
  } else if (key == 'Q' || key == 'q') {
    saveFrame("RythemsInfluence-####.png");
    println("Canvas saved!");
  }
}
