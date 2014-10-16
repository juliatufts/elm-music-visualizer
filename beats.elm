import Keyboard
 
beats = keepWhen Keyboard.ctrl True Keyboard.ctrl
lastBeat = lift fst (timestamp beats)
display x = flow down x
 
timestamps : Signal [Time]
timestamps = foldp accList [] (lastBeat)
accList : Time -> [Time] -> [Time]
accList new old = if length old >= 7 then insert new old else new :: old
insert new old = new :: take ((length old) - 1) old
 
intervals lst = case lst of
    [] -> []
    _ -> zipWith (-) lst (tail lst)
tempo lst = 60 / ((sum (intervals lst)) / (toFloat (length (intervals lst))) / 1000)
 
main = lift (display) (combine [lift asText timestamps,
       lift (asText << tempo) timestamps])