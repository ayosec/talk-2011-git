
Content = <<'DATA'
<!DOCTYPE html>
<html>
  <head>
    <link href='vendor/deck.js/themes/style/swiss.css' rel='stylesheet' />
    <link href='vendor/deck.js/themes/transition/horizontal-slide.css' rel='stylesheet' />
    <link href='base.css' rel='stylesheet' />
    <link href='http://fonts.googleapis.com/css?family=Josefin+Sans' rel='stylesheet' />
    <link href='http://fonts.googleapis.com/css?family=Quattrocento+Sans' rel='stylesheet' />
  </head>
  <body>
    <div class='deck-container'>
      <div class='slide big-title'>
        <h2>Git</h2>
        <h3>Behind the Scenes</h3>
        <div class='big img'>git.png</div>
      </div>
      <div class='slide'>
        <h2>Git</h2>
        <ul>
          <li class='slide'>Sistema de control de versiones distribuidos</li>
          <li class='slide'>Realmente, base de datos de objetos...</li>
          <li class='slide'>... inspirada la arquitectura de un sistema de ficheros</li>
        </ul>
      </div>
      <div class='slide center-img'>
        <div class='img'>cdgit.png</div>
      </div>
      <div class='slide'>
        <h2>Git: Contenido de un repositorio</h2>
        <ul>
          <li class='slide'>Incrementales</li>
          <li class='slide inner'>
            <b>Objetos</b>
          </li>
          <li class='slide inner'>
            <b>Referencias</b>
          </li>
          <li class='slide'>Fijos</li>
          <li class='slide inner'>Configuración</li>
          <li class='slide inner'>
            <i>Hooks</i>
          </li>
          <li class='slide'>
            <i>Ad-hoc</i>
          </li>
          <li class='slide inner'>Índice</li>
          <li class='slide inner'>
            <i>reflog</i>
          </li>
        </ul>
      </div>
      <div class='slide'>
        <h2>Objetos: Resumen</h2>
        <ul>
          <li class='slide'>
            4 tipos de objetos
            <ul>
              <li><i>blobs</i></li>
              <li><i>tree</i></li>
              <li><i>commit</i></li>
              <li><i>tag</i></li>
            </ul>
          </li>
          <li class='slide'>ID</li>
          <li class='slide inner'>SHA1 (160 bits) del contenido</li>
          <li class='slide inner'>Garantiza consistencia</li>
          <li class='slide inner'>Evita duplicados</li>
          <li class='slide'>
            <tt>.git/objects/</tt>
          </li>
          <li class='slide inner'>1 fichero por objeto</li>
          <li class='slide inner'>Paquete <tt>.git/objects/pack/</tt></li>
        </ul>
      </div>
      <div class='slide'>
        <h2>Repositorio de prueba</h2>
        <ul>
          <li>1 fichero en un 1 directorio</li>
        </ul>
        <pre>$ <b>git init</b>
Initialized empty Git repository in /.../.git/

$ echo test &gt; f

$ <b>git add f</b>

$ <b>git ci -m first</b>
[master (root-commit) c41c478] first
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 f

$ <b>git log --pretty=oneline</b>
c41c478c9e0f5e1a752f062e7fd85c794e725590 first</pre>
      </div>
      <div class='slide'>
        <h2>Qué hay en <tt>.git/objects</tt></h2>
        <pre class='slide'>$ <b>git log --pretty=oneline</b>
c41c478c9e0f5e1a752f062e7fd85c794e725590 first

$ tree <b>.git/objects/</b>
.git/objects/
├── 9d
│   └── aeafb9864cf43055ae93beb0afd6c7d144bfa4
├── c4
│   └── 1c478c9e0f5e1a752f062e7fd85c794e725590
├── d8
│   └── 3ab9cde0e8d3a8984f2030d5ea63ad5fefc6a3
├── info
└── pack

