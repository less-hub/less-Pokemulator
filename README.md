# Table of contents

- [Uhm...Well...Just... Just why?](#uhmwelljust-just-why)
- [Installing... On Arch](#installing-on-arch)
- [Installing... On other distros](#installing-on-other-distros)
- [Playing](#playing)
- [TO-DO list](#to-do-list)
- [Adding a map](#adding-a-map)
- [Adding objects to maps](#adding-objects-to-maps)
- [Adding speech to NPCs](#adding-speech-to-npcs)
- [Credits](#credits)

## Uhm...Well...Just... Just why?

Because i wanted to create a game with ruby and a graphic library. So, how could
I choose a different game then the one we all love?!

## Installing... On Arch
```
# Installs needed packages for Ruby and gosu
sudo pacman -S openal pango sdl2 sdl2_ttf libsndfile pkg-config mpg123

# Installs Ruby programming language
sudo pacman -S ruby

# Installs Gosu graphic library
gem install gosu
```

## Installing... On other distros

* Install Ruby and Gosu library dependecies
* Install Ruby
* Install Gosu

## Playing
You can move your charcter with `i, j, k, l`. You can talk with NPCs
just by facing them.

If you just want to play, you can stop reading and `ruby app.rb` !

Welcome to my world!

If you are interested to this repo, you should keep reading!

## TO-DO list
* Add pokemons LVL, HP, ATK, DEF
* Add combat system
* Add Player spawn point at player House
* Add villages, routes etc to world zone
* Add enemy NPC
* Add better world map
* Add storyline

## Adding a map
Create a `.txt` file, place it in `media/maps/MAP_NUMBER.txt`. Then add NPCs
speech into an other `.txt` file in `media/maps/MAP_NUMBERspeech.txt`.
Remember to replace `MAP_NUMBER` with the position of local map. For instance,
to create a local map in `4,2` the files would be

```
media/maps/42.txt
media/maps/42speech.txt
```

## Adding objects to maps
The syntax is
```
OBJ POSX POSY . . .
```
Where `OBJ` stands for


* `H` for HOUSE
* `T` for TREE
* `S` for STONE
* `L` for LAKE
* `P` for POKEMON
* `F` for Friendly NPC

Hence, for instance, in file `/media/maps/00.txt`
```
T 600 400 . . . .
S 500 800 . . . .
H 1100 400 . . . .
L 2000 500 10 10 . .
P 300 100 1 . .
F 1300 620 down 0 loremipsum 0
```
To create:

* `Tree` at `600, 400`
* `Stone` at `500, 800`
* `House` at `1100, 400`
* `Lake` at `2000, 500` with x size of `10` and y size of `10`
* `Pokemon` at `300, 100` with pokedex number `1`
* `FriendlyNPC` at `1300, 620`, looking `:down`, image `0`, named `Loremipsum` and speech `0`.

Note that `.` has `NIL` value in other objects.

## Adding speech to NPCs
The syntax is

```
NAME
NPC_SPEECH_1

NAME
NPC_SPEECH_2
NPC_SPEECH_2

NAME
NPC_SPEECH_3
NPC_SPEECH_3
```

Note that the speech start with `NAME` the double `\n` works as separator. To access a specific speech, start from 0
and finish to `speech - 1`.

## Credits
* Thanks to Gosu for his awesome graphic library.
* Thanks to Gallantyl U-Seigel for all houses tiles.
* Thanks to Chae for trees and mountains
* Thanks to [PokEncyclopedia](https://www.pokencyclopedia.info/en/index.php?id=sprites/overworlds) for sprites.
