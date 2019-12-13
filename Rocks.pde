class Rocks {

  int x, y;
  PVector loc = new PVector(0, 0);
  int wid;
  int speed;
  int direction; // 1 : x, 2: y
  int playNote;
  PVector spd = new PVector(0, 0);
  int played;
  String noteInfo;
  int red, blue, green;
  int noteIndex;
  boolean isDestroyed;

  public Rocks(int xp, int yp, int widd, float initialspd, int dir, int note)
  {
    loc.x = xp;
    loc.y = yp;
    wid = widd;
    spd.x = initialspd;
    spd.y = initialspd;
    direction = dir;
    noteIndex = note;
    playNote = realNotes[note];
    if (note == 0) {
      noteInfo = "C5";
    }
    if (note == 1) {
      noteInfo = "D5";
    }
    if (note == 2) {
      noteInfo = "E5";
    }
    if (note == 3) {
      noteInfo = "F5";
    }
    if (note == 4) {
      noteInfo = "G5";
    }
    if (note == 5) {
      noteInfo = "A5";
    }
    if (note == 6) {
      noteInfo = "B5";
    }
    if (note == 7) {
      noteInfo = "C6";
    }
    if (note == 8) {
      noteInfo = "D6";
    }
    if (note == 9) {
      noteInfo = "E6";
    }
    if (note == 10) {
      noteInfo = "F6";
    }
    if (note == 11) {
      noteInfo = "G6";
    }
    if (note == 12) {
      noteInfo = "A6";
    }
    if (note == 13) {
      noteInfo = "B6";
    }
    if (note == 14) {
      noteInfo = "C7";
    }
    if (note == 15) {
      noteInfo = "D7";
    }
    if (note == 16) {
      noteInfo = "E7";
    }
    if (note == 17) {
      noteInfo = "F7";
    }
    red = 150;
    blue = 150;
    green = 150;
    isDestroyed = false;
  }

  void drawRock()
  {
    fill(red, blue, green);
    circle(loc.x, loc.y, wid);
    fill(200, 0, 0);
    textSize(16);
    text(noteInfo, loc.x - 10, loc.y + 10);
    moveRock();
    collide();
    makeTone();
    destroy();
    goOverEdge();
    if (isDestroyed)
    {
    }
  }
  void moveRock()
  {
    if (direction == 1) // x
    {
      loc.x = loc.x + spd.x * (round+3)/3;   // if spd is -, mov left
    } else {  // y
      loc.y = loc.y + spd.y * (round+3)/3;
    }
  }
  void collide()
  {
    if ( dist(loc.x, loc.y, Champ.loc.x, Champ.loc.y) < Champ.wid) // player hit
    {
      // game over
      noFill();
      stroke(255, 51, 102);
      circle(loc.x, loc.y, 80);
      delay(1000);
      initialValue = 3;
    }

    if (abs(x - width/2) < 30) // player width = 60;b 
    {
      // game over
    }
    if (abs(y - height/2) < 30)
    {
      // game over
    }
  }

  void goOverEdge()
  {
    if (loc.x >= width || loc.x <=  0 || loc.y >= height || loc.y <= 0)
    { // go over edge
      spawnNext = true;
      missMany = missMany + 1;
      if (missMany > 50)
      {
        noFill();
        stroke(255, 51, 102);
        circle(loc.x, loc.y, 80);
        delay(1000);
        initialValue = 3;
      }
      isDestroyed = true;
    }
  }

  void makeTone()
  {
    if (played == 0)
    {
      if ( dist(loc.x, loc.y, Champ.loc.x, Champ.loc.y) < Champ.range-10) // bigger circle in player
      {
        out.playNote(playNote);
        println("played : " + playNote);
        played++;
      }
    } else {
      played = 0;
    }
  }

  void destroy()
  {
    if (dist(loc.x, loc.y, Champ.loc.x, Champ.loc.y) < Champ.hitrange)
    {
      if (maxAmpFrequency >= notes[noteIndex] - 11 && maxAmpFrequency <= notes[noteIndex] + 11)
        changeRed();
      if (blue < 0)
      {
        red = 255;
        blue = 255;
        green = 255;
        float drad = 1;
        while (true)
        {
          fill(255, 153, 51, drad);
          circle(loc.x, loc.y, drad);
          drad = drad * 1.1;
          if (drad > wid + 100)
          {
            howMany = howMany + 1;
            upPoint = upPoint + 1;
            break;
          }
        }
        isDestroyed = true;
      }
    }
  }

  void changeRed()
  {
    red = red+breakSpd;
    if (red >255)
    {
      blue = blue - breakSpd;
      green = green - breakSpd;
    }
  }
}
