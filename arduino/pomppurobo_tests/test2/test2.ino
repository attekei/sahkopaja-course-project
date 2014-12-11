// Anturipinnit
int xPin = 0;
int yPin = 1;
int zPin = 2;

// Keskiarvoistettavien pisteiden määrä
int nave = 10;

// Kiihtyvyysanturin akselien arvot (0-1023)
int xval, yval, zval;

// Kiihtyvyysanturin askelien arvoja vastaavat kulmat asteina
float xang, yang, zang;

// Kulmia -90 ja 90 astetta vastaavat arvot
int xmin = 324; // Muuta kalibrointivaiheessa
int xmax = 350; // Muuta kalibrointivaiheessa



// Setup-osio ajetaan ohjelman alussa
void setup() {
  
  // Avaa sarjaporttiyhteyden tietokoneen ja Arduinon välille
  Serial.begin(9600);
}



// Loop-osio ajetaan toistuvasti
void loop() {
  
  // Lue eri akselien arvot (0-1023)
  // xval = analogRead(xPin);
  // yval = analogRead(yPin);
  // zval = analogRead(zPin);
  
  // Ota keskiarvoistus käyttöön kommentoimalla edelliset
  // kolme koodiriviä, ja poistamalla kommenttimerkit /* ja */
  // alla olevan koodinpätkän ympäriltä
  
  // Nollaa arvot ennen keskiarvoistusta  
  xval = 0; yval = 0; zval = 0;
  // for-loopin sisällä oleva koodi ajetaan nave kertaa
  for (int i = 0; i < nave; i++) {
    // Lue eri akselien arvot (0-1023). Lisää summaan.
    xval += analogRead(xPin); // xval = xval + analogRead(xPin) 
    yval += analogRead(yPin);
    zval += analogRead(zPin);
    delay(5);
  }
  // Jaa summa termien määrällä,
  xval = xval/nave;
  yval = yval/nave;
  zval = zval/nave;
 
  // Tulosta raakadata sarjaporttiin
  Serial.print("Arvot: ");
  Serial.print(xval);
  Serial.print(",");
  Serial.print(yval);
  Serial.print(",");
  Serial.println(zval);
  
  // Suoritettuasi kiihtyvyysanturin kalibroinnin, 
  // poista kommenttimerkit /* ja */ koodin ympäriltä ja
  // lataa ohjelmakoodi uudelleen mikrokontrollerille.
  
  
  // Raakadata kulmiksi lineaarimuunnoksen avulla
  // Esim: xmin > -90, xmax > 90, (xmax+xmin)/2 > 0
  xang = map(xval, xmin, xmax, -90, 90);
  yang = map(yval, xmin, xmax, -90, 90);
  zang = map(zval, xmin, xmax, -90, 90);
  
  // Tulosta kulmat sarjaporttiin
  Serial.print("Kulmat: ");
  Serial.print(xang);
  Serial.print(",");
  Serial.print(yang);
  Serial.print(",");
  Serial.println(zang);
  
  
  
  // Odota 500 ms ennen uutta kierrosta
  delay(500);
}


