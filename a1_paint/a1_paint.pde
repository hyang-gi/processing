//initialisation & assignment of variables
int[] colors = {#EB7BC0, #960200, #74A57F, #F7CE5B, #4C5760, #4F345A, #0A369D, #100B00, #F06C9B, #706993, #232020, #C49E85};
int[] colors2 = {#8E6E53, #416165, #E4FDE1, #29339B, #785589, #A5D8FF, #C2D076, #E43F6F, #6665DD, #225560, #A15E49, #D9BBF9};
String[] options = {"brush", "eraser", "upload", "colorPicker", "save", "reset" };
int[] brushSizes = {2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24};
int brushcolor;
String optionType;
PImage img;
PImage defaultBrush;
PImage eraser;
PImage save;
PImage redo;
PImage colorPicker;
PImage upload;
int brushSize;
boolean deleteImg; //flag to remove image when redraw() is called
int saveCount;


void setup() {
  size(690, 360);
  background(240);
  defaultBrush = loadImage("paintbrush.png");
  eraser = loadImage("eraser.png");
  save = loadImage("save.png");
  redo = loadImage("redo.png");
  upload = loadImage("upload.png");
  colorPicker = loadImage("color-picker.png");
  brushSize = 2; //default brush size
  optionType = "brush"; //default option type
  deleteImg = false;
  saveCount = 0;
}
void draw() {
  colorBar();
  brushBar();
  if (img!=null && deleteImg != true) {
    image(img, 180, 60, 280, 280);
  }
  if (optionType == "reset") {
    background(240);
    optionType = "brush";
    deleteImg = true;
    //println("reset deleteImge", deleteImg);
    redraw();
  }
  if (optionType == "save") {
    PImage temp = get(60, 0, 540, 360);
    temp.save("paint"+saveCount+".jpg");
    saveCount++;
    optionType = "brush";
  }
}
void fileSelected(File selection) {
  if (selection != null)
    img = loadImage(selection.getAbsolutePath());
}
void mouseDragged() {
  strokeWeight(brushSize);
  stroke(brushcolor);
  if (optionType != null) {
    switch(optionType) {
    case "brush":
      line(pmouseX, pmouseY, mouseX, mouseY);
      break;
    case "eraser":
      stroke(240);
      line(pmouseX, pmouseY, mouseX, mouseY);
      break;
    default:
      //println("default");
      line(pmouseX, pmouseY, mouseX, mouseY);
      break;
    }
  }
}
void colorBar() {
  strokeWeight(2);
  stroke(0);
  int count = 0;
  for (int i = 0; i< 360; i= i+30) {
    //println(i);
    fill(colors[count]);
    rect(0, i, 30, 30);
    fill(colors2[count]);
    rect(30, i, 30, 30);
    count++;
  }
}

void brushBar() {
  int size = 2;
  fill(220);
  for (int j = 0; j<360; j=j+60) {
    rect(630, j, 60, 60);
  }
  for (int j = 0; j<360; j = j+30) {
    fill(220);
    rect(600, j, 30, 30);
    fill(0);
    ellipse(615, j+15, size, size);
    size += 2;
  }

  defaultBrush.resize(50, 50);
  image(defaultBrush, 635, 5);
  eraser.resize(50, 50);
  image(eraser, 635, 65);
  upload.resize(50, 50);
  image(upload, 635, 125);
  colorPicker.resize(50, 50);
  image(colorPicker, 635, 185);
  save.resize(50, 50);
  redo.resize(50, 50);
  image(save, 635, 245);
  image(redo, 635, 305);
}

void mouseClicked() {
  if (mouseX < 30) {
    int n1 = floor(mouseY / 30);
    //println(n1);
    brushcolor = colors[n1];
  }
  if (mouseX > 30 && mouseX < 60) {
    int n2 = floor(mouseY / 30);
    //println(n2);
    brushcolor = colors2[n2];
  }
  if (mouseX >= 630 && mouseX < 690) {
    int n3 = floor(mouseY/60);
    //println(n3);
    optionType = options[n3];
    if (optionType == "upload")
    {
      deleteImg = false;
      selectInput("Select a file", "fileSelected");
    }
    println(optionType);
  }
  if (mouseX >=600 && mouseX < 630) {
    int n4 = floor(mouseY/30);
    brushSize = brushSizes[n4];
    println("brush size", brushSize);
  }
  if (optionType == "colorPicker") {
    if (mouseX >= 180 && mouseX <=460 && mouseY >= 60 && mouseY <=340) {
      color c1 = get( mouseX, mouseY);
      //println(c1);
      brushcolor = c1;
      optionType = "brush";
    }
  }
}
