import Keyboard
import Mouse
import Window
import Array

squareSize = 50

squareIterator xdim = Array.initialize (truncate (xdim / squareSize) + 2) identity
scaledArray dim = map (\n -> n - (truncate (dim / 2))) 
                  (map (\n -> n * squareSize) (Array.toList (squareIterator dim)))

makeSquare pos = move (toFloat (fst pos), toFloat (snd pos))
                 (filled red (square (squareSize - 2)))
                  


outerJoin lst1 lst2 = (\m -> (\n -> (,) n m) `map` lst1) `concatMap` lst2

squarePositions width height = outerJoin (scaledArray width) (scaledArray height)

squaresArray dimx dimy = map makeSquare (squarePositions dimx dimy)

display dimx dimy = collage dimx dimy
    (squaresArray (toFloat dimx) (toFloat dimy))

main = lift2 display Window.width Window.height