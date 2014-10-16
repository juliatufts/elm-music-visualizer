import Keyboard
import Mouse
import Window
import Array
import Time

noiseArray width amp = (posy width amp (pi/(toFloat width)))
posx width = map (toFloat) (map (\n -> n - width) (Array.toList <|
                      Array.initialize (2*width) identity))
                      
posy width amp phi = map (\n -> amp*sin(n*phi*2)) (posx width)
points w amp = zip (posx w) (zipWith (+) (posy w amp 0.2) (noiseArray w amp))

line w amp = traced (solid black) (path (points w amp))

display w amp = collage w 400
  [
    line w (60*sin((toFloat amp)/50))
  ]
  
main = lift2 display Window.width (count (every millisecond))