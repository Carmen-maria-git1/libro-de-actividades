
```
Curso       : 202021, 201920, 201819, 201718
Area        : Sistemas Operativos, automatización, Devops
Descripción : Uso de la herramienta de automatización Vagrant
Requisitos  : Vagrant y Virtualbox
Tiempo      : 6 sesiones
```

# Vagrant con VirtualBox

Ejemplo de rúbrica:

| Sección               | Muy bien (2) | Regular (1) | Poco adecuado (0) |
| --------------------- | ------------ | ----------- | ----------------- |
| (3.3) Comprobar proyecto 1    | | | |
| (5.2) Comprobar proyecto 2    | | | |
| (6.1) Suministro Shell Script | | | |
| (6.2) Suministro Puppet       | | | |
| (7.2) Crear Box Vagrant       | | |. |

---
# 1. Introducción

Según *Wikipedia*:

Vagrant es una herramienta para la creación
y configuración de entornos de desarrollo virtualizados.

Originalmente se desarrolló para VirtualBox y sistemas de configuración
tales como Chef, Salt y Puppet.

Sin embargo desde la versión 1.1 Vagrant es capaz de trabajar con múltiples proveedores,
como VMware, Amazon EC2, LXC, DigitalOcean, etc.2

Aunque Vagrant se ha desarrollado en Ruby se puede usar en multitud de
proyectos escritos en otros lenguajes.

> NOTA: Para desarrollar esta actividad se ha utilizado principalmente
la información del enlace anterior publicado por Jonathan Wiesel, el 16/07/2013.

---
# 2. Instalar Vagrant