5 directories, 3 files</pre>
      </div>
      <div class='slide'>
        <h2>Cómo ver esos objetos</h2>
        <ul>
          <li><tt>git cat-file</tt></li>
          <li class='slide inner'><tt>-s</tt> tamaño del objeto</li>
          <li class='slide inner'><tt>-t</tt> tipo de objeto</li>
          <li class='slide inner'><tt>-p</tt> presentación legible</li>
        </ul>
        <pre class='slide smaller'>$ <b>git log --pretty=oneline</b>
c41c478c9e0f5e1a752f062e7fd85c794e725590 first

$ <b>git cat-file -t c41c478c9e0f5e1a752f062e7fd85c794e725590</b>
commit

$ <b>git cat-file -s c41c478c9e0f5e1a752f062e7fd85c794e725590</b>
154

$ <b>git cat-file -p c41c478c9e0f5e1a752f062e7fd85c794e725590</b>
tree d83ab9cde0e8d3a8984f2030d5ea63ad5fefc6a3
author Ayose &lt;ayosec@...&gt; 1323362752 +0000
committer Ayose &lt;ayosec@...&gt; 1323362752 +0000

first</pre>
      </div>
      <div class='slide'>
        <h2>Objetos <i>commit</i></h2>
        <ul>
          <li class='slide'>Cada <tt>git commit</tt> crea un objeto <i>commit</i> nuevo</li>
          <li class='slide'>Contiene:</li>
          <li class='slide inner'>Metadatos (autor, fecha, mensaje, ..)</li>
          <li class='slide inner'>Una referencia a un objeto <i>tree</i> (raíz)</li>
          <li class='slide inner'>Referencias a <i>commits</i> padre</li>
          <li class='slide inner2'>El primer <i>commit</i> no tiene padre</li>
          <li class='slide inner2'>Los <i>commit</i>s regulares tienen un solo padre</li>
          <li class='slide inner2'>Casos especiales (como <i>merge</i> recursivos) tiene más de un padre</li>
          <li class='slide'>Visibles con <tt>git cat-file -p</tt> o <tt>git log --pretty=raw</tt></li>
        </ul>
        <br />
        <pre class='smaller'>$ <b>git cat-file -p c41c478c9e0f5e1a752f062e7fd85c794e725590</b>
tree d83ab9cde0e8d3a8984f2030d5ea63ad5fefc6a3
author Ayose &lt;ayosec@...&gt; 1323362752 +0000
committer Ayose &lt;ayosec@...&gt; 1323362752 +0000

first</pre>
      </div>
      <div class='slide'>
        <h2>Objetos <i>tree</i></h2>
        <pre class='slide'>$ <b>git cat-file -p c41c478c9e0f5e1a752f062e7fd85c794e725590 | grep tree</b>
tree d83ab9cde0e8d3a8984f2030d5ea63ad5fefc6a3</pre>
        <pre class='slide'>$ <b>git cat-file -t d83ab9cde0e8d3a8984f2030d5ea63ad5fefc6a3</b>
tree

$ <b>git cat-file -s d83ab9cde0e8d3a8984f2030d5ea63ad5fefc6a3</b>
29

$ <b>git cat-file -p d83ab9cde0e8d3a8984f2030d5ea63ad5fefc6a3</b>
100644 blob 9daeafb9864cf43055ae93beb0afd6c7d144bfa4	f</pre>
        <div class='slide'><tt class="pre">100644 </tt> modo y permisos del fichero</div>
        <div class='slide'><tt class="pre">blob   </tt> tipo de objeto</div>
        <div class='slide'><tt class="pre">9dae...</tt> objeto</div>
        <div class='slide'><tt class="pre">f      </tt> nombre</div>
      </div>
      <div class='slide'>
        <h2>Algo más elaborado: Subdirectorios</h2>
        <pre class='slide only-current'>$ mkdir subA subB
