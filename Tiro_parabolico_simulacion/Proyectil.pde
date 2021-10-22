class Objeto {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float masa; //Kg
  float r; //m

  Objeto(float m, float radio) {
    position = new PVector(50, height-100);
    velocity = new PVector(0,0);
    acceleration = new PVector(0, 0);
    masa = m;
    r = radio*50;
  }

  //Segunda Ley de Newton

  void applyForce(PVector f) {
    PVector force = PVector.div(f, masa);
    acceleration.add(force);
  }
  void applyVelocity(PVector v){
    velocity.add(velocidad);
  }

  void move() {
    //acceleration = F/M
    // If mass == 1, acceleration = Force
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
  }

  void edges() {

    if (position.x > width) {
      position.x = width;
      velocity.x *= -1;
    } else if (position.x < 0) {
      position.x = 0;
      velocity.x *= -1;
    }
    if (position.y > height - 100) {
      position.y = height - 100;
      velocity.y *= -1;
    }
  }

  void display() {
    stroke(0);
    strokeWeight(2);
    fill(127);
    ellipse(position.x, position.y, r*2, r*2);
  }
}
