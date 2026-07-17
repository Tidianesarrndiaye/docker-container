# docker-container

Je stocke ici mes projets et mon apprentissage autour de Docker et des conteneurs.

## Ce que je fais en général dans mes projets

Dans ce dépôt, je travaille surtout sur des sujets pratiques liés à la conteneurisation, avec une approche progressive :

* **Création d’environnements reproductibles** avec Dockerfile et configurations claires.
* **Tests rapides des images et des conteneurs** pour valider qu’un projet démarre correctement.
* **Organisation simple des fichiers** pour garder des projets faciles à relire et à maintenir.
* **Amélioration continue** : j’itère étape par étape pour apprendre, corriger et optimiser.
* **Documentation des intentions** pour expliquer ce que je construis, pourquoi, et comment le relancer facilement.

L’objectif global est de construire des bases solides sur Docker, d’appliquer de bonnes pratiques, et de conserver une trace claire de mes expérimentations.

## Commandes utiles Docker

### Flags de base (les plus utilisés)

| Commande | Flag | Rôle |
|---|---|---|
| `docker run` | `-d` | Lance le conteneur en arrière-plan (mode détaché). |
| `docker run` | `--name` | Donne un nom lisible au conteneur. |
| `docker run` | `-p hôte:conteneur` | Expose un port du conteneur vers la machine. |
| `docker run` | `-e` | Définit une variable d’environnement. |
| `docker run` | `-v` | Monte un volume (persistance des données). |
| `docker ps` | `-a` | Affiche aussi les conteneurs arrêtés. |
| `docker images` | `-a` | Affiche toutes les images locales. |
| `docker build` | `-t` | Donne un nom/tag à l’image créée. |
| `docker build` | `-f` | Permet de choisir un Dockerfile spécifique. |
| `docker logs` | `-f` | Suit les logs en temps réel. |

### Focus sur `docker run -t`, `-i` et `-it`

* `-t` (**TTY**) : alloue un terminal interactif (sortie plus lisible, invite shell).
* `-i` (**interactive**) : garde l’entrée standard ouverte pour interagir avec le conteneur.
* `-it` : combine les deux, c’est le mode classique pour ouvrir un shell dans un conteneur.

Exemple pratique :

```bash
docker run -it --name ubuntu-test ubuntu:latest bash
```

Quand utiliser `-it` :
* pour tester manuellement une image ;
* pour exécuter des commandes dans un shell (`bash`, `sh`) ;
* pour du debug rapide à l’intérieur du conteneur.

### Aide intégrée (`help`) pour les commandes et leurs flags

```bash
docker --help
docker run --help
docker build --help
docker ps --help
docker logs --help
```

Avec ces commandes, Docker affiche la syntaxe exacte, les options disponibles et des exemples.

### 1\) Savoir où sont stockées les images Docker sur la machine

* Voir le dossier racine Docker :

```bash
docker info --format "{{.DockerRootDir}}"
```

* Sur Linux, c’est souvent : `/var/lib/docker`
* Sur Docker Desktop (Windows/macOS), les données sont gérées dans la VM Docker/WSL2 (pas dans un dossier classique directement manipulable).

### 2\) Chercher les images disponibles en local

```bash
docker images
```

ou

```bash
docker image ls
```

Pour chercher des images sur Docker Hub :

```bash
docker search nginx
```

### 3\) Voir les conteneurs en cours d’exécution

```bash
docker ps
```

Pour voir aussi ceux arrêtés :

```bash
docker ps -a
```

### 4\) Télécharger une image puis l’exécuter

* Télécharger l’image :

```bash
docker pull nginx:latest
```

* Lancer un conteneur à partir de l’image :

```bash
docker run -d --name mon-nginx -p 8080:80 nginx:latest
```

* Vérifier qu’il tourne :

```bash
docker ps
```

### 5\) Créer une image à partir d’une instance de conteneur

1. Identifier le conteneur :

```bash
docker ps -a
```

2. Créer une nouvelle image depuis ce conteneur (commit) :

```bash
docker commit <container\_id\_ou\_nom> mon-image:1.0
```

3. Vérifier que l’image existe :

```bash
docker images
```

4. Ajouter l'image dans le Hub :

```bash
docker push mon-image:1.0
```

### 6\) Créer une image avec un Dockerfile

1. Créer un fichier `Dockerfile` à la racine du projet (exemple Node.js) :

```dockerfile
FROM node:20-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
```

2. Construire l’image depuis le dossier du projet :

```bash
docker build -t mon-app:1.0 .
```

3. Vérifier l’image créée :

```bash
docker images
```

4. Lancer un conteneur depuis cette image :

```bash
docker run -d --name mon-app -p 3000:3000 mon-app:1.0
```