$ echo 1 &gt; subA/a
$ echo 1 &gt; subA/b
$ echo 1 &gt; subB/c
$ echo 1 &gt; subB/d
$ <b>git add .</b>
$ <b>git ci -m 'more dirs'</b>
[master <b>8b8417f</b>] more dirs
 4 files changed, 4 insertions(+), 0 deletions(-)
 create mode 100644 subA/a
 create mode 100644 subA/b
 create mode 100644 subB/c
 create mode 100644 subB/d</pre>
        <pre class='slide'>$ tree
.
├── f
├── subA
│   ├── a
│   └── b
└── subB
    ├── c
    └── d

2 directories, 5 files</pre>
        <pre class='slide'>$ <b>git log --pretty=oneline</b>
8b8417ff86c583ad7f97a9a250465e574d46a375 more dirs
c41c478c9e0f5e1a752f062e7fd85c794e725590 first</pre>
      </div>
      <div class='slide'>
        <h2>Cómo queda con los nuevos directorios</h2>
        <div class='slide'>
          <tt>git ls-tree</tt> para ver contenido de un <i>tree</i> o <i>commit</i>
        </div>
        <pre class='slide'>$ <b>git ls-tree 8b8417ff86c583ad7f97a9a250465e574d46a375</b>
100644 blob 9daeafb9864cf43055ae93beb0afd6c7d144bfa4	f
040000 tree 753c1d6323889c4a5d8cf408d85430d243c2707d	subA
040000 tree 4b31e912af321a69dbfb654316a9fd91c9affbc7	subB</pre>
        <pre class='slide'>$ <b>git ls-tree 753c1d6323889c4a5d8cf408d85430d243c2707d</b>
100644 blob d00491fd7e5bb6fa28c517a0bb32b8b506539d4d	a
100644 blob d00491fd7e5bb6fa28c517a0bb32b8b506539d4d	b

$ <b>git ls-tree 4b31e912af321a69dbfb654316a9fd91c9affbc7</b>
100644 blob d00491fd7e5bb6fa28c517a0bb32b8b506539d4d	c
100644 blob d00491fd7e5bb6fa28c517a0bb32b8b506539d4d	d</pre>
      </div>
      <div class='slide'>
        <h2>Pregunta: ¿Qué ocurre al duplicar un directorio?</h2>
        <pre class='slide'>$ cp -a subA subC</pre>
        <pre class='slide only-current'>$ tree 
.
├── f
├── subA
│   ├── a
│   └── b
├── subB
│   ├── c
│   └── d
└── subC
    ├── a
    └── b

3 directories, 7 files</pre>
        <pre class='slide'>$ git add .
$ git ci -m 'duplicated subA'
[master <b>746e197</b>] duplicated subA
 2 files changed, 2 insertions(+), 0 deletions(-)
 create mode 100644 subC/a
 create mode 100644 subC/b</pre>
        <pre class='slide'>$ <b>git ls-tree 746e197</b></pre>
        <pre class='slide'>100644 blob 9daeafb9864cf43055ae93beb0afd6c7d144bfa4  f
040000 tree <b>753c1d6323889c4a5d8cf408d85430d243c2707d</b>  subA
040000 tree 4b31e912af321a69dbfb654316a9fd91c9affbc7  subB
040000 tree <b>753c1d6323889c4a5d8cf408d85430d243c2707d</b>  subC</pre>
      </div>
      <div class='slide'>
        <h2>Ejercicio</h2>
        <b>¿Cuántos objetos tiene el repositorio después al terminar las siguientes órdenes?</b>
        <div class='slide'>
          <pre>$ rm subB/c
$ <b>git ci -a -m...</b>
$ cp subA/a subB/c
$ <b>git add .</b>
$ <b>git ci -a -m...</b></pre>
          <i>Nota: Antes de ejercutarlas hay 10 objetos</i>
        </div>
        <div class='slide big-quote'>
          Respuesta: <b>14</b>
          <!-- 1º 2 tree + 1 commit; 2º 1 commit -->
        </div>
      </div>
      <div class='slide'>
        <h2>Objetos <i>blob</i></h2>
        <ul>
          <li class='slide'>Contenido de los ficheros, tal cual</li>
          <li class='slide'>No guardan información de nombre, permisos, codificación, etc.</li>
        </ul>
        <pre class='slide'>$ git ls-tree HEAD
