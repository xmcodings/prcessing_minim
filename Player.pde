class Player {

  PVector loc;
  PVector spd;
  int wid;
  int range;
  int hitrange;
  int hitRanUpgrade;
  float spdUpgrade;

  Player (PVector location, PVector speed) {
    loc = location;
    spd = speed;
    wid = 30;
    range = 80;
    spdUpgrade = 0.08;
    hitRanUpgrade = wid;
  }

  void updateLocation() {
    loc.y =loc.y + spd.y;
    loc.x =loc.x + spd.x;
    spd.x = spd.x * 0.97;
    spd.y = spd.y * 0.97;
    if(loc.x < 0 || loc.x > width || loc.y < 0 || loc.y > height)
    {
       spd.x = 0;
       spd.y = 0;
    }
    fill(160, 244, 160);
    circle(loc.x, loc.y, hitrange);
    noFill();
    stroke(255);
    circle(loc.x, loc.y, range);
    fill(240, 250, 6);
    circle(loc.x, loc.y, wid);
    
    hitRange();
  }
  void movePlayer()
  {
    if (keyPressed)
    {
      if (key == 'w')
      {
        Champ.moveU();
      }
      if (key == 'a')
      {
        Champ.moveL();
      }
      if (key == 's')
      {
        Champ.moveD();
      }
      if (key == 'd')
      {
        Champ.moveR();
      }
    }
  }
  void moveL()
  {
    spd.x = spd.x - spdUpgrade;
  }
  void moveR()
  {
    spd.x = spd.x + spdUpgrade;
  }

  void moveU()
  {
    spd.y = spd.y - spdUpgrade;
  }
  void moveD()
  {
    spd.y = spd.y + spdUpgrade;
  }

  void hitRange()
  {
    hitrange = hitRanUpgrade + amplitude / 4;
  }
}
