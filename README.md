## Overview

The project was to make a board generator for Catan. The game of Catan starts with a different board every time. Making fair boards that are random can be a little tricky so we made an app to help out.

## Team Members

My brother and I wrote the app. All the commits are done by him because I did not have a Mac at the time, so I wrote all my code on his computer. My brother wrote all the logic for rendering and drawing the board. I wrote all the logic for generating a fair and random board.

## Challenges

The interesting challenge is how to make the board evenly distributed, so that not too many of the same resource types are grouped together but the board is still random. Additionally, all fair boards must have red numbers not touching. In order to do this I generate a "perfect" board, and then perform two random swaps. By perfect I mean none of the same two resource types touch each other, and no red numbers touch each other. This is done via recursive backtracking (while shuffling throughout to keep it random). Then I perform two swaps of tiles so that some random clustering is possible.

## Learning

Through this experience I learned Swift, how to write an iOS app and I solved an interesting algorithmic problem.

