// Programa de simulación de Tiro parabólico / Parabolic shot simulation
// By: Antonio Noguerón


Objeto proyectil;
float masa = 1; //Masa en Kilogramos / Mass in kilograms
float radio = 0.15; //Radio en metros / radius in metres
PVector gravedad = new PVector(0, 9.81); //Metros / segundo² /Gravity in m/s²
float velocidad_inicial = 13; //Metros / segundo / metres/seconds
float angulo = 69; //Ángulo en grados /angle in degrees
boolean arrastreB = true; //Hay fuerza de arrastre? /Is there drag force or air resistance?

PVector velocidad;
boolean shot = false;
boolean calculate = true;





void setup() {
  fullScreen(); //Es el tamaño de nuestra pantalla.
  proyectil = new Objeto(masa, radio);
  gravedad.mult(proyectil.masa);
  gravedad.div(50);
  angulo = radians(angulo);
  velocidad = new PVector(velocidad_inicial*cos(angulo), -velocidad_inicial*sin(angulo));
  //velocidad.div(50);
  fondo();
}

void draw() {
  //fondo();
  if (calculate) {
    proyectil.move();
    proyectil.edges();
    proyectil.applyForce(gravedad);
    PVector arrastre = proyectil.velocity.copy();
    float speed = proyectil.velocity.magSq();
    arrastre.normalize();
    arrastre.mult(-1);
    float c = 0.47;
    float A = (proyectil.r/50 * proyectil.r/50 * PI);
    arrastre.mult(c*speed*A*0.626);
    arrastre.div(50);
    if (arrastreB) {
      proyectil.applyForce(arrastre);
    }
  }

  if (mousePressed && shot == false) {
    proyectil.applyVelocity(velocidad);
    shot = true;
  }
  if(shot == true && proyectil.position.x > 52 && proyectil.position.y > height-106){
    calculate = false;
  }
  proyectil.display();
  texto();
}


void texto() {
  
  fill(255);
  noStroke();
  rect(0,0,600,600);
  textSize(40);
  fill(0);
  text("X: " + nf((proyectil.position.x-50)/50, 0, 2) + " m", 50, 100);
  text("Y: " + nf((proyectil.position.y-(height-100))*-1/50, 0, 2) + " m", 50, 150);
  text("Velocidad X: " + nf(proyectil.velocity.x, 0, 2) + " m/s", 50, 200);
  if (proyectil.velocity.y < 0.21 && proyectil.velocity.y > -0.21) {
    text("Velocidad Y: " + 0 + " m/s", 50, 250);
  } else {
    text("Velocidad Y: " + nf(proyectil.velocity.y, 0, 2) + " m/s", 50, 250);
  }
  text("Diámetro: " + radio*2 + " m", 50, 300);
  text("Masa: " + masa + " Kg", 50, 350);
  text("Rapidez inicial: " + velocidad_inicial + " m/s", 50, 400);
  text("Ángulo: " + nf(degrees(angulo),0,2) + "°", 50, 450);
}


void fondo() {
  background(255);
  fill(120);
  stroke(50);

  float escala = 50;
  float x = escala;
  int metros = 0;
  while (x < width-escala*2) {
    fill(120);
    rect(x, height-escala*2, escala, escala);
    fill(255);
    textSize(25);
    text(metros, x+escala/3, height-escala*2+escala/2);
    x = x + escala;
    metros ++;
  }
}
