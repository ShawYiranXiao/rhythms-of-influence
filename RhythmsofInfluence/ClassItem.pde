class Item {
  int year, month, day;
  HashMap<String, Integer> genreCheckouts = new HashMap<String, Integer>();

  Item(TableRow row) {
    this.year = row.getInt("year");
    this.month = row.getInt("month");
    this.day = row.getInt("day");
    this.genreCheckouts.put("hip hop", row.getInt("hip hop"));
    this.genreCheckouts.put("rock", row.getInt("rock"));
    this.genreCheckouts.put("jazz", row.getInt("jazz"));
    this.genreCheckouts.put("electronic", row.getInt("electronic"));
    this.genreCheckouts.put("pop", row.getInt("pop"));
    this.genreCheckouts.put("country", row.getInt("country"));
    this.genreCheckouts.put("folk", row.getInt("folk"));
    this.genreCheckouts.put("soul", row.getInt("soul"));
    this.genreCheckouts.put("blues", row.getInt("blues"));
    this.genreCheckouts.put("funk", row.getInt("funk"));
  }
}
