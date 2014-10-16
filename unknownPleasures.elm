import Keyboard
import Mouse
import Window
import Array
import Time


noiseArray width amp = (posy width amp (pi/(toFloat width)))

posx width = map (toFloat) (map (\n -> n - width) (Array.toList <|
                      Array.initialize (2*width) identity))
                      
posy width amp phi = map (\n -> amp*sin(n*phi*2)) (posx width)

points w amp = zip (zipWith (-) (posx w) (noiseArray w (amp))) 
                    (zipWith (+) (posy w amp 0.2) (noiseArray w (2*amp)))

line w amp = traced (solid white) (path (points w amp))

display dim amp = collage (fst dim) (snd dim)
  [
    filled black (rect (toFloat (fst dim)) (toFloat (snd dim))),
    line (fst dim) (60*sin((toFloat amp)/50))
  ]
  
main = lift2 display Window.dimensions (count (every millisecond))