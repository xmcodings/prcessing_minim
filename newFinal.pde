import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioInput in;
FFT fft;
BeatDetect beat;
AudioOutput out;
Rocks rock;
ArrayList<Rocks> rocksArr = new ArrayList<Rocks>();
Item edible;
Player Champ;


int amplitude;
int c5 = 532;
int d5 = 597;
int e5 = 662;
int f5 = 705;
int g5 = 791;
int a5 = 888;
int b5 = 995;
int c6 = 1049;
int d6 = 1178;
int e6 = 1318;
int f6 = 1405;
int g6 = 1577;
int a6 = 1760;
int b6 = 1975;
int c7 = 2094;
int d7 = 2352;
int e7 = 2643;
int f7 = 2793;
// when buffersize 4096
int notes[];
int realNotes[];
float maxAmpFrequency;
int breakSpd;
int playedSeconds;
int spawnFreq = 20;
int round;
boolean spawnNext;
boolean readyRound;
float specFreq[];
int howMany = 0;
int upPoint = 0;
int missMany;
int greenEat;
int sizeUp;
int speedUp;
int rangeUp;
int powerUp;
int initialValue;
int playTime;




void setup()
{
  size(1000, 1000, P3D);
  minim = new Minim(this);
  in = minim.getLineIn(Minim.MONO, 4096, 44100);
  fft = new FFT(in.bufferSize(), in.sampleRate());
  beat = new BeatDetect();
  out = minim.getLineOut();
  out.setTempo(60);
  Champ = new Player(new PVector(500, 500), new PVector(0, 0));
  out.playNote( "C4" );
  out.playNote("E4" );
  out.playNote("G3" );
  specFreq = new float[3400];
  initialValue = 0;
  // c5 ~  c7 range!!! normal mode
  //but hard mode => a4 ~f7# 
  /*
  int c5 = 527;
   int d5 = 592;
   int e5 = 678;
   int f5 = 699;
   int g5 = 785;
   int a5 = 893;
   int b5 = 1001;
   int c6 = 1065;
   int d6 = 1195;
   int e6 = 1324;
   int f6 = 1410;
   int g6 = 1582;
   int a6 = 1776;
   int b6 = 1991;
   int c7 = 2099;
   int d7 = 2357;
   int e7 = 2637;
   int f7 = 2810;
   // when buffer 2048
   */
  /*
  int c5 = 532;
   int d5 = 597;
   int e5 = 662;
   int f5 = 705;
   int g5 = 791;
   int a5 = 888;
   int b5 = 995;
   int c6 = 1049;
   int d6 = 1178;
   int e6 = 1318;
   int f6 = 1405;
   int g6 = 1577;
   int a6 = 1760;
   int b6 = 1975;
   int c7 = 2094;
   int d7 = 2352;
   int e7 = 2643;
   int f7 = 2793;
   // when buffersize 4096
   */
  notes = new int[18];
  notes[0] = 532;
  notes[1] = 597;
  notes[2]= 662;
  notes[3]= 705;
  notes[4]= 791;
  notes[5]= 888;
  notes[6]= 995;
  notes[7]= 1049;
  notes[8] = 1178;
  notes[9] = 1318;
  notes[10] = 1405;
  notes[11] = 1577;
  notes[12] = 1760;
  notes[13] = 1975;
  notes[14]= 2094;
  notes[15]= 2352;
  notes[16]= 2643;
  notes[17]= 2793;
  //fake notes bc buffersize

  realNotes = new int[18];
  realNotes[0] = 523; 
  realNotes[1] = 587; 
  realNotes[2]= 659; 
  realNotes[3]= 698; 
  realNotes[4]= 783; 
  realNotes[5]= 880; 
  realNotes[6]= 987; 
  realNotes[7]= 1046; // c6
  realNotes[8] = 1174; 
  realNotes[9] = 1318;
  realNotes[10] = 1396;
  realNotes[11] = 1568;
  realNotes[12] = 1760;
  realNotes[13] = 1975;
  realNotes[14]= 2093;
  realNotes[15]= 2349;
  realNotes[16]= 2637;
  realNotes[17]= 2793;
  // real notes in hz
  for (int i = 0; i < 1; i++) // create 2 rocks first
  {
    rock = new Rocks(0, (int)random(20, height-20), 30, 0.5, 1, (int)random(17));
    rocksArr.add(rock);
    rock = new Rocks((int)random(width), 0, 30, 0.5, 2, (int)random(17));
    rocksArr.add(rock);
  }
  breakSpd = 2; // Power!!
}

void draw()
{
  //background(0);
  fill(0, 90);
  rect(0, 0, width, height); // fade effect

  fft.forward(in.right);

  // text("!Whistle Like a Missile!", 500, 500);

  findNote();
  Champ.updateLocation();
  Champ.movePlayer();



  if (initialValue == 0)
  {
    textSize(60);
    fill(255);
    text("!Whistle Like a Missile!", 200, 200);
    textSize(30);
    text("!Press Spacebar to Continue!", 300, 500);
    fill(255, 51, 102);
    if (keyPressed)
    {
      if (key == ' ')
      {
        initialValue = 1; //from 0 -> 1
        playTime = millis(); // save current time
      }
    }
  } else if (initialValue == 1) // gamePlay
  {

    for (int i = 0; i < rocksArr.size(); i++)
    {
      rocksArr.get(i).drawRock();
      println("i = " + i);
    }
    destroyRock();
    nextRound();
    drawLayout();
    buyUpgrade();
  } else if (initialValue == 3) // gameEnd (loose)
  {
    fill(150, 50);
    rect(width / 4, height / 4, width / 2, height / 2); // panel
    textSize(50);
    fill(255);
    text("<Game Over>", width/2 - 160, height / 4 - 30);
    text("<Score>", width/2 - 120, height / 4 +80);
    text(howMany, width/2 - 100, height / 4 +160);
  } else if (initialValue == 4) // gameEnd (win)
  {
    fill(150, 50);
    rect(width / 4, height / 4, width / 2, height / 2); // panel
    textSize(50);
    fill(255);
    text("<You Win>", width/2 - 160, height / 4 - 30);
    text("<Master of Whistle>", width/2 - 240, height / 4 +80);
    text("<Score>", width/2 - 120, height / 4 +150);
    text(howMany, width/2 - 100, height / 4 +200);
  }
}

