class PKey{
    float xPos;
    float yPos;
    float keyWidth;
    float keyHeight;
    float keyColor;
    float noteColor;
    String note;
    
    void draw(){

        fill(keyColor);
        rect(xPos, yPos, keyWidth, keyHeight);
        fill(noteColor);
        text(note, xPos+(keyWidth/2),yPos + (keyHeight-10));
    }
}
