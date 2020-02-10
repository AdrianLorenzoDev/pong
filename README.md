# Pong!🏓
Pong like game using [Processing](https://processing.org).

> **Adrián Lorenzo Melián** - *Creando Interfaces de Usuario*, [**ULPGC**](https://www.ulpgc.es).
> adrian.lorenzo101@alu.ulpgc.es

<div align="center">
 <img src=images/demo.gif alt="Game demo" />
 Figura 1 - Demostración de la ejecución del juego
</div>

***

## Índice
* [Introducción](#introduction)
* [Instrucciones](#instructions) 
* [Implementación](#implementation)
    * [Arquitectura](#architecture)
    * [Cálculo del deplazamiento aleatorio inicial](#random-initial-position)
    * [Colisión bola - pala](#ball-paddle-collision)
* [Referencias](#references)

## Introducción <a id="introduction"></a>
El objetivo de esta práctica es **la creación de un juego similar a *Pong*** [1] destinado a 2 jugadores, para familiarizarse con *Processing* [2]. El juego debe cumplir con las siguientes requisitos:

- Debe **existir un marcador** para que los jugadores puedan tener control de la puntuación.
- **La pelota debe poder rebotar** en los lados del área de juego.
- Se deben **incluir efectos de sonido** que mejoren la experiencia del usuario. 
- **El movimiento inicial de la pelota deberá ser aleatorio.**

## Instrucciones del juego <a id="instructions"></a>

El juego solo necesita de un teclado para funcionar. Al comenzar el juego, se mostrarán instrucciones acerca de los controles. 

El jugador de la izquierda podrá usar la tecla `W` para mover la pala hacia arriba y la tecla `S` para mover la pala hacia abajo. El jugador de la derecha podrá mover su pala hacia arriba con la tecla `FLECHA ARRIBA`/`ARROW UP` y mover su pala hacia abajo con la tecla `FLECHA ABAJO`/`ARROW DOWN`. ¡Para empezar a jugar desde el tutorial, pulsa `ENTER`!

El objetivo del juego es **intentar que la bola traspase el área de tu rival**. El que alcance primero la máxima puntuación gana (¡Escoge tú mismo la máxima puntuación y juega sin límites!).

## Implementación <a id="implementation"></a>

### Arquitectura <a id="architecture"></a>

Para poder trabajar bajo el paradigma de la **programación orientada a objetos**, fue necesario analizar el comportamiento de cada uno de los componentes que vamos utilizar. 

Era claro que **todos los elementos que aparecen en la pantalla compartían el mismo comportamiento**: todos eran **dibujables** en la pantalla. Por tanto, era necesario abstraer ese comportamiento en una interfaz, la cuál finalmente fue denominada `Drawable`.

```java
public interface Drawable {
    public void draw();
}
```

A partir de esta interfaz, se determinó que **existía un subconjunto de componentes que tenían algo en común**: aquellos que se sitúan dentro de un canvas, y por tanto, **poseen una posición** en el mismo. Por tanto, se generó la clase abstracta `Component`, que implementaba la interfaz `Drawable`:

```java
public abstract class Component implements Drawable {
  private float x;
  private float y;

  public float getX(){
  	return x;
  }

  public float getY() {
  	return y;
  }

  public void setX(float x){
  	this.x = x;
  }

  public void setY(float y) {
  	this.y = y;
  }
}
```

Todos las clases de los elementos que aparecen en la pantalla **implementan la interfaz `Drawable`** (de forma directa o a partir de extender la clase `Component`). Las clases de estos componentes son:

- `Paddle`. Clase que representa a la pala que controla el jugador.
- `Ball`. Clase que representa a la pelota.
- `Tutorial`. Clase que representa el tutorial de inicio, que explica como jugar al juego y como empezar.
- `Game`. Clase que representa al juego. Es el lienzo en el cuál se instancian en el resto de componentes del juego, siguiendo un patrón Composite.

Para el control del juego, se ha implementado la clase `GameController`. Esta **se encarga de controlar el bucle que compone el juego y de encuestar a los registros** que contienen información a cerca de **las teclas que han sido pulsadas.**

### Cálculo del deplazamiento aleatorio inicial <a id="random-initial-position"></a>

Para calcular el desplazamiento aleatorio inicial, **se hace uso de una estrategia de "lanzamiento de moneda"**: El programa obtendrá un número al azar entre el `0` y el `1`, y un número al azar entre `0` y `PI / 3` radianes, para cada componente.

Si **el valor entre cero y uno supera un umbral** (`0.5`), este número será multiplicado por uno, y por tanto, **la bola irá hacia arriba (componente `Y`) o hacia la derecha (componente `X`)**. Si no, **se multiplicará por -1, y por tanto, la bola irá hacia abajo (componente `Y`) o hacia la izquierda (componente `X`)**.

### Colisión bola - pala <a id="ball-paddle-collision"></a>

Para obtener el nuevo vector director y velocidad de la bola al colisionar con una pala, **se ha realizado el cálculo en base al lugar en la pala donde colisiona la bola. Cuanto más lejos, mayor será el valor absoluto del ángulo de la nueva trayectoria**. 

Además, cada vez que colisiona en una de las palas, la velocidad de la bola incrementará en función de una constante.

El cálculo se realiza de la siguiente forma:

```java
// Se calcula la posición de colisión relativa al centro
// Positivo -> Por encima del centro
// Negativo -> Por debajo del centro
float offset = (ball.getY() + ball.getRadius()*2 - playerTwo.getY()) / playerTwo.getHeight();

// Se traslada el valor a un nuevo intervalo [45º, -45º]
float rad =  PI / 4 * offset - PI / 4;

// Se calcular las nuevas componentes del vector director
// a partir del seno y el coseno del ángulo
// Coseno negativo -> Lado opuesto
setDeltaY(sin(rad));
setDeltaX(-cos(rad));

// Incremento de la velocidad cada vez que colisiona hasta un máximo.
if (ballSpeed < ballSpeedMax) {
  ballSpeed += ballSpeedInc;
}
```

## Referencias <a id="references"></a>
- [1] [Pong](https://es.wikipedia.org/wiki/Pong)
- [2] [Processing](https://processing.org)



