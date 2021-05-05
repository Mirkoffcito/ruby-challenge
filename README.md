# Challenge de Ruby on rails de ALKEMY. #

API diseñada en ruby on rails, utilizando POSTGRESQL cómo base de datos, y Cloudinary cómo servidor para subir las imágenes.

### Actualmente tengo a la API hosteada en HEROKU! Por lo cual fines de testearse, en POSTMAN puede utilizarse la dirección https://ancient-eyrie-25380.herokuapp.com/ en lugar de " localhost:3000 " y realizarse todos los debidos requests (POST, GET, UPDATE, DELETE). Los endpoints serán entonces iguales. Por ejemplo: 

* ### https://ancient-eyrie-25380.herokuapp.com/api/v1/studios  O  https://ancient-eyrie-25380.herokuapp.com/api/v1/studios/1/movies

## IMPORTANTE: Si lo que se desea es probar la API en su propio entorno, deberá configurar su propia base de datos postgres y cuenta en cloudinary.

## Para esto deberán crear un archivo .env en la carpeta raíz de la API, donde incluiran sus credenciales de Cloudinary y el NOMBRE y USUARIO de postgres con el siguiente formato(el nombre de usuario de postgres por default es " postgres " sin las comillas):

![env formato](https://user-images.githubusercontent.com/81385234/116565085-e8161e80-a8db-11eb-96a8-34bb139e3d9c.jpg)

Una vez guardado esté archivo bastará para realizar un setup " rails db:setup " y " rails db:migrate " y la base de datos estará lista.

Para obtener las credenciales de cloudinary necesarias en el archivo .env, deberán crearse una cuenta en: https://cloudinary.com/users/register/free

y luego de loguearse en su nueva cuenta las credenciales aparecen en la página de inicio de la siguiente manera: 

![cloudinary credentials](https://user-images.githubusercontent.com/81385234/116566108-d84b0a00-a8dc-11eb-8ea3-efa5e1c18092.jpg)

* Estas son las credenciales que deben copiar en el archivo .env, cada una en su correspondiente variable.

* Notese que CLOUD_NAME y CLOUD_API_SECRET no necesitan comillas (' '), mientras que CLOUD_API_KEY si las necesita.

# Resumen de sus funciones:
Ésta api nos permite Crear, actualizar, mostrar y eliminar información respecto a Estudios cinematograficos (Disney, Pixar, MCU, DCU, etc).
Cada estudio tendrá una cantidad de películas, series, y personajes que le pertenecen. Análogamente cada Película, Serie o Personaje pertenecera a un estudio determinado (Relación one-to-many).
Además, cada Película o Serie puede tener uno o más personajes, y cada personaje puede pertenecer a una o más películas y/o series. Para ésto utilicé una relación many-to-many (HABTM).
También tendremos géneros. Cada género podrá tener una o más películas o series, y cáda serie o película podrá tener uno o más géneros.

![UML](https://user-images.githubusercontent.com/81385234/115975202-25c02380-a539-11eb-8097-44a0ab43190d.jpg)


Así, por ejemplo, podemos tener un personaje que pertenezca a un estudio, digamos por ejemplo el MCU, pero que no tenga películas o series aún, por ejemplo Spider-Woman, y luego agregarle películas o series.
De la misma manera, podemos tenér en un principio  una película o serie SIN personajes o géneros, luego crear los personajes, y añadirlos a la película vía PUT. (modificar)

También tenemos un sistema de autenticación vía TOKEN jwt, utilizando la gema KNOCK. Podra crearse un usuario con los campos usuario y contraseña, para ingresar y obtener su token.

## Autenticación
Dicho ésto, lo primero que debemos hacer para utilizar la API, es crearnos una cuenta vía POST request:

* ### localhost:3000/api/v1/auth/signup (parametros username y password)

![POST EXITOSO Auth localhost](https://user-images.githubusercontent.com/81385234/116612484-fd0ba580-a90d-11eb-8410-08521cce9584.jpg)

Una vez creada nuestra cuenta, deberemos proceder a realizar un LOGIN, para obtener nuestro TOKEN.

* ### localhost:3000/api/v1/auth/signin (Debemos establecer en nuestro header el Content-type -> application/json y enviar las credenciales en formato raw cómo se vé en la foto)

![POST EXITOSO login localhost](https://user-images.githubusercontent.com/81385234/116612785-52e04d80-a90e-11eb-9287-150c9d76e57f.jpg)

Listo! ya tenemos nuestro TOKEN de acceso. Copiaremos el código, nos dirigiremos a headers devuelta, y agregaremos el campo ' Authorization -> Bearer <Aquí pegamos el token> cómo se vé en la imágen.

![bearer token](https://user-images.githubusercontent.com/81385234/116613138-b66a7b00-a90e-11eb-841e-5f831c019631.jpg)

Con el token en nuestro header ya tenemos todo configurado para acceder a la totalidad de los endpoints y realizar requests POST, GET, UPDATE y DELETE en nuestra API.

### Filtros y funciones

Supongamos que tenémos 100 películas pertenecientes a un estudio, y queremos obtenerlas en grupos de 10 películas. Tenemos un paginador que nos permite realizar ésto.
Estableceremos un "limit" y un "offset". El "limit" serían la cantidad de elementos que queremos tener en cáda página, y el offset(empieza en offset=0) sería la página que queremos recuperar. Tendremos así, por ejemplo: 

* #### localhost:3000/api/v1/studios?limit=10&offset=0 ####

![GET con limite 2 y offset 1](https://user-images.githubusercontent.com/81385234/115799435-dea62700-a3ae-11eb-9e9e-e5677a87e080.jpg)


Supongamos ahora que queremos buscar una película en especial, y para ver sus detalles necesitamos saber su ID. No recordamos su ID pero si recordamos su nombre. Podemos hacer:

* #### localhost:3000/api/v1/studios/:studio_id/movies?by_name=Aladdin

Esto nos devolvera una lista de peliculas llamadas "Aladdín", por supuesto sólo tenemos una, por lo que obtendremos su ID y buscaremos sus detalles.

![GET Character by_name](https://user-images.githubusercontent.com/81385234/115809327-41ed8480-a3c2-11eb-8109-dbaff042d223.jpg)


Y si queremos ordenar las películas por el orden en que fueron creadas en la base de datos? Podemos ordenarlas de manera ascendente(ASC) o descendente(DESC) de la siguiente manera:    

* #### localhost:3000/api/v1/studios/:studio_id/movies?order=ASC ó  localhost:3000/api/v1/studios/:studio_id/movies?order=DESC

![GET Movie order ASC](https://user-images.githubusercontent.com/81385234/115808863-77de3900-a3c1-11eb-884d-a91fcd8a9bca.jpg)

![GET Movie order DESC](https://user-images.githubusercontent.com/81385234/115808866-7a409300-a3c1-11eb-8a6f-39df9f35a787.jpg)


* ### Bien!

Respecto a los personajes, quizás recordamos el nombre de un personaje y queremos buscarlo:

* #### localhost:3000/api/v1/studios/:studio_id/characters?by_name=Aladdin

![GET Character by_name](https://user-images.githubusercontent.com/81385234/115809020-b70c8a00-a3c1-11eb-87bd-4557e5f65b3d.jpg)


O quizás sólo queremos ver a los personajes que pesen entre 50 y 70 kilos.

* #### localhost:3000/api/v1/studios/:studio_id/characters?by_weight[from]=50&by_weight[to]=70

![GET Character by_weight](https://user-images.githubusercontent.com/81385234/115809116-e7ecbf00-a3c1-11eb-980f-bae847974014.jpg)

También podemos filtrar los personajes por cierto rango de edad, supongamos entre 15 y 17 años.

* #### localhost:3000/api/v1/studios/:studio_id/characters?by_age[from]=15&by_age[to]=17

![GET Character by_age](https://user-images.githubusercontent.com/81385234/115809237-1b2f4e00-a3c2-11eb-872a-8ed23c7ddef6.jpg)

Tenemos entonces una API muy completa, con muchas funcionalidades que podemos activar o desactivar a voluntad.

## Versiones ##

* Ruby -> 2.7.2

* Rails -> 6.1.3.1


## Gemas utilizadas en el desarrollo de la API ##

#### gem ####'has_scope' -> Utilizada para realizar busqueda con filtros (por nombre, por película, por género, etc)

#### gem #### 'image_processing' -> Utilizada para el procesamiento de imágenes

#### gem #### 'shrine' -> Utilizada para la configuración de Cloudinary

#### gem #### 'shrine-cloudinary' -> Utilizada para la configuración de Cloudinary

#### gem #### 'dotenv-rails' -> Utilizada para ocultar credenciales importantes en un .ENV en la carpeta raíz, a fín de evitar su filtración durante el desarrollo

#### gem #### 'rspec-rails' -> Utilizada para realizar tests unitarios durante el desarrollo de la API

#### gem #### 'rack-cors' -> Necesaria para poder utilizar 'knock' y configurar la autenticación vía Token

#### gem #### "bcrypt" -> Necesaria para guardar la contraseña de los usuarios encriptada, a fín de no comprometer la información

#### gem #### "knock" -> Utilizada para generar los Tokens de autenticación



## ENDPOINTS ##

Nuestros enpoints serán:

### ESTUDIOS ###

* #### GET localhost:3000/api/v1/studios -> Nos devuelve un JSON con todos los estudios, su ID, Nombre e imágen.

* #### POST localhost:3000/api/v1/studios -> Nos permite crear un estudio, dandole un nombre y una imágen.

* #### GET localhost:3000/api/v1/studios/:studio_id -> Nos devuelve un JSON con detalles acerca del estudio en cuestion. (Su nombre, imágen, lísta de películas, series y personajes que le pertenecen)

* #### PUT localhost:3000/api/v1/studios/:studio_id -> Nos permite MODIFICAR un estudio, ya sea su nombre o imágen.

* #### DELETE localhost:3000/api/v1/studios/:studio_id -> ELIMINA el estudio en cuestión. (Y todas sus películas, series y personajes.)

### PELÍCULAS ###

* #### GET localhost:3000/api/v1/studios/:studio_id/movies -> Nos devuelve un JSON con todas las películas de un estudio en particular (ID, título e imágen)

* #### POST localhost:3000/api/v1/studios/:studio_id/movies -> Nos permite crear una película perteneciente a un estudio en partícular. (Titulo, fecha de estreno, score, imágen, sus personajes y sus géneros)

* #### GET localhost:3000/api/v1/studios/:studio_id/movies/:movie_id -> Nos devuelve un JSON con detalles acerca de una película en cuestion. (Titulo, fecha de estreno, score, imágen, sus personajes y sus géneros)

* #### PUT localhost:3000/api/v1/studios/:studio_id/movies/:movie_id -> Nos permite MODIFICAR una película o agregarle personajes o géneros.

* #### DELETE localhost:3000/api/v1/studios/:studio_id/movies/:movie_id -> ELIMINA una película en cuestión.

### SERIES ###

* Los endpoints para las series es análogo al de las películas, con la diferencia de qué en lugar de tener "/movies/" Y /:movie_id/ tendremos "/seriees/" y "/:serie_id/". Además se añade un campo en partícular a la hora de crear o modificar, el campo "seasons" para indicar la cantidad de temporadas de la serie.

### PERSONAJES ###

* #### GET localhost:3000/api/v1/studios/:studio_id/characters -> Nos devuelve un JSON con todos los personajes de un estudio en particular (ID, nombre e imágen)

* #### POST localhost:3000/api/v1/studios/:studio_id/characters -> Nos permite crear un personaje perteneciente a un estudio en partícular. (Nombre, edad, peso, historia, imágen y lísta de películas y series en las que aparece)

* #### GET localhost:3000/api/v1/studios/:studio_id/characters/:character_id -> Nos devuelve un JSON con detalles acerca de un personaje en cuestion. (Nombre, edad, peso, historia y lísta de películas y series en las que aparece, y estudio al que pertenece)

* #### PUT localhost:3000/api/v1/studios/:studio_id/characters/:character_id -> Nos permite MODIFICAR un personaje o agregarle películas o series (existentes, establece una relación entre ambos).

* #### DELETE localhost:3000/api/v1/studios/:studio_id/characters/:character_id -> ELIMINA un personaje en cuestión.

### GENEROS ###

* #### GET localhost:3000/api/v1/genres -> Nos devuelve un JSON con todos los generos disponibles(Nombre e ID)

* #### GET localhost:3000/api/v1/genres/:genre_id -> Nos devuelve un JSON con detalles acerca de un género en partícular(nombre, id, y lista de películas y series de dicho género)

* #### DELETE localhost:3000/api/v1/genres/:genre_id -> Nos permite ELIMINAR un género en particular.

* #### POST localhost:3000/api/v1/genres -> Nos permite CREAR un nuevo género. (Nombre)


* ## Adjunto también imagenes de cómo se verían los detalles de un estudio, una película y un personaje.

* ### localhost:3000/api/v1/studios/1

![GET Detalles de estudio](https://user-images.githubusercontent.com/81385234/115895799-31c0be00-a431-11eb-8ed9-cf23a17cb7dc.jpg)

* ### localhost:3000/api/v1/studios/1/movies/1

![GET Detalles de Película](https://user-images.githubusercontent.com/81385234/115895840-3ab18f80-a431-11eb-91ec-9d08fa42237d.jpg)

* ### localhost:3000/api/v1/studios/1/characters/1

![GET Detalles character](https://user-images.githubusercontent.com/81385234/115895873-41d89d80-a431-11eb-924b-e59ddcf62a1e.jpg)

* Por ultimo, podemos también ver(GET) los géneros que existen o crear nuevos géneros (POST) en:

* ### localhost:3000/api/v1/genres

![GET EXITOSO genres localhost](https://user-images.githubusercontent.com/81385234/116564039-ff084100-a8da-11eb-86bd-3352152b6ed7.jpg)

Y para ver las películas y series de un género en especifico.

* ### localhost:3000/api/v1/genres/:genre_id

![GET EXITOSO genres detalle localhost](https://user-images.githubusercontent.com/81385234/116564083-092a3f80-a8db-11eb-8f17-475c51549769.jpg)






