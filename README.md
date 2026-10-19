# Snake Game — LÖVE2D

## Project Description

This project is a classic Snake game developed using **Lua** and the **LÖVE2D framework**.

The player controls a snake, collects food to increase the score, and tries to avoid colliding with the snake's own body.

## Technologies Used

- **Programming Language:** Lua
- **Game Framework:** LÖVE2D
- **Code Editor:** Visual Studio Code

## Game Features

- Snake movement using the arrow keys or WASD keys.
- Random food generation.
- Snake growth after eating food.
- Score tracking.
- Game Over when the snake collides with its own body.
- Restart option after Game Over.
- Increasing snake speed after eating food.
- Wrap-around movement at screen boundaries.
- Sound effect when eating food.
- Pause and resume functionality.
- High Score saving and loading.

## Controls

| Key | Action |
|---|---|
| ↑ / W | Move Up |
| ↓ / S | Move Down |
| ← / A | Move Left |
| → / D | Move Right |
| P | Pause / Resume |
| Space / Enter | Restart after Game Over |
| Esc | Exit Game |

## How to Run the Game

1. Install LÖVE2D from https://love2d.org.
2. Open the project folder in Visual Studio Code.
3. Make sure `main.lua` and `eat.wav` are in the same folder.
4. Open the terminal inside the project folder.
5. Run the following command:

   `love .`

## Project Files

```text
snake/
├── main.lua
├── eat.wav
└── README.md
```

- **main.lua:** Contains the game logic, controls, rendering, scoring, and collision detection.
- **eat.wav:** Sound effect played when the snake eats food.
- **README.md:** Project documentation and instructions.

## High Score

The game automatically saves the highest score using `love.filesystem.write()` and loads it using `love.filesystem.read()`.

The High Score remains saved even after closing and reopening the game.

## Game Rules

1. Control the snake using the keyboard.
2. Eat the red food to increase the score and snake length.
3. The snake moves faster after eating food.
4. Crossing the screen boundary moves the snake to the opposite side.
5. Avoid colliding with the snake's own body.
6. Press Space or Enter to restart after Game Over.

## Conclusion

This project demonstrates basic game development concepts using Lua and LÖVE2D, including game loops, keyboard input, collision detection, sound effects, and file handling.