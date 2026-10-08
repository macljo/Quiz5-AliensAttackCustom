#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)

(define WIDTH 1265)
(define HEIGHT 730)
(define E-SCENE (empty-scene WIDTH HEIGHT 'blanchedalmond))

(define SCORE (text "SCORE" 25 'dimgray))
(define POINTS(text "0 0 0 0" 20 'dimgray))
(define HI-SCORE (text "HI SCORE" 25 'dimgray))
(define POINTS2 (text "0 0 0 0" 20 'dimgray))
(define HP (text "HP" 25 'dimgray))

(define SMhoodSideLength 9)
(define SMhoodAngle 90)
(define SMhoodMode 'solid)
(define SMhoodColor 'brown)
(define SMhood (isosceles-triangle SMhoodSideLength SMhoodAngle SMhoodMode SMhoodColor))

(define SMheadRadius 5)
(define SMheadMode 'solid)
(define SMheadColor 'navajowhite)
(define SMhead (circle SMheadRadius SMheadMode SMheadColor))

(define SMeyesRadius 1)
(define SMeyesMode 'solid)
(define SMeyesColor 'forestgreen)
(define SMeyes (circle SMeyesRadius SMeyesMode SMeyesColor))

(define life1 (overlay/offset SMhood
                              0 6
                              SMhead))
(define life2 (underlay/offset life1
                              -2 2
                              SMeyes))
(define life (underlay/offset life2
                              2 2
                              SMeyes))


;; Archer

(define hoodSideLength 16)
(define hoodAngle 90)
(define hoodMode 'solid)
(define hoodColor 'brown)
(define hood (isosceles-triangle hoodSideLength hoodAngle hoodMode hoodColor))

(define headRadius 11)
(define headMode 'solid)
(define headColor 'navajowhite)
(define head (circle headRadius headMode headColor))

(define eyesRadius 2)
(define eyesMode 'solid)
(define eyesColor 'forestgreen)
(define eyes (circle eyesRadius eyesMode eyesColor))

(define mouthWidth 7)
(define mouthHeight 2)
(define mouthMode 'solid)
(define mouthColor 'green)
(define mouth (rectangle mouthWidth mouthHeight mouthMode mouthColor))

(define jacketWidth 16)
(define jacketHeight 23)
(define jacketMode 'solid)
(define jacketColor 'brown)
(define jacket (rectangle jacketWidth jacketHeight jacketMode jacketColor))

(define armWidth 6)
(define armHeight 33)
(define armMode 'solid)
(define armColor 'brown)
(define arm (rectangle armWidth armHeight armMode armColor))

(define 2armWidth 6)
(define 2armHeight 33)
(define 2armMode 'solid)
(define 2armColor 'brown)
(define 2arm (rotate 30(rectangle armWidth armHeight armMode armColor)))

(define legWidth 6)
(define legHeight 23)
(define legMode 'solid)
(define legColor 'brown)
(define leg (rectangle legWidth legHeight legMode legColor))


(define silverbeltWidth 4)
(define silverbeltHeight 19)
(define silverbeltMode 'solid)
(define silverbeltColor 'silver)
(define silverbelt (rotate -45(rectangle silverbeltWidth silverbeltHeight silverbeltMode silverbeltColor)))


(define blackbeltWidth 1)
(define blackbeltHeight 5)
(define blackbeltMode 'solid)
(define blackbeltColor 'black)
(define blackbelt (rotate 90(rectangle blackbeltWidth blackbeltHeight blackbeltMode blackbeltColor)))

(define goldplateWidth 4)
(define goldplateHeight 6)
(define goldplateMode 'solid)
(define goldplateColor 'yellow)
(define goldplate (rotate 90(rectangle goldplateWidth goldplateHeight goldplateMode goldplateColor)))

(define blackplateSideLength 2)
(define blackplateMode 'solid)
(define blackplateColor 'black)
(define blackplate (square blackplateSideLength blackplateMode blackplateColor))

;; Bow
(scale 2(crop 0 0 20 10 (circle 10 'outline 'lawngreen)))
(define yarnWidth 2)
(define yarnHeight 40)
(define yarnMode 'solid)
(define yarnColor 'forestgreen)
(define yarn (rotate 90(rectangle yarnWidth yarnHeight yarnMode yarnColor)))

(define Bow (overlay/offset (scale 2(crop 0 0 20 10 (circle 10 'outline 'lawngreen)))
                             0 7
                             yarn))

;; Arrow
(define arrowheadSideLength 9)
(define arrowheadMode 'solid)
(define arrowheadColor 'green)
(define arrowhead (triangle arrowheadSideLength arrowheadMode arrowheadColor))

(define arrowstickWidth 2)
(define arrowstickHeight 16)
(define arrowstickMode 'solid)
(define arrowstickColor 'forestgreen)
(define arrowstick (rectangle arrowstickWidth arrowstickHeight arrowstickMode arrowstickColor))

(define rightfletchingWidth 2)
(define rightfletchingHeight 8)
(define rightfletchingMode 'solid)
(define rightfletchingColor 'darkseagreen)
(define rightfletching (rotate 30(rectangle rightfletchingWidth rightfletchingHeight rightfletchingMode rightfletchingColor)))

(define leftfletchingWidth 2)
(define leftfletchingHeight 8)
(define leftfletchingMode 'solid)
(define leftfletchingColor 'darkseagreen)
(define leftfletching (rotate -30(rectangle leftfletchingWidth leftfletchingHeight leftfletchingMode leftfletchingColor)))

(define arrow1 (overlay/offset arrowhead
                               0 10
                               arrowstick))
(define arrow2 (overlay/offset arrow1
                               3 13
                               rightfletching))
(define Arrow (overlay/offset arrow2
                               -4 10
                               leftfletching))
  


(define archer1 (overlay/offset hood
                                 0 12
                                 head))
(define archer2(underlay/offset archer1
                               -4 2
                               eyes))
(define archer3(underlay/offset archer2
                                5 2
                                eyes))
(define archer4(underlay/offset archer3
                                0.5 8
                                mouth))
(define archer5(overlay/offset archer4
                               0 21
                               jacket))
(define archer6(overlay/offset archer5
                               -10 -14
                               arm))
(define archer7(overlay/offset archer6
                               5 -13
                               2arm))
(define archer8(underlay/offset archer7
                                -1 15
                                silverbelt))
(define archer9(underlay/offset archer8
                                -5 25
                                blackbelt))
(define archer10(underlay/offset archer9
                                 4 25
                                 blackbelt))
(define archer11(underlay/offset archer10
                                 0 25
                                 goldplate))
(define archer12(underlay/offset archer11
                                 0 25
                                 blackplate))
(define archer13(overlay/offset archer12
                                 -4 35
                                 leg))
(define archer14(overlay/offset archer13
                                3 26
                                leg))
(define Archer (underlay/offset archer14
                               -7 -40
                               Bow))

;; PLAY SCREEN
(define play1 (place-image HI-SCORE 640 30 E-SCENE))
(define play2 (place-image SCORE 300 30 play1))
(define play3 (place-image HP 980 30 play2))
(define play4 (place-image POINTS 640 55 play3))
(define play5 (place-image POINTS2 300 55 play4))
(define play6 (place-image life 960 55 play5))
(define play7 (place-image life 980 55 play6))
(define play8 (place-image life 1000 55 play7))
(define Dragond (place-image Archer 630 685 play8))

(define PLAY-SCREEN 'play9)
;; A world->image
(define INIT-WORLD
        PLAY-SCREEN)
;; Purpose: To draw the given world
(define (DRAW-WORLD A-WORLD)
(cond [(eq? A-WORLD PLAY-SCREEN) Dragond]
       [else E-SCENE]))

(define PLAYexpr Dragond)

; string → world
; Purpose: To run the game
(define (run a-name)
    (big-bang INIT-WORLD
              [on-draw DRAW-WORLD]
              [name a-name]))
 












