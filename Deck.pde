class Deck {
  ArrayList<Card> m_cards;
  int num;

  Deck(int n) {
    m_cards = new ArrayList<Card>();
    num = n;
    for (int i=0; i<num; i++) {
      Card card = new Card();
      m_cards.add(card);
    }
  }

  void init() {
    for (int i=0; i<num; i++) {
      Card card = m_cards.get(i);
      card.initToSnapList();
    }
  }

  void select() {
    for (int i=0; i<num; i++) {
      Card card = m_cards.get(i);
      if (card.hovered()) {
        card.select();
        break;
      }
    }
  }

  void unselect() {
    for (int i=0; i<num; i++) {
      Card card = m_cards.get(i);
      if (card.isSelected()) {
        card.unselect();
      }
    }
  }

  void move() {
    for (int i=0; i<num; i++) {
      Card card = m_cards.get(i);
      if (card.isSelected()) {
        card.move();
      }
    }
  }

  void check() {
    if (selectedNum() == -1) return;
    Card card = m_cards.get(selectedNum());
    card.check(m_cards, selectedNum());
  }

  void snap() {
    for (int i=0; i<num; i++) {
      Card card = m_cards.get(i);
      card.snap();
    }
  }

  void display() {
    for (int i=num-1; i>=0; i--) {
      Card card = m_cards.get(i);
      card.display();
      card.displayLine();
    }
  }

  int selectedNum() {
    for (int i=0; i<num; i++) {
      Card card = m_cards.get(i);
      if (card.isSelected()) {
        return i;
      }
    }
    return -1;
  }
}