100644 <b>blob 9daeafb9864cf43055ae93beb0afd6c7d144bfa4</b>	f
040000 tree 753c1d6323889c4a5d8cf408d85430d243c2707d	subA
040000 tree 4b31e912af321a69dbfb654316a9fd91c9affbc7	subB
040000 tree 753c1d6323889c4a5d8cf408d85430d243c2707d	subC

$ git cat-file -t 9daeafb9864cf43055ae93beb0afd6c7d144bfa4
blob

$ git cat-file -s 9daeafb9864cf43055ae93beb0afd6c7d144bfa4
5

$ git cat-file -p 9daeafb9864cf43055ae93beb0afd6c7d144bfa4
test</pre>
      </div>
      <div class='slide'>
        <h2>Objetos <i>tag</i></h2>
        <ul>
          <li class='slide'>Referencia permamente a un commit</li>
          <li class='slide inner'>Realmente puede apuntar a cualquier tipo de objeto</li>
          <li class='slide'>Puede tener comentarios, firma GPG, etc</li>
          <li class='slide'>Se almacenan en <tt>.git/refs/tags/</tt></li>
        </ul>
        <div class='slide'>Normalmente se usan para marcar <i>releases</i></div>
        <div class='slide'>
          <pre>$ git tag v0.3
$ git push

...

$ git co v0.3</pre>
        </div>
      </div>
      <div class='slide'>
        <h2>Qué hay en el tag</h2>
        <ul>
          <li class='slide'>Si no añade información (como en <tt>git tag v0.3</tt>) apunta directamente al objeto etiquetado</li>
          <li class='slide'>Si añade metadatos (descripción, firma) tiene objeto propio</li>
        </ul>
        <pre class='slide'>$ git cat-file -p HEAD
tree <b>fe91fcf2a6f5ee1ce8e6a42a9f4727731da4e264</b>
parent 78ddab40397de4b48851985e2282deb37ddf82b2
author Ayose &lt;ayosec@...&gt; 1323367604 +0000
committer Ayose &lt;ayosec@...&gt; 1323367604 +0000

...
$ <b>git tag v0.5 HEAD</b>
$ <b>git tag -m'foo bar' base_dir fe91fcf2a6f5ee1ce8e6a42a9f4727731da4e264</b></pre>
      </div>
      <div class='slide'>
        <h2>Qué hay en el tag (2)</h2>
        <pre>$ <b>git tag v0.5 HEAD</b>
$ <b>git tag -m'foo bar' base_dir fe91fcf2a6f5ee1ce8e6a42a9f4727731da4e264</b></pre>
        <pre class='slide'>$ <b>git tag -l</b>
base_dir
v0.5</pre>
        <pre class='slide only-current'>$ <b>git cat-file -p v0.5</b>
tree fe91fcf2a6f5ee1ce8e6a42a9f4727731da4e264
parent 78ddab40397de4b48851985e2282deb37ddf82b2
author Ayose &lt;ayosec@...&gt; 1323367604 +0000
committer Ayose &lt;ayosec@...&gt; 1323367604 +0000

...

$ <b>git rev-parse v0.5</b>
aeaa1b4a195ad5e5724878a976ec92bb8453591b

$ <b>git rev-parse HEAD</b>
aeaa1b4a195ad5e5724878a976ec92bb8453591b</pre>
        <pre class='slide'>$ <b>git cat-file -p base_dir</b>
object fe91fcf2a6f5ee1ce8e6a42a9f4727731da4e264
type tree
tag base_dir
tagger Ayose &lt;ayosec@...&gt; Thu Dec 8 18:38:00 2011 +0000