void findNote()
{
  float maxAmp = 0;
  for (float i = 300; i < 3300; i++) // frequency is the index
  {
    specFreq[(int)i] = fft.getFreq((float)i); // gets the amplitude of frequency!!
  }
  maxAmp = max(specFreq);
  for (int i = 300; i < 3400; i++)
  {
    if (maxAmp == specFreq[i])
    {
      amplitude = (int)maxAmp;
      maxAmpFrequency = i; // 50hz difference... why?
    }
  }
  println("Frequency : " + maxAmpFrequency);
}


void stop()
{
  in.close();
  minim.stop();
  super.stop();
}

void nextRound()
{
  playedSeconds = (millis() - playTime) / 1000;
  println("play time : " + playedSeconds);
  round = playedSeconds / 30 + 1; // every 30 seconds round begin!
  println("round : " + round);
  if (round == 6)
  {
    initialValue = 4;
  }
  if (playedSeconds % 30 == 0 && playedSeconds > 29)
  {
    nextLevel();
  }
}

void destroyRock()
{
  for (int i = 0; i < rocksArr.size(); i++)
  {
    if (rocksArr.get(i).isDestroyed == true)
    {
      rocksArr.remove(i);
      println("removed : " + i);
      spawnNext = true;
      break;
    }
  }
}


void nextLevel()
{
  if (spawnNext)
  {
    for (int i = 0; i < round + 2; i++) // 3 rocks first, and increase by one
    {
      int randNum = (int)random(4);
      if (randNum == 0)
      {
        rocksArr.add(new Rocks((int)random(width), 0, 30, 0.5, 2, (int)random(17)));
      }
      if (randNum == 1)
      {
        rocksArr.add(new Rocks(0, (int)random(height), 30, 0.5, 1, (int)random(17)));
      }
      if (randNum == 2)
      {
        rocksArr.add(new Rocks(width, (int)random(height), 30, -0.5, 1, (int)random(17)));
      }
      if (randNum == 3)
      {
        rocksArr.add(new Rocks((int)random(width), height, 30, -0.5, 2, (int)random(17)));
      }

      edible = new Item((int)random(width), (int)random(height), 40, (int)random(17), randNum);
    }
    rocksArr.add(edible);
    spawnNext = false;
  }
}

void drawLayout()
{
  if (keyPressed)
  {
    if (key == ' ')
    {
      fill(150, 50);
      rect(width / 4, height / 4, width / 2, height / 2); // panel
      textSize(50);
      fill(255);
      text("<STATUS>", width/2 - 120, height / 4 - 30);
      textSize(30);
      text("Round : " + round + "         " + "Missed : " + missMany, width/2 - 200, height / 4 + 100);
      fill(255, 0, 0, 50);
      circle(width/2 - 180, height / 4 + 170, 40);
      fill(255);
      text("    destroyed : " + howMany, width/2 - 160, height / 4 + 180);
      text("Upgrade Point :  " + upPoint, width/2 - 200, height / 4 + 300);
      textSize(20);
      text("1. SPD : " + speedUp + "  " + "2. Size : " + sizeUp + "  "+ "3. RAN : " + rangeUp +"  " + "4. POW : " + powerUp, width/2 - 220, height / 4 + 380);
    }
  }
  fill(255);
  textSize(20);
  text("Life Remaining : " + (50 - missMany) + "  Round Left : " + (6-round), width / 2 - 100, 60);

  if (playedSeconds > 150) // if 110 -> round 4 max  // 150 -> round 5 max
  {
    if (playedSeconds % 30 > 25)
    {  
      fill(225);
      textSize(60);
      text("Final Round in " + (30 -playedSeconds%30), width / 2 - 250, height / 2);
    }
  } else if (playedSeconds % 30 > 25)
  {  
    fill(225);
    textSize(60);
    text("Next Round in " + (30 -playedSeconds%30), width / 2 - 250, height / 2);
  }
}


void buyUpgrade()
{
  if (keyPressed)
  {
    if (upPoint >= 1)
    {
      if (key == '1')
      {
        Champ.spdUpgrade = Champ.spdUpgrade + 0.05;
        speedUp++;
        upPoint = upPoint - 1;
      }
      if (key == '2')
      {
        Champ.wid = Champ.wid + 5; 
        Champ.range = Champ.range + 5;
        sizeUp++;
        upPoint = upPoint - 1;
      }
      if (key == '3')
      {
        Champ.hitRanUpgrade = Champ.hitRanUpgrade + 10;
        Champ.range = Champ.range + 10;
        rangeUp++;
        upPoint = upPoint - 1;
      }
      if (key == '4')
      {
        breakSpd = breakSpd + 1;
        powerUp++;
        upPoint = upPoint - 1;
      }
    }
  }
}
