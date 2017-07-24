class Card {
  float fixWidth = 30;
  int m_width, m_height;
  int x, y, lastX, lastY;
  int rrSnapTo, rlSnapTo, lrSnapTo, llSnapTo, ttSnapTo, tbSnapTo, btSnapTo, bbSnapTo;
  boolean selected;
  int[] rrToSnapList, rlToSnapList, lrToSnapList, llToSnapList, ttToSnapList, tbToSnapList, btToSnapList, bbToSnapList;
  int[] rrPointList, rlPointList, lrPointList, llPointList, ttPointList, tbPointList, btPointList, bbPointList;
  boolean rrEx, llEx, ttEx, bbEx, rlEx, lrEx, tbEx, btEx;

  Card() {
    m_width = (int)random(40, 150);
    m_height = (int)random(40, 100);
    x = (int)random(m_width, width-m_width);
    y = (int)random(m_height, height-m_height);
    initToSnapList();
  }

  Card(int _x, int _y) {
    m_width = (int)random(40, 100);
    m_height = (int)random(40, 100);
    x = _x;
    y = _y;
    initToSnapList();
  }

  Card(int _x, int _y, int w, int h) {
    m_width = w;
    m_height = h;
    x = _x;
    y = _y;
    initToSnapList();
  }

  void display() {
    noStroke();
    if (isSelected()) {
      fill(80, 255, 80);
    } else {
      fill(0, 100, 255);
    }
    rect(x, y, m_width, m_height);
  }

  void displayLine() {
    stroke(255, 0, 0);
    displaySingleHLine(rrPointList, rrSnapTo, x + m_width);
    displaySingleHLine(rlPointList, rlSnapTo, x + m_width);
    displaySingleHLine(lrPointList, lrSnapTo, x);
    displaySingleHLine(llPointList, llSnapTo, x);

    displaySingleVLine(ttPointList, ttSnapTo, y);
    displaySingleVLine(tbPointList, tbSnapTo, y);
    displaySingleVLine(btPointList, btSnapTo, y + m_height);
    displaySingleVLine(bbPointList, bbSnapTo, y + m_height);
  }

  void displaySingleHLine(int[] pointList, int snapTo, int m_x) {
    if (pointList.length > 2) {
      int ly = 0;
      int lx = snapTo;
      for (int i=0; i<pointList.length; i++) {
        if (pointList[i] == y || pointList[i] == y + m_height) {
          line(lx, ly, m_x, pointList[i]);
          lx = m_x;
          ly = pointList[i];
        } else if (!(pointList[i] > y && pointList[i] < y + m_height)) {
          line(lx, ly, snapTo, pointList[i]);
          lx = snapTo;
          ly = pointList[i];
        }
      }
      line(lx, ly, snapTo, height);
    }
  }

  void displaySingleVLine(int[] pointList, int snapTo, int m_y) {
    if (pointList.length > 2) {
      int ly = snapTo;
      int lx = 0;
      for (int i=0; i<pointList.length; i++) {
        if (pointList[i] == x || pointList[i] == x + m_width) {
          line(lx, ly, pointList[i], m_y);
          lx = pointList[i];
          ly = m_y;
        } else if (!(pointList[i] > x && pointList[i] < x + m_width)) {
          line(lx, ly, pointList[i], snapTo);
          lx = pointList[i];
          ly = snapTo;
        }
      }
      line(lx, ly, width, snapTo);
    }
  }

  boolean hovered() {
    if (mouseX > x && mouseX < x + m_width && mouseY > y && mouseY < y + m_height ) return true;
    else return false;
  }

  void select() {
    selected = true;
    setLastPos();
  }

  void unselect() {
    selected = false;
  }

  boolean isSelected() {
    return selected;
  }

  void setLastPos() {
    lastX = mouseX;
    lastY = mouseY;
  }

  void move() {
    x += mouseX - lastX;
    lastX = mouseX;

    y += mouseY - lastY;        
    lastY = mouseY;
  }

  void initToSnapList() {
    rrToSnapList = new int[0];
    rlToSnapList = new int[0];
    lrToSnapList = new int[0];
    llToSnapList = new int[0];
    ttToSnapList = new int[0];
    tbToSnapList = new int[0];
    btToSnapList = new int[0];
    bbToSnapList = new int[0];

    rrPointList = new int[0];
    rlPointList = new int[0];
    lrPointList = new int[0];
    llPointList = new int[0];
    ttPointList = new int[0];
    tbPointList = new int[0];
    btPointList = new int[0];
    bbPointList = new int[0];
  }

  void sortList() {
    rrToSnapList = sort(rrToSnapList);
    rlToSnapList = sort(rlToSnapList);
    lrToSnapList = sort(lrToSnapList);
    llToSnapList = sort(llToSnapList);
    ttToSnapList = sort(ttToSnapList);
    tbToSnapList = sort(tbToSnapList);
    btToSnapList = sort(btToSnapList);
    bbToSnapList = sort(bbToSnapList);

    rrPointList = sort(rrPointList);
    rlPointList = sort(rlPointList);
    lrPointList = sort(lrPointList);
    llPointList = sort(llPointList);
    ttPointList = sort(ttPointList);
    tbPointList = sort(tbPointList);
    btPointList = sort(btPointList);
    bbPointList = sort(bbPointList);
  }

  void check(ArrayList<Card> cards, int myNum) {
    initToSnapList();
    rrPointList = append(rrPointList, y);
    rrPointList = append(rrPointList, y + m_height);
    rlPointList = append(rlPointList, y);
    rlPointList = append(rlPointList, y + m_height);
    lrPointList = append(lrPointList, y);
    lrPointList = append(lrPointList, y + m_height);
    llPointList = append(llPointList, y);
    llPointList = append(llPointList, y + m_height);
    ttPointList = append(ttPointList, x);
    ttPointList = append(ttPointList, x + m_width);
    tbPointList = append(tbPointList, x);
    tbPointList = append(tbPointList, x + m_width);
    btPointList = append(btPointList, x);
    btPointList = append(btPointList, x + m_width);
    bbPointList = append(bbPointList, x);
    bbPointList = append(bbPointList, x + m_width);

    for (int i=0; i<cards.size(); i++) {
      if (i == myNum) continue;

      Card card = cards.get(i);
      //right & right
      if (!card.rrEx && x + m_width > card.x + card.m_width && x + m_width < card.x + card.m_width + fixWidth) {
        rrToSnapList = append(rrToSnapList, card.x + card.m_width);
        rrPointList = append(rrPointList, card.y);
        rrPointList = append(rrPointList, card.y + card.m_height);
      } else if (x + m_width > card.x + card.m_width + fixWidth) {
        card.rrEx = true;
      } else if (x + m_width < card.x + card.m_width) {
        card.rrEx = false;
      }

      //right & left
      if (!card.rlEx && x + m_width > card.x && x + m_width < card.x + fixWidth) {
        rlToSnapList = append(rlToSnapList, card.x);
        rlPointList = append(rlPointList, card.y);
        rlPointList = append(rlPointList, card.y + card.m_height);
      } else if (x + m_width > card.x + fixWidth) {
        card.rlEx = true;
      } else if (x + m_width < card.x) {
        card.rlEx = false;
      }

      //left & right
      if (!card.lrEx && x < card.x + card.m_width && x > card.x + card.m_width - fixWidth) {
        lrToSnapList = append(lrToSnapList, card.x + card.m_width);
        lrPointList = append(lrPointList, card.y);
        lrPointList = append(lrPointList, card.y + card.m_height);
      } else if (x < card.x + card.m_width - fixWidth) {
        card.lrEx = true;
      } else if (x > card.x + card.m_width) {
        card.lrEx = false;
      }

      //left & left
      if (!card.llEx && x < card.x && x > card.x - fixWidth) {
        llToSnapList = append(llToSnapList, card.x);
        llPointList = append(llPointList, card.y);
        llPointList = append(llPointList, card.y + card.m_height);
      } else if (x < card.x - fixWidth) {
        card.llEx = true;
      } else if (x > card.x) {
        card.llEx = false;
      }

      //top & top
      if (!card.ttEx && y < card.y && y > card.y - fixWidth) {
        ttToSnapList = append(ttToSnapList, card.y);
        ttPointList = append(ttPointList, card.x);
        ttPointList = append(ttPointList, card.x + card.m_width);
      } else if (y < card.y - fixWidth) {
        card.ttEx = true;
      } else if (y > card.y) {
        card.ttEx = false;
      }

      //top & buttom
      if (!card.tbEx && y < card.y + card.m_height && y > card.y + card.m_height - fixWidth) {
        tbToSnapList = append(tbToSnapList, card.y + card.m_height);
        tbPointList = append(tbPointList, card.x);
        tbPointList = append(tbPointList, card.x + card.m_width);
      } else if (y < card.y + card.m_height - fixWidth) {
        card.tbEx = true;
      } else if (y > card.y + card.m_height) {
        card.tbEx = false;
      }

      //buttom & top
      if (!card.btEx && y + m_height > card.y && y + m_height < card.y + fixWidth) {
        btToSnapList = append(btToSnapList, card.y);
        btPointList = append(btPointList, card.x);
        btPointList = append(btPointList, card.x + card.m_width);
      } else if (y + m_height > card.y + fixWidth) {
        card.btEx = true;
      } else if (y + m_height < card.y) {
        card.btEx = false;
      }

      //buttom & buttom
      if (!card.bbEx && y + m_height > card.y + card.m_height && y + m_height < card.y + card.m_height + fixWidth) {
        bbToSnapList = append(bbToSnapList, card.y + card.m_height);
        bbPointList = append(bbPointList, card.x);
        bbPointList = append(bbPointList, card.x + card.m_width);
      } else if (y + m_height > card.y + card.m_height + fixWidth) {
        card.bbEx = true;
      } else if (y + m_height < card.y + card.m_height) {
        card.bbEx = false;
      }
    }

    sortList();
    if (rrToSnapList.length > 0) rrSnapTo = rrToSnapList[rrToSnapList.length - 1];
    if (rlToSnapList.length > 0) rlSnapTo = rlToSnapList[rlToSnapList.length - 1];
    if (lrToSnapList.length > 0) lrSnapTo = lrToSnapList[0];
    if (llToSnapList.length > 0) llSnapTo = llToSnapList[0];
    if (ttToSnapList.length > 0) ttSnapTo = ttToSnapList[0];
    if (tbToSnapList.length > 0) tbSnapTo = tbToSnapList[0];
    if (btToSnapList.length > 0) btSnapTo = btToSnapList[btToSnapList.length - 1];
    if (bbToSnapList.length > 0) bbSnapTo = bbToSnapList[bbToSnapList.length - 1];
  }

  void snap() {
    int dx=0, dy=0;

    if (rrToSnapList.length > 0 && x + m_width > rrSnapTo) {
      dx = -1;
    } else {
      rrPointList = new int[0];
      rrToSnapList = new int[0];
    }

    if (rlToSnapList.length > 0 && x + m_width > rlSnapTo) {
      dx = -1;
    } else {
      rlPointList = new int[0];
      rlToSnapList = new int[0];
    }

    if (lrToSnapList.length > 0 && x < lrSnapTo) {
      if (dx == -1 && x - lastX < 0) {
        dx = -1;
      } else {
        dx = 1;
      }
    } else {
      lrPointList = new int[0];
      lrToSnapList = new int[0];
    }

    if (llToSnapList.length > 0 && x < llSnapTo) {
      if (dx == -1 && x - lastX < 0) {
        dx = -1;
      } else {
        dx = 1;
      }
    } else {
      llPointList = new int[0];
      llToSnapList = new int[0];
    }

    if (ttToSnapList.length > 0 && y < ttSnapTo) dy=1;
    else {
      ttPointList = new int[0];
      ttToSnapList = new int[0];
    }

    if (tbToSnapList.length > 0 && y < tbSnapTo) dy=1;
    else {
      tbPointList = new int[0];
      tbToSnapList = new int[0];
    }

    if (btToSnapList.length > 0 && y + m_height > btSnapTo) {
      if (y == 1 && y - lastY > 0) {
        dy = 1;
      } else {
        dy = -1;
      }
    } else {
      btPointList = new int[0];
      btToSnapList = new int[0];
    }

    if (bbToSnapList.length > 0 && y + m_height > bbSnapTo) {
      if (y == 1 && y - lastY > 0) {
        dy = 1;
      } else {
        dy = -1;
      }
    } else {
      bbPointList = new int[0];
      bbToSnapList = new int[0];
    }

    if (dx == 0) {
      rrPointList = new int[0];
      rlPointList = new int[0];
      lrPointList = new int[0];
      llPointList = new int[0];
    } else {
      x += dx * 2;
    }

    if (dy == 0) {
      ttPointList = new int[0];
      tbPointList = new int[0];
      btPointList = new int[0];
      bbPointList = new int[0];
    } else {
      y += dy * 2;
    }
  }
}