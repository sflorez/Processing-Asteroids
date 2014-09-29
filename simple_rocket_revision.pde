int NROWS = 600;
int NCOLS = 600;

Rocket rocket;
Star[] stars;
ArrayList shots;
Asteroid[] asteroid;
int boost;
boolean gameOver; 
boolean paused =false;
boolean begin = true;
int scorecount;

import ddf.minim.*;

Minim minim;
AudioPlayer song;
AudioPlayer song2;


PImage img;






// --------------------------------------------------------------------------------
// initialize the rocket
// --------------------------------------------------------------------------------
void setup() {
  minim = new Minim(this);
  song = minim.loadFile("laser.wav");


  imageMode(CENTER);
  img = loadImage("rocket.png");

  gameOver = false;
  scorecount = 0;
  boost =0;
  shots= new ArrayList();
  asteroid = new Asteroid[15];
  stars = new Star[200];

  for (int i=0; i<stars.length; i++) {
    stars[i] = new Star();
  }

  for (int i=0; i<asteroid.length; i++) {
    asteroid[i] = new Asteroid();
  }

  size( NROWS, NCOLS );
  stroke(0);
  rocket = new Rocket( NROWS/2, NCOLS/2 );
}

// --------------------------------------------------------------------------------
// move and show the rocket
// --------------------------------------------------------------------------------
void draw() {
  PFont f = createFont("Arial", 48);
  textFont(f);


  if (gameOver) 
  {
    gameOverScreen();
  } 
  else if (paused) 
  {
    pausedScreen();
  }
  else if (begin) 
  {
    beginScreen();
  } 

  else {

    background(0);
    smooth(0);
    fill(100, 255, 255);
    frameRate(12);
    fill(0, 0, 255);
    textSize(30);
    textAlign(LEFT);
    text("Score:"+scorecount, 10, 25);

    shotSetup();
    asteroidSetup();
    starSetup();
    stroke(255);
    rocket.display();




    if (boost>0) {
      rocket.move(1*boost);
      boost--;
    }



    if (keyPressed) {

      if ( keyCode == RIGHT ) {
        //      boost=4;
        rocket.turn( -8);
      }
      else if ( keyCode == LEFT ) {
        //      boost=4;
        rocket.turn( 8 );
      } 
      else if ( keyCode == UP ) {
        rocket.shoot();
        //      boost=5;
        rocket.move(12);
      } 
      else if (keyCode ==DOWN) {
        boost=17;
      } 
      else if (key == ' ') {

        shots.add(rocket.shoot());
        song.play();
        song.rewind();
      }
    }
  }
}

void keyPressed()
{
  if (key=='p') {
    paused=!paused;
  }
  else if (keyCode==ENTER) {
    begin=!begin;
    restart();
  }
}


void mousePressed() {
  if (mouseX<565 && mouseX>475 && mouseY<595 && mouseY>580 && mouseButton==LEFT && gameOver==true) {
    restart();
    begin=!begin;
  }
}

void stop()
{
  song.close();
  minim.stop();

  super.stop();
}


void restart() {
  background(0);
  int NROWS = 600;
  int NCOLS = 600;
  gameOver = false;
  scorecount = 0;
  boost =0;
  shots= new ArrayList();
  asteroid = new Asteroid[15];

  for (int i=0; i<asteroid.length; i++) {
    asteroid[i] = new Asteroid();
  }

  size( NROWS, NCOLS );
  stroke(0);
  rocket = new Rocket( NROWS/2, NCOLS/2 );
}

void shotSetup() {
  for ( int i= shots.size()-1;i> 0; i--) {
    Shot shot = (Shot) shots.get(i);
    stroke(0, 255, 0);
    shot.display();
    shot.move(18);

    for (int j = 0; j < asteroid.length; j++)
    {
      if (shot.isInside(asteroid[j].shape))
      {
        asteroid[j].reset();
        scorecount += 5;
        shots.remove(i);
        break;
      }
    }
  }
}

void asteroidSetup() {
  for (int i=0; i<15; i++) {
    stroke(225, 125, 75);
    asteroid[i].display();
    asteroid[i].move(3);
    if (asteroid[i].isInside(rocket.shape)) {
      gameOver=!gameOver;

      println("gameover");
    } 


    if (i<7) {
      asteroid[i].spin(3);
    } 
    else if (i>7) {
      asteroid[i].spin(-3);
    }
  }
}
void starSetup() {
  for (int i=0; i<stars.length; i++) {
    stroke(random(255));
    stars[i].display();
    //      stars[i].move(20);
  }
}

void gameOverScreen() {
  PFont f = createFont("Arial", 48);
  textFont(f);
  stroke(0, 0, 255);
  fill(125);
  rect(0, height-26, width, 25);
  textFont(f);
  fill(255, 0, 0);
  textAlign(CENTER);
  textSize(30);
  text("Game Over Click Start Over to Restart", width/2, height/2); 
  textAlign(LEFT);
  textSize(15);
  fill(0, 0, 255);
  text("Score:"+scorecount, width, height );
  stroke(0, 0, 255);

  if ( mouseX<565 && mouseX>475 && mouseY<595 && mouseY>580 ) {
    fill(225);
  } 
  else {
    fill(150);
  }
  rect(width-125, height-20, 90, 15);
  fill(0);
  textSize(14);
  text("Start Over", width-115, height-8);
}

void beginScreen() {

  background(0);
  frameRate(12);
  starSetup();
  for (int i=0; i<15; i++) {
    stroke(225, 125, 75);
    asteroid[i].display();
    asteroid[i].move(3);
    if (i<7) {
      asteroid[i].spin(3);
    } 
    else if (i>7) {
      asteroid[i].spin(-3);
    }
  }

  PFont b = createFont("Arial", 48);
  textFont(b);
  textAlign(CENTER);
  textSize(50);
  fill(random(255));
  text("Asteroids", width/2, height/5);
  fill(0, 0, 255);
  textSize(30);
  text("Instructions:", width/2, 175); 
  textSize(20);
  fill(255);
  text("-Press Enter To Start", width/2, 200);
  text("-To Pause Press P", width/2, 225);
  text("-Left and Right Arrows Turn Ship", width/2, 250);
  text("-Up Arrow Moves Ship In Current Direction", width/2, 275);
  text("-Down Arrow Is Boost", width/2, 300);
  text("-Spacebar Shoots", width/2, 325);
  textSize(30);
  fill(255, 0, 0);
  text("Game Over If:", width/2, 375);
  textSize(20);
  fill(255);
  text("-Hit by Asteroid", width/2, 400);
  //    text("-The Tail Of The Snake Is Touched", width/2, 425);
  //    text("-Backwards Movement", width/2, 450);
}

void pausedScreen() {
  textSize(25);
  text("Paused Press P to Unpause", width/2-150, height/2);
}

