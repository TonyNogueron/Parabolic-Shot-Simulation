// Programa de simulación de Tiro parabólico | Parabolic shot simulation
// By: Antonio Noguerón


Objeto proyectil, proyectil1;
float masa = 6; //                            Masa en Kilogramos       | Mass in kilograms
float radio = 0.15; //                         Radio en metros          | radius in metres
PVector gravedad = new PVector(0, 9.81); //   Metros / segundo²        | Gravity in m/s²
float velocidad_inicial = 14; //              Metros / segundo         | metres/seconds
float angulo = 42; //                         Ángulo en grados         | angle in degrees
float c = 0.47; //                             Coeficiente de arrastre  | drag coefficient  0.47 is the coefficient for a sphere
boolean arrastreB = false; //                 Hay fuerza de arrastre?  | Is there drag force or air resistance?

PVector velocidad;
boolean shot = false;
boolean shot1 = false;
boolean calculate = true;
boolean calculate1 = true;


void setup() {
  fullScreen(); //Es el tamaño de nuestra pantalla.

  proyectil1 = new Objeto(masa, radio);
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
  }

  if (calculate1) {
    proyectil1.move();
    proyectil1.edges();
    proyectil1.applyForce(gravedad);

    PVector arrastre = proyectil1.velocity.copy();
    float speed = proyectil1.velocity.magSq();
    arrastre.normalize();
    arrastre.mult(-1);
    float A = (proyectil1.r/50 * proyectil1.r/50 *PI);
    arrastre.mult(c*speed*A*0.626);
    arrastre.div(50);
    proyectil1.applyForce(arrastre);
  }

  if (mousePressed && shot1 == false) {
    proyectil1.applyVelocity(velocidad);
    shot1 = true;
  }
  if (shot1 == true && proyectil1.position.x > 52 && proyectil1.position.y >= height - 103) {
    calculate1 = false;
  }
  if (mousePressed && shot == false) {
    proyectil.applyVelocity(velocidad);
    shot = true;
  }
  if (shot == true && proyectil.position.x > 52 && proyectil.position.y >= height - 103) {
    calculate = false;
  }
  proyectil.display();
  proyectil1.display();
  texto();
}



void texto() {

  fill(255);
  noStroke();
  rect(0, 0, 600, 520);
  rect(1320, 0, 600, 520);
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
  text("Coeficiente de Arrastre: " + 0, 50, 450);
  text("Ángulo: " + nf(degrees(angulo), 0, 2) + "°", 50, 500);
  
  //Proyectil 1
  
  text("X: " + nf((proyectil1.position.x-50)/50, 0, 2) + " m", 1370, 100);
  text("Y: " + nf((proyectil1.position.y-(height-100))*-1/50, 0, 2) + " m", 1370, 150);
  text("Velocidad X: " + nf(proyectil1.velocity.x, 0, 2) + " m/s",1370, 200);
  if (proyectil1.velocity.y < 0.21 && proyectil1.velocity.y > -0.21) {
    text("Velocidad Y: " + 0 + " m/s", 1370, 250);
  } else {
    text("Velocidad Y: " + nf(proyectil1.velocity.y, 0, 2) + " m/s", 1370, 250);
  }
  text("Diámetro: " + radio*2 + " m", 1370, 300);
  text("Masa: " + masa + " Kg", 1370, 350);
  text("Rapidez inicial: " + velocidad_inicial + " m/s",1370, 400);
  text("Coeficiente de Arrastre: " + c, 1370, 450);
  text("Ángulo: " + nf(degrees(angulo), 0, 2) + "°", 1370, 500);  
 
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
