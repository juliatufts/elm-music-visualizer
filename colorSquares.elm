import Window
import Array
import Time

squareSize = 100

makeGradient h1 h2 =
  radial (0,0) 0 (0,0) 90
    [
      ( 0,   hsl (degrees h1)  1 0.5),
      ( 0.7, hsl (degrees h2) 1 0.5)
    ]
    
lesquare x y d =
  move ((toFloat x), (toFloat y)) <|
  rotate (degrees (toFloat d)) <|
  gradient (makeGradient (toFloat d) (toFloat (d + 60))) <| 
  square squareSize
 
squareIterator xdim = Array.initialize (truncate (xdim / squareSize) + 2) identity
scaledArray dim = map (\n -> n - (truncate (dim / 2))) 
                  (map (\n -> n * squareSize) (Array.toList (squareIterator dim)))

outerJoin lst1 lst2 = (\m -> (\n -> (,) n m) `map` lst1) `concatMap` lst2

squarePositions width height = outerJoin (scaledArray width) (scaledArray height)

display width height x = collage width height
  (map (\n -> n x) 
    (map (\n -> lesquare (fst n) (snd n)) 
         (squarePositions (toFloat width) (toFloat height))))

main = lift3 display Window.width Window.height (count (every millisecond))

--main = collage 400 400 (map (\n -> n 4) (map (\n -> lesquare (fst n) (snd n)) (squarePositions (toFloat 100) (toFloat 100))))


{--
Hexagons

import Keyboard
import Mouse
import Window
import Array
import Time

squareSize = 100

makeGradient h1 h2 =
  radial (0,0) 0 (0,0) 90
    [
      ( 0,   hsl (degrees h1)  1 0.5),
      ( 0.7, hsl (degrees h2) 1 0.5)
    ]
    
lesquare x y d =
  move ((toFloat x), (toFloat y)) <|
  rotate (degrees (toFloat d)) <|
  gradient (makeGradient (toFloat d) (toFloat (d + 60))) <| 
  ngon 6 (40 + (10 * (1 + (sin ((toFloat d)*0.05)))))
 
squareIterator xdim = Array.initialize (truncate (xdim / squareSize) + 2) identity
scaledArray dim = map (\n -> n - (truncate (dim / 2))) 
                  (map (\n -> n * squareSize) (Array.toList (squareIterator dim)))

outerJoin lst1 lst2 = (\m -> (\n -> (,) n m) `map` lst1) `concatMap` lst2

squarePositions width height = outerJoin (scaledArray width) (scaledArray height)

display width height x = collage width height
  (map (\n -> n x) 
    (map (\n -> lesquare (fst n) (snd n)) 
         (squarePositions (toFloat width) (toFloat height))))

--main = lift3 display Window.width Window.height (count (every millisecond))

--main = collage 400 400 (map (\n -> n 4) (map (\n -> lesquare (fst n) (snd n)) (squarePositions (toFloat 100) (toFloat 100))))

--}