foo bar</pre>
      </div>
      <div class='slide'>
        <h2>De vuelta al <tt>.git/objects</tt></h2>
        <b>16 objetos</b>
        <pre class='smaller'>$ <b>find .git/objects/ -type f</b>
.git/objects/a3/80f6aa5e15624085082c25c64d7b30f7211c70
.git/objects/bd/ea332870692c740e8250c78080a4e9ef218b96
.git/objects/ae/aa1b4a195ad5e5724878a976ec92bb8453591b
.git/objects/78/ddab40397de4b48851985e2282deb37ddf82b2
.git/objects/37/29b70a25d18107840f38fdd8b76742097c1d34
.git/objects/19/759dffe20c5c45d40478b021bed9ca5cc149ea
.git/objects/74/6e197c06569e44a9f4b9a3b8844c12d4652d3a
.git/objects/fe/91fcf2a6f5ee1ce8e6a42a9f4727731da4e264
.git/objects/8b/8417ff86c583ad7f97a9a250465e574d46a375
.git/objects/02/c79b75c3bef2a95106c70d053a5e668c852fb4
.git/objects/4b/31e912af321a69dbfb654316a9fd91c9affbc7
.git/objects/75/3c1d6323889c4a5d8cf408d85430d243c2707d
.git/objects/d0/0491fd7e5bb6fa28c517a0bb32b8b506539d4d
.git/objects/c4/1c478c9e0f5e1a752f062e7fd85c794e725590
.git/objects/d8/3ab9cde0e8d3a8984f2030d5ea63ad5fefc6a3
.git/objects/9d/aeafb9864cf43055ae93beb0afd6c7d144bfa4</pre>
      </div>
      <div class='slide'>
        <h2>Qué hay en esos ficheros</h2>
        <ul>
          <li class='slide'>
            <b>Formato:</b>
            <ul>
              <li>Tipo (blog, tree, ...)</li>
              <li><i>espacio</i></li>
              <li>Tamaño</li>
              <li>\0</li>
              <li>Contenido</li>
            </ul>
          </li>
          <li class='slide'>Cada fichero comprimido con Zlib</li>
        </ul>
        <pre class='slide smaller'>$ git rev-parse HEAD
aeaa1b4a195ad5e5724878a976ec92bb8453591b

$ export FILE=.git/objects/ae/aa1b4a195ad5e5724878a976ec92bb8453591b
$ <b>ruby -rzlib -e 'puts Zlib.inflate(File.read(ENV["FILE"]))'</b>
commit 200<b>\0</b>tree fe91fcf2a6f5ee1ce8e6a42a9f4727731da4e264
parent 78ddab40397de4b48851985e2282deb37ddf82b2
author Ayose &lt;ayosec@...&gt; 1323367604 +0000
committer Ayose &lt;ayosec@...&gt; 1323367604 +0000

...</pre>
      </div>
      <div class='slide'>
        <h2>Cómo validar un objeto desde Ruby</h2>
        <pre>$ irb -rzlib -rdigest/sha1
