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
You can move your charcter with `i, j, k, l`.

## Known bugs
---
* Player can't move on top of top-left corner of house.

## TO-DO list
---
* Add Player spawn point at player House
* Add enemy NPC
* Add combat system
* Add (basic) map of world zone
* Add villages, routes etc to world zone
* Add better world map
* Add storyline

## Program language
---
This game is written in Ruby

## Adding maps
---
Create a `.txt` file, place it in `media/maps/MAP_NUMBER.txt`. The spawn path is
```
OBJ POSX POSY . . .
```
Where `OBJ` stands for


* `H` for HOUSE
* `T` for TREE
* `S` for STONE
* `F` for Friendly NPC, but has different setup. Look `lib/friendperson.rb` for more info.

Hence, for instance, in file `/media/maps/0.txt`
```
T 600 400 . . .
S 500 800 . . .
H 1100 400 . . .
F 1300 620 down 0 1
```
To create a `Tree` in `600, 400`, a `Stone` in `500, 800`, a `House` in `1100, 400` and a `Friendly
NPC` right under the house, at `1300, 620`, looking `:down`, image `0` and speech `1`.

Note that `.` has `NIL` value in other objects.

## Credits
---
* Thanks to Gosu for his awesome graphic library.
* Thanks to Gallantyl U-Seigel for all houses tiles.
* Thanks to https://www.dragonflycave.com/resources/ for sprites.
* Thanks to Chae for trees and mountains
