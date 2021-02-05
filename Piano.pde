import processing.sound.*;
SoundFile note; //Library used to play piano notes.

PKey[] whiteKeys;
PKey[] blackKeys; //Arrays used to store key objects.

String[] whiteNotes;
String[] blackNotes; //Arrays used to store wav files of notes.

boolean blackKey = false; //Used to determine if a flat or sharp key is being played.
boolean keyOverride = false;  //used to determine between keypress and mouseclick.

int notePressed; //Used by the switch statement to know which note to colour in the draw method.

void setup() {

  String[] whiteNotes = loadStrings("flat/flats.txt");
  String[] blackNotes = loadStrings("sharp/sharps.txt"); //populates arrays with wav files.

  size(601, 221);
  textAlign(CENTER, CENTER);

  whiteKeys = new PKey[10];
  blackKeys = new PKey[7]; //creating arrays for the amount of keys on the piano. increasing this would make a longer keyboard.

  for (int i=0; i<whiteKeys.length; i = i+1) //These for loops are for setting up the key objects. the colour and postistion of the keys are set here.
  {
    whiteKeys[i] = new PKey();
    whiteKeys[i].xPos = 0+i*60;
    whiteKeys[i].yPos = 0;
    whiteKeys[i].keyColor = 255;
    whiteKeys[i].noteColor = 0;
    whiteKeys[i].keyWidth = 60;
    whiteKeys[i].keyHeight = 220;
    whiteKeys[i].note = whiteNotes[i];
  }

  float blackKeysGap = 40;

  for (int i=0; i<blackKeys.length; i = i+1)
  {
    blackKeys[i] = new PKey();

    if (i == 2 || i == 5) {
      blackKeysGap = blackKeysGap + 60;
    }

    blackKeys[i].xPos = blackKeysGap;
    blackKeysGap = blackKeysGap + 60;
    blackKeys[i].yPos = 0;
    blackKeys[i].keyColor = 0;
    blackKeys[i].noteColor = 255;
    blackKeys[i].keyWidth = 40;
    blackKeys[i].keyHeight = 110;
    blackKeys[i].note = blackNotes[i];
  }
}

void draw() {
  for (int i=0; i<whiteKeys.length; i = i+1) {
    if (isInside(whiteKeys[i].xPos, whiteKeys[i].yPos, whiteKeys[i].keyWidth, whiteKeys[i].keyHeight) && mousePressed == true && !blackKey) {
      whiteKeys[i].keyColor=200;
      println(i);
    } else if (keyPressed && notePressed >=0 && notePressed <=9 && !blackKey){
      whiteKeys[notePressed].keyColor=200;
    } else {
      whiteKeys[i].keyColor=255;
    }
    whiteKeys[i].draw();
  }

  for (int i=0; i<blackKeys.length; i = i+1) {
    if (isInside(blackKeys[i].xPos, blackKeys[i].yPos, blackKeys[i].keyWidth, blackKeys[i].keyHeight) && mousePressed == true) {
      blackKeys[i].keyColor =200;
    } else if (keyPressed && notePressed >=0 && notePressed <=6 && blackKey){
      blackKeys[notePressed].keyColor=200;
    } else {
      blackKeys[i].keyColor =0;
    }
    blackKeys[i].draw();
  }
  
  
}

boolean isInside(float x, float y, float keyWidth, float keyHeight) {  //used to determine if the mouse is inside a key.
  if (mouseX > x && mouseX < (x+keyWidth) && mouseY > y && mouseY < (y + keyHeight)) {
    return(true);
  } else {
    return(false);
  }
}

void playNote(String keyNote) {

  blackKey = false; //this variable is used a lot in the project. it is used as a flag so that code only runs if a sharp key is being played.

  
  for (int i=0; i<blackKeys.length; i = i+1) {
    if (isInside(blackKeys[i].xPos, blackKeys[i].yPos, blackKeys[i].keyWidth, blackKeys[i].keyHeight)) {
      note = new SoundFile(this, "sharp/0" + i + ".wav");
      note.play();
      blackKey = true;
      keyOverride = false;
    } else if (keyOverride && !mousePressed) {
      println("playing sharp");
      blackKeys[i].keyColor=200;
      note = new SoundFile(this, "sharp/0" + keyNote + ".wav");
      note.play();
      blackKey = true;
      keyOverride = false;
      break;
    }
  }

  if (!blackKey) {
    for (int i=0; i<whiteKeys.length; i = i+1) {
      if (isInside(whiteKeys[i].xPos, whiteKeys[i].yPos, whiteKeys[i].keyWidth, whiteKeys[i].keyHeight)) {
        note = new SoundFile(this, "flat/0" + i + ".wav");
        note.play();
        keyOverride = false;
      } else if (keyOverride && !mousePressed) {
        println("playing flat");
        note = new SoundFile(this, "flat/0" + keyNote + ".wav");
        note.play();
        keyOverride = false;
        break;
      }
    }
  }
}

void mousePressed() {
  playNote(null);
}

//this is needed so that the mouse cursor doesnt play multiple notes.
void mouseReset() {
  mouseX = 0;
  mouseY = 0;
}

//this is used with the switch statement below to determine which note to press on the keyboard. it also plays the note according to the key pressed.
void caseNote(String n, int nP, boolean noteP) {
  note = new SoundFile(this, n +  ".wav");
  note.play();
  mouseReset();
  keyOverride = true;
  notePressed = nP;
  blackKey = noteP;
}

//this switch statement contains all the keys pressed for the piano
void keyPressed() {
  
  char letter = key;

  switch(letter) {
  case 'A': 
  case 'a':
    caseNote("flat/00",0,false);

    break;
  case 'S': 
  case 's':
    caseNote("flat/01",1,false);
    break;
  case 'D': 
  case 'd':
    caseNote("flat/02",2,false);
    break;
  case 'F': 
  case 'f':
    caseNote("flat/03",3,false);
    break;
  case 'G': 
  case 'g':
    caseNote("flat/04",4,false);
    break;
  case 'H': 
  case 'h':
    caseNote("flat/05",5,false);
    break;
  case 'J': 
  case 'j':
    caseNote("flat/06",6,false);
    break;
  case 'K': 
  case 'k':
    caseNote("flat/07",7,false);
    break;
  case 'L': 
  case 'l':
    caseNote("flat/08",8,false);
    break;
  case ';': 
    caseNote("flat/09",9,false);
    break;
  case 'W': 
  case 'w':
    caseNote("sharp/00",0,true);
    break;
  case 'E': 
  case 'e':
    caseNote("sharp/01",1,true);
    break;
  case 'T': 
  case 't':
    caseNote("sharp/02",2,true);
    break;
  case 'Y': 
  case 'y':
    caseNote("sharp/03",3,true);  
    break;
  case 'U': 
  case 'u':
    caseNote("sharp/04",4,true); 
    break;
  case 'O': 
  case 'o':
    caseNote("sharp/05",5,true); 
    break;
  case 'P': 
  case 'p':
    caseNote("sharp/06",6,true);
    break;
  default:             // Default executes if the case labels
    notePressed = 99;   // don't match the switch parameter
    break;
  }
}