&gt;&gt; git_object = Zlib.inflate(File.read(".git/objects/ae/aa1b4a1<b>[...]</b>"))
=&gt; "commit 2 <b>[...]</b>"
&gt;&gt; <b>Digest::SHA1.hexdigest(git_object)</b>
=&gt; "aeaa1b4a195ad5e5724878a976ec92bb8453591b"</pre>
      </div>
      <div class='slide'>
        <h2>Mantenimiento</h2>
        <ul>
          <li class='slide'><tt>git fsck</tt>: Verifica integridad del repositorio</li>
          <li class='slide inner'>Busca objetos inalcanzables</li>
          <li class='slide inner'>Valida sumas SHA1</li>
          <li class='slide inner'>Etc</li>
        </ul>
        <ul>
          <li class='slide'><tt>git gc</tt>: Limpieza y optimización</li>
          <li class='slide inner'>Borra objetos viejos inalcanzables (<tt>--no-prune</tt> para evitarlo)</li>
          <li class='slide inner'>Crea un paquete con los objetos (si no existe ya)</li>
          <li class='slide inner2'>El repositorio ocupa menos (a mayor tamaño de fichero mayor razón de compresión)</li>
          <li class='slide inner2'>Menos accesos a disco ⇒ operaciones más rápidas</li>
          <li class='slide inner'>Se recomienda usarlo cada cierto tiempo</li>
        </ul>
        <ul>
          <li class='slide'><tt>git prune</tt>: Elimina objetos inalcanzables</li>
        </ul>
      </div>
      <div class='slide'>
        <h2>Referencias</h2>
        <ul>
          <li class='slide'>Ramas y etiquetas</li>
          <li class='slide'>Sólo una referencia a un <i>commit</i></li>
          <li class='slide'>Se van añadiendo a <tt>.git/refs/</tt> cuando se crean</li>
          <li class='slide'>El <tt>gc</tt> las comprime en <tt>.git/info/refs</tt></li>
          <li class='slide'><tt>.git/HEAD</tt> referencia al <i>commit</i> que generó la actual copia de trabajo</li>
        </ul>
      </div>
      <div class='slide'>
        <h2>Creación de ramas</h2>
        <pre>git branch NAME</pre>
        Equivale a
        <pre>git rev-parse HEAD > .git/refs/heads/NAME</pre>
      </div>
      <div class='slide'>
        <h2>Crear una rama desde el ID de un <i>commit</i></h2>
        (1)
        <pre>git co fad5e072
git co -b new_name</pre>
        (2)
        <pre>git rev-parse fad5e072 > .git/refs/heads/new_name
git co new_name</pre>
        <div class='slide'>
          Huelga decir que la interfaz siempre debe ser la primera opción.
        </div>
      </div>
      <div class='slide'>
        <h2>Hacia dónde puede saltar un <tt>checkout</tt></h2>
        <ul>
          <li class='slide'>Nombre de una rama: <tt>git co master</tt></li>
          <li class='slide'>Nombre de un <i>tag</i>: <tt>git co v2.8</tt></li>
          <li class='slide'>ID de un <i>commit</i>: <tt>git co 8b8417</tt></li>
          <li class='slide'><i>commit</i> relativo: <tt>git co HEAD^^</tt> (dos <i>commit</i>s anteriores a <tt>HEAD</tt>)</li>
          <li class='slide'>A una fecha: <tt>git co master@{yesterday}</tt></li>
          <li class='slide'>Búsqueda por texto: <tt>git co ':/duplicated subA'</tt></li>
          <li class='slide'>Muchísimas opciones más...</li>
          <li class='slide'>
            <b>Regla:</b> Todo lo que acepta <tt>git rev-parse</tt>
            <p>Más en <tt>git rev-parse --help</tt> sección “<i>SPECIFYING REVISIONS</i>”</p>
          </li>
        </ul>
        <div class='slide'>
          Se puede aplicar lo mismo para <tt>merge</tt>, <tt>cherry-pick</tt>, <tt>rebase</tt>, etc.
        </div>
      </div>
      <div class='slide'>
        <h2><i>stash</i></h2>
        <ul>
          <li class='slide'><tt>git stash</tt> genera un commit completo y lo guarda en <tt>.git/refs/stash</tt></li>
          <li class='slide'>Cuando aplica un <i>stash</i> recupera el contenido de los objetos</li>
          <li class='slide'>Si el <i>stash</i> se descarta (<tt>git stash drop</tt>) los objetos se mantienen en la BBDD</li>
        </ul>
      </div>
      <div class='slide'>
        <h2>Ejemplo de <i>stash</i></h2>
        <div class='slide only-current'>
          Modificamos <tt>f</tt> y movemos el cambio a un <i>stash</i>
          <pre>$ vi f