> Enlaces de interés:
> * [Introducción a Vagrant](https://code.tutsplus.com/es/tutorials/introduction-to-vagrant--cms-25917)
> * [Cómo instalar y configurar Vagrant](http://codehero.co/como-instalar-y-configurar-vagrant/)
> * [Instalar vagrant en OpenSUSE 13.2](http://gattaca.es/post/running-vagrant-on-opensuse/)
> * [Descargar y actualizar vagrant](https://www.vagrantup.com/downloads.html)

La instalación vamos a hacerla en una máquina real.
* Instalar Vagrant.
* Hay que comprobar que las versiones de ambos programas son compatibles entre sí.
    * `vagrant version`, para comprobar la versión actual de Vagrant.
    * `VBoxManage -v`, para comprobar la versión actual de VirtualBox.

---
# 3. Proyecto Celtics

## 3.1 Imagen, caja o box

Existen muchos repositorios desde donde podemos descargar la cajas de Vagrant (Imágenes o boxes). Incluso podemos descargarnos cajas de otros sistemas oprativos desde [VagrantCloud Box List](https://app.vagrantup.com/boxes/search?provider=virtualbox)

> OJO: Sustituir **BOXNAME** por `ubuntu/bionic64`

* `vagrant box add BOXNAME`, descargar la caja que necesitamos a través de vagrant.
* `vagrant box list`, lista las cajas/imágenes disponibles actualmente en nuestra máquina.

```
> vagrant box list
BOXNAME (virtualbox, 0)
```

## 3.2 Directorio

* Crear un directorio para nuestro proyecto. Donde XX es el número de cada alumno:

```
mkdir vagrantXX-celtics
cd vagrantXX-celtics
```

A partir de ahora vamos a trabajar dentro de esta carpeta.
* Crear el fichero `Vagrantfile` de la siguiente forma:
```
Vagrant.configure("2") do |config|
  config.vm.box = "BOXNAME"
  config.vm.hostname = "nombre-alumnoXX-celtics"
  config.vm.provider "virtualbox"
end
```

> NOTA: Con `vagrant init` se crea un fichero `Vagrantfile` con las opciones por defecto.

## 3.3 Comprobar

Vamos a crear una MV nueva y la vamos a iniciar usando Vagrant:
* Debemos estar dentro de `vagrantXX-celtics`.
* `vagrant up`, para iniciar una nueva instancia de la máquina.
* `vagrant ssh`: Conectar/entrar en nuestra máquina virtual usando SSH.

> **Otros comandos últiles de Vagrant son**:
> * `vagrant suspend`: Suspender la máquina virtual. Tener en cuenta que la MV en modo **suspendido** consume más espacio en disco debido a que el estado de la máquina virtual que suele almacenarse en la RAM se pasa a disco.
> * `vagrant resume` : Volver a despertar la máquina virtual.
> * `vagrant halt`: Apagarla la máquina virtual.
> * `vagrant status`: Estado actual de la máquina virtual.
> * `vagrant destroy`: Para eliminar la máquina virtual (No los ficheros de configuración).

---
# 4. TEORÍA

`NO ES NECESARIO hacer este apartado. Sólo es información.`

A continuación se muestran ejemplos de configuración Vagrantfile que NO ES NECESARIO hacer. Sólo es información.

> Enlace de interés [Tutorial Vagrant. ¿Qué es y cómo usarlo?](https://geekytheory.com/tutorial-vagrant-1-que-es-y-como-usarlo)

**Carpetas compartidas**

La carpeta del proyecto que contiene el `Vagrantfile` es visible
para el sistema el virtualizado, esto nos permite compartir archivos fácilmente entre los dos entornos.

Ejemplos para configurar las carpetas compartidas:
* `config.vm.synced_folder ".", "/vagrant"`: La carpeta del proyecto es accesible desde /vagrant de la MV.
* `config.vm.synced_folder "html", "/var/www/html"`. La carpeta htdocs del proyecto es accesible desde /var/www/html de la MV.

**Redireccionamiento de los puertos**

Cuando trabajamos con máquinas virtuales, es frecuente usarlas para proyectos enfocados a la web, y para acceder a las páginas es necesario configurar el enrutamiento de puertos.

* `config.vm.network "private_network", ip: "192.168.33.10"`: Ejemplo para configurar la red.

**Conexión SSH**: Ejemplo para personalizar la conexión SSH a nuestra máquina virtual:

```
config.ssh.username = 'root'
config.ssh.password = 'vagrant'
config.ssh.insert_key = 'true'
```

Ejemplo para configurar la ejecución remota de aplicaciones gráficas instaladas en la máquina virtual, mediante SSH:
```
config.ssh.forward_agent = true
config.ssh.forward_x11 = true
```

> ¿Cómo podríamos crear una MV Windows usando vagrant en GNU/Linux?

---
# 5. Proyecto Hawks

Ahora vamos a hacer otro proyecto añadiendo redirección de puertos.

## 5.1 Creamos proyecto Hawks

* Crear carpeta `vagrantXX-hawks`. Entrar en el directorio.
* Crear proyecto Vagrant.
* Configurar Vagrantfile para usar nuestra caja BOXNAME y hostname = "nombre-alumnoXX-hawks".
* Modificar el fichero `Vagrantfile`, de modo que el puerto 4567 del sistema anfitrión sea enrutado al puerto 80 del ambiente virtualizado.
  * `config.vm.network :forwarded_port, host: 4567, guest: 80`
* `vagrant ssh`, entramos en la MV
* Instalamos apache2.

> NOTA: Cuando la MV está iniciada y queremos recargar el fichero de configuración si ha cambiado hacemos `vagrant reload`.

## 5.2 Comprobar

Para confirmar que hay un servicio a la escucha en 4567, desde la máquina real
podemos ejecutar los siguientes comandos:
* En el HOST-CON-VAGRANT (Máquina real). Comprobaremos que el puerto 4567 está a la escucha.
    * `vagrant port` para ver la redirección de puertos de la máquina Vagrant.
* En HOST-CON-VAGRANT, abrimos el navegador web con el URL `http://127.0.0.1:4567`. En realidad estamos accediendo al puerto 80 de nuestro sistema virtualizado.

---
# 6. Suministro

Una de los mejores aspectos de Vagrant es el uso de herramientas de suministro. Esto es, ejecutar *"una receta"* o una serie de scripts durante el proceso de arranque del entorno virtual para instalar, configurar y personalizar un sin fin de aspectos del SO del sistema anfitrión.

* `vagrant halt`, apagamos la MV.
* `vagrant destroy` y la destruimos para volver a empezar.

## 6.1 Proyecto Lakers (Suministro mediante shell script)

Ahora vamos a suministrar a la MV un pequeño script para instalar Apache.
* Crear directorio `vagrantXX-lakers` para nuestro proyecto.
* Entrar en dicha carpeta.
* Crear la carpeta `html` y crear fichero `html/index.html` con el siguiente contenido:
```
<h1>Proyecto Lakers</h1>
<p>Curso202021</p>
<p>Nombre-del-alumno</p>
```
* Crear el script `install_apache.sh`, dentro del proyecto con el siguiente
contenido:
```
#!/usr/bin/env bash

apt-get update
apt-get install -y apache2
```

Incluir en el fichero de configuración `Vagrantfile` lo siguiente:
* `config.vm.hostname = "nombre-alumnoXX-lakers"`
* `config.vm.provision :shell, :path => "install_apache.sh"`, para indicar a Vagrant que debe ejecutar el script `install_apache.sh` dentro del entorno virtual.
* `config.vm.synced_folder "html", "/var/www/html"`, para sincronizar la carpeta exterior `html` con la carpeta interior. De esta forma el fichero "index.html" será visible dentro de la MV.
* `vagrant up`, para crear la MV.
    * Podremos notar, al iniciar la máquina, que en los mensajes de salida se muestran mensajes que indican cómo se va instalando el paquete de Apache que indicamos.
* Para verificar que efectivamente el servidor Apache ha sido instalado e iniciado, abrimos navegador en la máquina real con URL `http://127.0.0.1:4567`.

![vagrant-forward-example](./images/vagrant-forward-example.png)

> NOTA: Podemos usar `vagrant reload`, si la MV está en ejecución, para que coja los cambios de configuración sin necesidad de reiniciar.

## 6.2 Proyecto Raptors (Suministro mediante Puppet)

> Enlace de interés:
> * [Crear un entorno de desarrollo con vagrant y puppet](http://developerlover.com/crear-un-entorno-de-desarrollo-con-vagrant-y-puppet/)
> * `friendsofvagrant.github.io -> Puppet Provisioning`
>
> Veamos imágenes de ejemplo (de Aarón Gonźalez Díaz) con Vagrantfile configurado con puppet:
>
> ![vagranfile-puppet](./images/vagrantfile-puppet.png)
>
> Fichero de configuración de puppet `mipuppet.pp`:
>
> ![vagran-puppet-pp-file](./images/vagrant-puppet-pp-file.png)

Se pide hacer lo siguiente.
* Crear directorio `vagrantXX-raptors` como nuevo proyecto Vagrant.
* Modificar el archivo `Vagrantfile` de la siguiente forma:

```
Vagrant.configure("2") do |config|
  ...
  config.vm.hostname = "nombre-alumnoXX-raptors"
  ...
  # Nos aseguramos de tener Puppet en la MV antes de usarlo.
  config.vm.provision "shell", inline: "sudo apt-get update && sudo apt-get install -y puppet"

  # Hacemos aprovisionamiento con Puppet
  config.vm.provision "puppet" do |puppet|
    puppet.manifest_file = "nombre-del-alumnoXX.pp"
  end
 end
```

> Cuando usamos `config.vm.provision "shell", inline: '"echo "Hola"'`, se ejecuta directamente el comando especificado en la MV. Es lo que llamaremos provisión inline.

* Ahora hay que crear el fichero `manifests/nombre-del-alumnoXX.pp`, con las órdenes/instrucciones Puppet para instalar un programa determinado (Cambiar `PACKAGENAME` por el paquete que queramos). Ejemplo:

```
package { 'PACKAGENAME':
  ensure => 'present',
}
```

> El Puppet es un gestor de infraestructura que veremos en otra actividad.

Para que se apliquen los cambios de configuración tenemos 2 caminos:
* **Con la MV encendida**
    1. `vagrant reload`, recargar la configuración.
    2. `vagrant provision`, volver a ejecutar la provisión.
* **Con la MV apagada**:
    1. `vagrant destroy`, destruir la MV.
    2. `vagrant up` volver a crearla.

> **Suministro con Salt-stack**
>
> * [Salt Provisioner](https://www.vagrantup.com/docs/provisioning/salt.html)

---
# 7. Proyecto Bulls (Nuestra caja)

En los apartados anteriores hemos descargado una caja/box de un repositorio de Internet, y la hemos personalizado. En este apartado vamos a crear nuestra propia caja/box a partir de una MV de VirtualBox que tengamos.

## 7.1 Preparar la MV VirtualBox

> Enlace de interés:
> * Indicaciones de [¿Cómo crear una Base Box en Vagrant a partir de una máquina virtual](http://www.dbigcloud.com/virtualizacion/146-como-crear-un-vase-box-en-vagrant-a-partir-de-una-maquina-virtual.html) para preparar la MV de VirtualBox.

**Elegir una máquina virtual**

Lo primero que tenemos que hacer es preparar nuestra máquina virtual con una determinada configuración para poder publicar nuestro Box.

* Crear una MV VirtualBox nueva o usar una que ya tengamos.
* Configurar la red en modo automático o dinámico (DHCP).
* Instalar OpenSSH Server en la MV.

**Crear usuario con aceso SSH**

Vamos a crear el usuario `vagrant`. Esto lo hacemos para poder acceder a la máquina virtual por SSH desde fuera con este usuario. Y luego, a este usuario le agregamos una clave pública para autorizar el acceso sin clave desde Vagrant. Veamos cómo:

* Ir a la MV de VirtualBox.
* Crear el usuario `vagrant`en la MV.
    * `su`
    * `useradd -m vagrant`
* Poner clave "vagrant" al usuario vagrant.
* Poner clave "vagrant" al usuario root.
* Configuramos acceso por clave pública al usuario `vagrant`:
    * `mkdir -pm 700 /home/vagrant/.ssh`, creamos la carpeta de configuración SSH.
    * `wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O /home/vagrant/.ssh/authorized_keys`, descargamos la clave pública.
    * `chmod 0600 /home/vagrant/.ssh/authorized_keys`, modificamos los permisos de la carpeta.
    * `chown -R vagrant /home/vagrant/.ssh`, modificamos el propietario de la carpeta.

> NOTA:
> * Podemos cambiar los parámetros de configuración del acceso SSH. Mira la teoría...
> * Ejecuta `vagrant ssh-config`, para averiguar donde está la llave privada para cada máquina.

**Sudoers**

Tenemos que conceder permisos al usuario `vagrant` para que pueda hacer tareas privilegiadas como configurar la red, instalar software, montar carpetas compartidas, etc. Para ello debemos configurar el fichero `/etc/sudoers` (Podemos usar el comando `visudo`) para que no nos solicite la password de root, cuando realicemos estas operaciones con el usuario `vagrant`.

* Añadir `vagrant ALL=(ALL) NOPASSWD: ALL` al fichero de configuración `/etc/sudoers`. Comprobar que no existe una linea indicando requiretty si existe la comentamos.

**Añadir las VirtualBox Guest Additions**

* Debemos asegurarnos que tenemos instalado las VirtualBox Guest Additions con una versión compatible con el host anfitrión. Comprobamos:
```
root@hostname:~# modinfo vboxguest |grep version
version:        6.0.24
```
* Apagamos la MV.

## 7.2 Crear caja Vagrant

Una vez hemos preparado la máquina virtual ya podemos crear el box.

* Vamos a crear una nueva carpeta `vagrantXX-bulls`, para este nuevo proyecto vagrant.
* `VBoxManage list vms`, comando de VirtualBox que muestra los nombres de nuestras MVs. Elegir una de las máquinas (VMNAME).
* Nos aseguramos que la MV de VirtualBox VMNAME está apagada.
* `vagrant package --base VMNAME --output nombre-alumnoXX.box`, parar crear nuestra propia caja.
* Comprobamos que se ha creado el fichero `nombre-alumnoXX.box` en el directorio donde hemos ejecutado el comando.
* `vagrant box add nombre-alumno/bulls nombre-alumnoXX.box`, añadimos la nueva caja creada por nosotros, al repositorio local de cajas vagrant de nuestra máquina.
* `vagrant box list`, consultar ahora la lista de cajas Vagrant disponibles.

## 7.3 Usar la nueva caja

* Crear un nuevo fichero Vagrantfile para usar nuestra caja.
* Levantamos una nueva MV a partir del Vagranfile.
* Nos debemos conectar sin problemas (`vagant ssh`).

Cuando terminemos la práctica, ya no nos harán falta las cajas (boxes) que tenemos cargadas en nuestro repositorio local.
Por tanto, podemos borrarlas para liberar espacio en disco:

* `vagrant box list`, para consultar las cajas disponibles.
* `vagrant box remove BOXNAME`, para eliminar una caja BOXNAME de nuestro repositorio local.

---
# ANEXO

## Pendiente

* Ampliar esta práctica para comprobar el funcionamiento de Vagrant bajo Windows y usar cajas/boxes vagrant con Windows. Ver ejemplo:

```
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "windows10" do |i|
    i.vm.box = "senglin/win-10-enterprise-vs2015community"
    i.vm.box_version = "1.0.0"
    i.vm.hostname = "profesor42w10"
    i.vm.network "public_network", bridge: [ "eth0" ]
    i.vm.network :forwarded_port, guest: 80, host: 8081
    i.vm.provider "virtualbox" do |v|
      v.name = "windows10-ent-vs2015"
      v.memory = 2048
    end
  end
end
```

## A.3 Cambios próximo Curso

* Probar Vagrant dentro de una MV...y luego con VBox dentro de la MV.
* Arreglar warning que Apache2 "Fully qualified. domain name".
* Duda: ¿El comando vagrant package XXX debe ejecutarse en $HOME? Porque parece que se crea un directorio .vagrant.

## A.4 VBoxManage

https://www.garron.me/es/gnu-linux/controla-maquinas-virtuales-virtualbox.html

VBoxManage showvminfo VMNAME | grep State


## A.5 Versión1

```
su
useradd -m vagrant
su - vagrant
mkdir .ssh
wget https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub -O .ssh/authorized_keys
chmod 700 .ssh
chmod 600 .ssh/authorized_keys
```
