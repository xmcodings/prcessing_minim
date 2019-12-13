class Item extends Rocks {

  int item; // 0: spd, 1: size up,  2: radius bigger 3 : breakspeed
  String itemText;

  public Item(int xp, int yp, int widd, int note, int itemnum) {
    super(xp, yp, widd, 0, 0, note);

    item = itemnum;
    red = 51;
    blue = 255;
    green = 102;
    isDestroyed = false;
    if (item == 0 )
    {
      itemText = "Speed++";
    }
    if (item == 1 )
    {
      itemText = "Size++";
    }
    if (item == 2 )
    {
      itemText = "Range++";
    }
    if (item == 3 )
    {
      itemText = "Power++";
    }
  }

  void destroy()
  {
    if (dist(loc.x, loc.y, Champ.loc.x, Champ.loc.y) < Champ.hitrange)
    {
      if (maxAmpFrequency >= notes[noteIndex] - 11 && maxAmpFrequency <= notes[noteIndex] + 11)
        changeRed();
        textSize(40);
        fill(153,51,255);
        text(itemText, Champ.loc.x, Champ.loc.y - Champ.wid);
      if (blue < 0)
      {
        red = 255;
        blue = 255;
        green = 255;
        float drad = 700;
        while (true)
        {
          fill(51, 255, 101, drad);
          circle(loc.x, loc.y, drad);
          drad = drad * 0.98;
          
          text(itemText, Champ.loc.x, Champ.loc.y - Champ.wid);
          if (drad < wid)
          {  
            levelUp();
            break;
          }
        }
        isDestroyed = true;
      }
    }
  }
  void goOverEdge()
  {
  }

  void levelUp()
  {
    if (item == 0)
    {
      Champ.spdUpgrade = Champ.spdUpgrade + 0.1;
      speedUp++;
    }
    if (item == 1)
    {
      Champ.wid = Champ.wid + 12; 
      Champ.range = Champ.range + 12;
      sizeUp++;
    }
    if (item == 2)
    {
      Champ.hitRanUpgrade = Champ.hitRanUpgrade + 15;
      Champ.range = Champ.range + 15;
      rangeUp++;
    }
    if (item == 3)
    {
      breakSpd = breakSpd + 1;
      powerUp++;
    }
  }
}