$ <b>git stash</b>
Saved working directory and index state WIP on master: aeaa1b4 ...
HEAD is now at aeaa1b4 ...</pre>
        </div>
        <div class='slide only-current'>
          <p><tt>.git/refs/stash</tt> apunta a un objeto <i>commit</i> con dos padres</p>
          <pre>$ cat .git/refs/stash 
29255e219125facb03be2dbdecb5cbd8d8b0b4db

$ git cat-file -p 29255e219125facb03be2dbdecb5cbd8d8b0b4db
tree 4c8c05eb8dd054a752b9d0585c1464315c088ded
parent <b>aeaa1b4a195ad5e5724878a976ec92bb8453591b</b>
parent <b>051e66721ea1cc6de94b122e3b7d6038cb1d6c69</b>
author Ayose &lt;ayosec@...&gt; 1323388171 +0000
committer Ayose &lt;ayosec@...&gt; 1323388171 +0000

WIP on master: aeaa1b4 ...</pre>
        </div>
        <div class='slide only-current'>
          <p>El primer padre es el <tt>HEAD</tt> en el momento de hacer el <i>stash</i></p>
          <pre>$ git cat-file -p <b>aeaa1b4a195ad5e5724878a976ec92bb8453591b</b>
tree fe91fcf2a6f5ee1ce8e6a42a9f4727731da4e264
parent 78ddab40397de4b48851985e2282deb37ddf82b2
author Ayose &lt;ayosec@...&gt; 1323367604 +0000
committer Ayose &lt;ayosec@...&gt; 1323367604 +0000

...</pre>
        </div>
        <div class='slide only-current'>
          <p>El segundo padre es un <i>commit</i> nuevo con las modificaciones que estaban pendientes</p>
          <pre>$ git cat-file -p <b>051e66721ea1cc6de94b122e3b7d6038cb1d6c69</b>
tree fe91fcf2a6f5ee1ce8e6a42a9f4727731da4e264
parent aeaa1b4a195ad5e5724878a976ec92bb8453591b
author Ayose &lt;ayosec@...&gt; 1323388171 +0000
committer Ayose &lt;ayosec@...&gt; 1323388171 +0000

index on master: aeaa1b4 ...</pre>
        </div>
        <div class='slide only-current'>
          <p>Podemos descartar el <i>stash</i>...</p>
          <pre>$ <b>git stash drop</b>
Dropped refs/stash@{0} (29255e219125facb03be2dbdecb5cbd8d8b0b4db)</pre>
          <p>... y comprobar que los objetos siguen accesibles</p>
          <pre>$ git cat-file -p <b>051e66721ea1cc6de94b122e3b7d6038cb1d6c69</b>
tree fe91fcf2a6f5ee1ce8e6a42a9f4727731da4e264
parent aeaa1b4a195ad5e5724878a976ec92bb8453591b
author Ayose &lt;ayosec@...&gt; 1323388171 +0000
committer Ayose &lt;ayosec@...&gt; 1323388171 +0000

index on master: aeaa1b4 ...

$ <b>git fsck</b>
dangling commit 29255e219125facb03be2dbdecb5cbd8d8b0b4db</pre>
        </div>
        <div class='slide only-current'>
          <pre>$ <b>git fsck --unreachable</b>
