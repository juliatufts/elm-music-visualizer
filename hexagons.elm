import Keyboard
import Mouse
import Window

--colors
pink : Color
pink = rgb 255 20 147

--the largest and smallest radius of each hexagon
maxRad = 100
minRad = 0
bpm = 60
--the distance from the center of a hexagon to an edge
distCentToEdge rad = sqrt(rad^2 - (rad/2)^2)
d = (distCentToEdge maxRad)

floatDivide a b = (toFloat a) / (toFloat b)


{--------------
    Signals
---------------}
-- the radius is controlled by the time signal using a sine mapping
-- (to be scaled to bpm in the future)
calculateRad = lift2 (*) (lift2 (+) 
                                (lift (sin) (lift2 (*) timeSignal
                                                    (constant ((2*pi*bpm)/60))))
                                (constant 1))
                         (constant (maxRad/2))


-- the number of seconds accumulated as a float value
-- which varies the hexagon radius
timeSignal : Signal Float
timeSignal = (lift2 (/) 
                    (lift (inMilliseconds) 
                          (foldp (+) 0 (fps 60))) 
                    (constant 1000))

{--------------
    Display
---------------}
displayHex rad = (ngon 6 rad)
displaySquare length = (ngon 4 (toFloat length))
display rad windowDim = collage (fst windowDim) (snd windowDim)
    [
        (rotate (degrees 45) (filled (black) (displaySquare (fst windowDim)))),
        (filled (red) (displayHex rad)),
        (move (1.5*maxRad, d) (filled (pink) (displayHex rad))),
        (move (-1.5*maxRad, d) (filled (pink) (displayHex rad))),
        (move (0, 2*d) (filled (yellow) (displayHex rad))),
        (move (-1.5*maxRad, -d) (filled (yellow) (displayHex rad))),
        (move (1.5*maxRad, -d) (filled (yellow) (displayHex rad))),
        (move (0, -2*d) (filled (pink) (displayHex rad)))        
    ]


{--------------
      Main
---------------}
main = lift2 display calculateRad Window.dimensions


{----
    Attempt to tile hexagons

import Keyboard
import Mouse
import Window

--colors
pink : Color
pink = rgb 255 20 147

--the largest and smallest radius of each hexagon
maxRad = 100
minRad = 0
--the distance from the center of a hexagon to an edge
distCentToEdge rad = sqrt(rad^2 - (rad/2)^2)
d = (distCentToEdge maxRad)

displayHex rad = (ngon 6 rad)
displaySquare length = (ngon 4 (toFloat length))
display rad windowDim = collage (fst windowDim) (snd windowDim)
    [
        (makeHexColumn rad)   
    ]

hexArray rad = [(filled (red) (displayHex rad))
         ,(move (0, 2*(distCentToEdge rad))
                (filled (yellow) (displayHex rad)))
         ,(move (0, -2*(distCentToEdge rad))
                (filled (yellow) (displayHex rad)))
         ]

-- construct this column recursively!
hexColumn rad height yfactor =
  case (height <= 0) -> (filled (red) (displayHex rad))
       _             -> (move (0, yfactor*(distCentToEdge rad))
                (filled (yellow) (displayHex rad)))
         
-- returns an array of squares
makeSquareCollage width = 

main = lift2 display (constant maxRad) Window.dimensions
--main = lift asText calculateRad



--}

{--
    this works
import Keyboard
import Mouse
import Window
import Array

squareSize = 10

squareIterator xdim = Array.initialize (truncate (xdim / squareSize) + 1) identity
scaledArray dim = map (\n -> n - (truncate (dim / 2))) 
                (map (\n -> n * squareSize) (Array.toList (squareIterator dim)))

makeSquare x = (move ((toFloat x), 0) 
                  (filled red (square 9)))
                  
squaresArray dim = map makeSquare (scaledArray dim)

display dim = collage dim dim
    (squaresArray (toFloat dim))

main = lift display Window.width


{--
multBy2 x = 10*x
scaledArray = map multBy2 (Array.toList array)

makeSquare pos = (move ((toFloat pos), 0) 
                  (filled red (square 9)))
squaresArray = map makeSquare scaledArray

display shapeArray = collage 200 200
    shapeArray
    

main = display (move (-100, 0)((filled black (square 10))) :: squaresArray)
--}
--}