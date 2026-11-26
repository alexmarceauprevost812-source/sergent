# SERGENT — l'IA autonome d'Alex

IA locale qui tourne sur ton PC avec Ollama (modèle `coder30` par défaut).
Elle **cherche sur internet**, **lit des pages**, **écrit et modifie du code**, **lance des commandes**
et **se corrige toute seule** : elle lance son code, lit l'erreur, corrige, relance.

## Installation (Windows 11)
1. Décompresse le dossier `sergent` où tu veux (ex. `C:\Users\Alex\sergent`).
2. Double-clique sur **installer.cmd**.
3. Ouvre un nouveau terminal et tape : `sergent`

Il faut Python 3.10+ et Ollama, avec ton modèle `coder30` déjà importé.

## Utilisation
```
sergent                                   (mode interactif)
sergent "fais-moi un jeu de serpent en Python"   (mission directe)
```
Dans Sergent :
- `/aide` : les commandes
- `/nouveau` : nouvelle conversation
- `/dossier C:\projets\mon-jeu` : travailler dans un autre dossier
- `/modele caporal` : changer de cerveau
- `/confiance 15` : les commandes sensibles passent sans demander pendant 15 min
- `/maj` : installer la dernière version de Sergent
- `/panneau` : ouvrir le panneau en direct dans le navigateur
- `/rea inspect-pe-imports "C:\chemin\app.exe"` : lancer REA directement (`/rea` seul = la liste des commandes)
- `/github` : voir ton compte GitHub et tes dépôts
- `/publier mon message` : envoyer les changements de Sergent lui-même sur ton GitHub
- `Ctrl+C` : arrêter la mission en cours

## Mises à jour
Au démarrage, Sergent regarde sur GitHub (`alexmarceauprevost812-source/sergent`) s'il existe une
version plus récente et te le dit. Tape `/maj` dans Sergent, ou `sergent --maj` dans un terminal.
- Dossier cloné avec git : fait un `git pull` (refuse si tu as des changements pas commités).
- Dossier installé depuis le ZIP : télécharge les nouveaux fichiers, garde l'ancienne version
  dans `ancienne-version\`, et ne touche **jamais** à ton `config.json`.
Pour ne plus vérifier au démarrage : `"verifier_maj": false` dans `config.json`.

## Rétro-ingénierie (REA)
Si le moteur REA est installé (`npm install -g rea-agents`), Sergent peut s'en servir pour analyser
des programmes déjà installés (.exe, .dll, apps Electron, APK…). Les analyses en lecture seule
passent toutes seules ; tout ce qui lance, capture ou modifie quelque chose te demande d'abord.
Les résultats complets sont sauvés dans `rea-resultats\`.

## Panneau en direct
Tape `/panneau` : une page s'ouvre dans ton navigateur (seulement sur ton PC, `http://127.0.0.1:8765/`).
- Chaque étape (commande, fichier écrit, correction, résultat) est un **panneau fermé** : clique pour l'ouvrir.
- « Sergent écrit… » montre le texte et le code **pendant** que le modèle l'écrit.
- Le texte de Sergent est en bleu ciel, le code est coloré comme dans VS Code (thème Dark+).
  Les couleurs du panneau viennent d'internet (highlight.js) ; sans internet, le code reste lisible en blanc.
- Une correction montre l'**avant** (rouge) et l'**après** (vert).
Pour l'ouvrir tout seul au démarrage : `"panneau_auto": true` dans `config.json`.

## GitHub
Sergent utilise le GitHub CLI (`gh`, connecté avec `gh auth login`). Il peut :
publier un projet (nouveau dépôt **privé** par défaut), lister et cloner tes dépôts,
lire/créer des issues, ouvrir des pull requests. Il te demande **toujours** avant d'envoyer quelque chose.
Il n'envoie jamais `.env`, clés `.pem`/`.key`, etc. : ils sont ajoutés au `.gitignore`.

## Animation
Au démarrage, SERGENT tombe du ciel lettre par lettre (Ctrl+C pour passer).
Pour l'enlever : `"animation": false` dans `config.json`.

## Sécurité
- Par défaut, elle travaille seulement dans `%USERPROFILE%\sergent-projets`.
  Pour lui donner tout le PC : `"acces_tout_le_pc": true` dans `config.json`.
- Supprimer, déplacer, `git push`, arrêter un programme : elle te demande d'abord.
- Formater un disque, diskpart, `git push --force` : elle demande **toujours**, même en mode confiance.

## Réglages (`config.json`)
| Clé | Rôle |
|---|---|
| `modele` | modèle Ollama (coder30, caporal, soldat…) |
| `num_ctx` | mémoire de travail du modèle (16384 ; baisse à 8192 si c'est trop lent) |
| `max_etapes` | nombre max d'actions par mission |
| `timeout_commande` | secondes max par commande |