unreachable commit 051e66721ea1cc6de94b122e3b7d6038cb1d6c69
unreachable tree 4c8c05eb8dd054a752b9d0585c1464315c088ded
unreachable blob a860f35a7f3faa734131cb0801238239628823a1
unreachable commit 29255e219125facb03be2dbdecb5cbd8d8b0b4db</pre>
        </div>
      </div>
      <div class='slide'>
        <h2>Índice</h2>
        <div class='autolink'>http://osteele.com/archives/2008/05/my-git-workflow</div>
        <div class='big img'>git-transport.png</div>
      </div>
      <div class='slide'>
        <h2>Índice: Un <i>commit</i> por fases</h2>
        <ul>
          <li class='slide'><tt>.git/index</tt> contiene una lista de <i>blobs</i></li>
          <li class='slide'>Similar a un <i>tree</i></li>
          <li class='slide'><tt>git add</tt> crea un <i>blob</i> si no existe</li>
          <li class='slide'>Un índice puede tener cambios parciales (<tt>git add -p</tt>)</li>
        </ul>
      </div>
      <div class='slide'>
        <h2>Inspeccionar el índice</h2>
        <ul class='slide'>
          <li>
            Típicas
            <ul>
              <li><tt>git status</tt></li>
              <li><tt>git diff --cached</tt></li>
            </ul>
          </li>
        </ul>
        <ul class='slide'>
          <li><tt>git ls-files --stage</tt></li>
        </ul>
      </div>
      <div class='slide'>
        <h2>Ejemplo con el índice</h2>
        <pre class='slide'>$ echo some other line &gt;&gt; f</pre>
        <pre class='slide'>$ git add .</pre>
        <pre class='slide'>$ <b>git ls-files --stage</b>
100644 <b>2926bd6051bcc9edcb6392c86d695e8387e2f8ce 0 f</b>
100644 d00491fd7e5bb6fa28c517a0bb32b8b506539d4d 0 subA/a
100644 d00491fd7e5bb6fa28c517a0bb32b8b506539d4d 0 subA/b
100644 d00491fd7e5bb6fa28c517a0bb32b8b506539d4d 0 subB/c
100644 d00491fd7e5bb6fa28c517a0bb32b8b506539d4d 0 subB/d
100644 d00491fd7e5bb6fa28c517a0bb32b8b506539d4d 0 subC/a
100644 d00491fd7e5bb6fa28c517a0bb32b8b506539d4d 0 subC/b</pre>
        <pre class='slide'>$ git cat-file -p <b>2926bd6051bcc9edcb6392c86d695e8387e2f8ce</b>
test
some other line</pre>
      </div>
      <div class='slide'>
        <h2>El índice puede dejar objetos sin uso</h2>
        <pre class='slide'>$ <b>git reset</b>
Unstaged changes after reset:
M f</pre>
        <pre class='slide'>$ <b>git fsck</b>
dangling blob <b>2926bd6051bcc9edcb6392c86d695e8387e2f8ce</b>
dangling commit 29255e219125facb03be2dbdecb5cbd8d8b0b4db</pre>
        <div class='slide important'>
          <p>Eso no significa que haya que hacer <tt>git add</tt> con poca frecuencia.</p>
        </div>
      </div>
      <div class='slide' style="background: black !important; height: 100%">
        &nbsp;
      </div>
    </div>
  </body>
</html>
<script src='vendor/jquery.js'></script>
<script src='vendor/deck.js/modernizr.custom.js'></script>
<script src='vendor/deck.js/core/deck.core.js'></script>
<script src='vendor/deck.js/extensions/menu/deck.menu.js'></script>
<script src='vendor/deck.js/extensions/goto/deck.goto.js'></script>
<script src='vendor/deck.js/extensions/status/deck.status.js'></script>
<script src='vendor/deck.js/extensions/hash/deck.hash.js'></script>
<script type='text/javascript'>
  //<![CDATA[
    $(function() {
    
      /* Auto content */
      $(".img").each(function() {
        var node = $(this);
        var img = $("<img>", {src: "images/" + node.text()});
        node.html("").append(img);
      });
    
      $(".autolink").each(function() {
        var node = $(this);
        node.replaceWith($("<a>", {href: node.text(), text: node.text(), target: "_blank"}));
      });
    
      /*$(".strip-left-spaces").each(function() {
        this.innerHTML = this.innerHTML.replace(/^\s+/gm, '');
      });*/
    
      var container = $(".deck-container");
      container.hide();
      $.deck('.slide');
      container.show();
    });
  //]]>
</script>
DATA

class App < Sinatra::Base
  get "/" do
    Content
  end
end

