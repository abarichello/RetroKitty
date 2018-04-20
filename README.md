# RetroKitty
A cute and relaxing mobile game where you hit color-coded balls.

<a href='https://play.google.com/store/apps/details?id=com.barichello.retrokitty&pcampaignid=MKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1'><img alt='Get it on Google Play' src='https://play.google.com/intl/en_us/badges/images/generic/en_badge_web_generic.png' height="64"/></a>

<img src="https://i.imgur.com/boodKWV.png" height="460">&nbsp;&nbsp;<img src="https://i.imgur.com/g6W5Kbe.png" height="460">
<br>

## Rules
Your goal is to hit the colour coded balls represented in your Game HUD.

## Script your own level
The game levels are located in the [`levels`](game/levels) folder, you can script your own levels by editing the existing ones or editing the `lvl_custom.lvl`. Scripting the level is done by following these [simple rules](#contents).

<b>Example level:</b> Shoots all available colours through the UP dispenser every half second, the goal is to hit all of them.
```
# Seconds | Dispenser Number | Color Number | Speed(seconds to reach center)

# Colors: RED, ORANGE, YELLOW, GREEN, CYAN, BLUE, PURPLE, PINK, WHITE = 8, BLACK = 9
# Number: | UP = 0   | DOWN = 1  | LEFT = 2 | RIGHT = 3

# GOAL: Start line with $
$ 0 1 2 3 4 5 6 7

# LEVEL 5 - All colours showcase

1    0 0 5
1.5  0 1 5
2    0 2 5
2.5  0 3 5
3    0 4 5
3.5  0 5 5
4    0 6 5
4.5  0 7 5
```

### Contents
- Seconds: 0 to infinite.
- Dispenser number:
  - 0 - UP
  - 1 - DOWN
  - 2 - LEFT
  - 3 - RIGHT
- Ball color:
  - Color coding is included in the example level.
- Speed: Seconds for the ball to reach the screen center no limit, go crazy (please maintain low due to the nature of human reflexes).
- Use # for comments and $ for the line representing the goal.
- Whitespace is ignored, use it for formatting.
- Don't include a newline at the end of the file.
- Input only numbers.

### Opening the project
- Download any Godot 3.0 version and open the `project.godot` file with the editor.
