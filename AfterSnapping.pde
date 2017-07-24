Deck deck;

void setup() {
  size(400, 300);
  deck = new Deck(3);
}

void draw() {
  background(255);
  if (!mousePressed)deck.snap();
  deck.display();
}

void mousePressed() {
  println(mouseButton);
  deck.select();
}

void mouseDragged() {
  deck.move();
  deck.check();
}

void mouseReleased() {
  deck.unselect();
}