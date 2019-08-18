## Installing... On Arch
---
```
# Installs needed packages for Ruby and gosu
sudo pacman -S openal pango sdl2 sdl2_ttf libsndfile pkg-config mpg123

# Installs Ruby programming language
sudo pacman -S ruby

# Installs Gosu graphic library
gem install gosu
```

##Installing... On other distros
---
```
while OS != ArchLinux
	OS.uninstall
	OS.install("ARCH")
end
```

## Starting the game
---
In the game main directory, run `ruby app.rb`

Welcome to my world!

## Playing
---
You can move your charcter with `i, j, k, l`. You can talk with NPCs
just by facing them.

## Known bugs
---
* Player can't move on top of top-left corner of house.

## TO-DO list
---
* Add wild pokemons
* Add combat system
* Add Player spawn point at player House
* Add enemy NPC
* Add villages, routes etc to world zone
* Add better world map
* Add storyline

## Program language
---
This game is written in Ruby

## Adding a map
---
Create a `.txt` file, place it in `media/maps/MAP_NUMBER.txt`. Then add NPCs
speech into an other `.txt` file in `media/trainers/fnpc/speech_zone/MAP_NUMBER.txt`.
Remember to replace `MAP_NUMBER` with the position of local map. For instance,
to create a local map in `4,2` the files would be

```
media/maps/42.txt
media/trainers/fnpc/speech_zone/42.txt
```

## Adding objects to maps
---
The syntax is
```
OBJ POSX POSY . . .
```
Where `OBJ` stands for


* `H` for HOUSE
* `T` for TREE
* `S` for STONE
* `F` for Friendly NPC, but has different setup. Look `lib/friendperson.rb` for more info.

Hence, for instance, in file `/media/maps/00.txt`
```
T 600 400 . . .
S 500 800 . . .
H 1100 400 . . .
F 1300 620 down 0 1
```
To create a `Tree` in `600, 400`, a `Stone` in `500, 800`, a `House` in `1100, 400` and a `Friendly
NPC` right under the house, at `1300, 620`, looking `:down`, image `0` and speech `1`.

Note that `.` has `NIL` value in other objects.

## Adding speech to NPCs
The syntax is

```
---
NPC_SPEECH_1
---
NPC_SPEECH_2
---
NPC_SPEECH_3
---
```

Note that the file starts and ends with `---`. To access a specific speech, start from 1
and finish to last speech.

## Credits
---
* Thanks to Gosu for his awesome graphic library.
* Thanks to Gallantyl U-Seigel for all houses tiles.
* Thanks to Chae for trees and mountains
* Thanks to https://www.dragonflycave.com/resources/ for sprites.
