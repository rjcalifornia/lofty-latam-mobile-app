# Lofty - Simplificando pagos

### Prerequisitos Ambiente de desarrollo
 
- Android Studio 4.1  
- Android SDK version 30.0.3  
- Dart SDK version: 2.17.6 (stable)  
- Flutter Channel stable, 3.0.5  
- Visual Studio Code  

## Instalacion

1. Con la consola de comandos (CLI), ejecutar el comando:  
   ```bash
   flutter doctor
   ```  
   para verificar que cumple con todos los prerequisitos de Flutter.  

2. Clonar este repositorio.  

3. Copiar archivo `env.dart.example` como `env.dart` y configurar los endpoints correctamente.  

4. Con la consola de comandos (CLI), ir a la carpeta root de la app y ejecutar el comando:  
   ```bash
   flutter pub get
   ```  
   Esto instalará las librerías necesarias para el funcionamiento de la app.  

5. Una vez se haya terminado de instalar las librerías, ya podrá ejecutar la App con Visual Studio Code o Android Studio.  

## Generar APK

Con la consola de comandos (CLI), ejecutar:  

```bash
flutter build apk --release
```  

Esto generará un APK de pruebas en dispositivos Android.  

## Estructura de Carpetas

```plaintext
lib/
│
├── core/                       
│   ├── config/        # Configuración de temas, rutas, ambiente
│   ├── validators/    # Validaciones de campos de un formulario
│   ├── utils/         # Funciones helpers, extensiones
│   └── widgets/       # Widgets reutilizables en toda la app
│
├── modules/                   
│   ├── authentication/         # Módulo de autenticación
│   │   ├── models/
│   │   ├── screens/
│   │   └── widgets/
│   │
│   ├── home/                   # Módulo Home / Dashboard
│   │   ├── models/
│   │   ├── screens/
│   │   └── widgets/
│   │
│   ├── lease/                  # Módulo de contratos/arrendamientos
│   │   ├── models/
│   │   ├── screens/
│   │   └── widgets/
│   │
│   ├── profile/                # Módulo de perfil de usuario
│   │   ├── models/
│   │   ├── screens/
│   │   └── widgets/
│   │
│   └── property/               # Módulo de propiedades
│       ├── models/
│       ├── screens/
│       └── widgets/
│
├── app.dart          # Widget raíz (MaterialApp, rutas, providers)
├── global.dart       # Configuración global, variables y singletons
└── main.dart         # Punto de entrada
```

## Graficos

- Imágenes royalty free descargadas con cuenta premium de [Pixabay](https://pixabay.com/)  
- Imagen de portada inicial por [Pexels](https://pixabay.com/users/pexels-2286921/)  

## Informacion Adicional

![Flutter](https://raw.githubusercontent.com/flutter/website/archived-master/src/_assets/image/flutter-lockup-bg.jpg "Flutter")

![alt text](https://raw.githubusercontent.com/flutter/website/archived-master/src/_assets/image/flutter-lockup-bg.jpg "Flutter")

<b>Version 3.7.11</b> 

#### Attribution-NonCommmercial-ShareAlike 4.0 International License
[![License: CC BY-NC-SA 4.0](https://licensebuttons.net/l/by-nc-sa/4.0/80x15.png)](https://creativecommons.org/licenses/by-nc-sa/4.0/)
