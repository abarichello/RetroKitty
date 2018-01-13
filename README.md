# bat-hit-ball
A prototype 2D game where you need to hit the balls back in the order provided by the game.

## Script your own level
The game levels are located in the [`levels`](game/levels) folder, you can script your own levels by editing the existing ones or editing the `lvl_custom.lvl`. Scripting the level is done by following these simple rules:  
Follow the columns data, input only numbers (other characters like letters and lines that start with # are ignored)

<b>Example level:</b> Shoots balls in a clockwise order every second for 3 series.
```
# Seconds | Dispenser Number | Color Number | Speed

# First dispenser
1  0 1 300
5  0 2 700
9  0 2 700
13 0 2 700

# Second dispenser
3  1 2 300
7  1 2 300
11 1 2 300
14 0 2 700

# Third dispenser
4  2 0 500
8  2 2 300
12 2 2 300
15 2 2 300

# Fourth dispenser
2  3 3 300
6  3 2 300
10 3 2 300
16 0 2 700
```

- Seconds: 0 to infinite
- Dispenser number:
  - 0 - UP
  - 1 - DOWN
  - 2 - LEFT
  - 3 - RIGHT
- Ball color:
  - 0 - BLUE
  - 1 - GREEN
  - 2 - RED
- Speed: no limit, go crazy (please maintain low due to the nature of human reflexes)
 
### Opening the project
- Download any Godot 3.0 version and open the `project.godot` file with the editor.
