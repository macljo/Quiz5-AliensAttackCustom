;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |aliens attack contribution|) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp")) #f)))
(require 2htdp/image)
(require APS-Aliens-Attack)
(require 2htdp/universe)
;; a slope is a structure with two whole, real number inputs
(define-struct slope (rise run))

(define ticksTillPositionReached 5 )
(define sampCalcSlope1 (make-slope (round (/ (- 15 5) ticksTillPositionReached ) ) (round (/ (- 5 3) ticksTillPositionReached ) )))
(define sampCalcSlope2 (make-slope (round (/ (- 20 10) ticksTillPositionReached )) (round (/ (- 10 2) ticksTillPositionReached ) )))

;;candidates for abstraction, x1 y1 x2 y2

(define (calculateSlope x1 y1 x2 y2) (make-slope (round (/ (- y2 y1)  ticksTillPositionReached ) ) (round (/ (- x2 x1) ticksTillPositionReached ) )))
  (check-expect (calculateSlope 20 10 5 2) (make-slope -2 -3)) 





; a fireball is a structure with a slope and a posn

(define-struct fireball ( slope posn))
;;I would like to be able to move this fireball


;;samples for moving fireballs
(define sampFire1 (make-fireball (make-slope 2 3) (make-posn 2 19)))
(define sampFire2 (make-fireball (make-slope 10 5) (make-posn 17 19)))

(define sampMoveFireball1
  (make-fireball
  (make-slope (fireball-slope sampFire1) (fireball-slope sampFire1))
  (make-posn  (+ (posn-x (fireball-posn sampFire1)) (slope-run (fireball-slope sampFire1)))
              (+ (posn-y (fireball-posn sampFire1)) (slope-rise (fireball-slope sampFire1))
              ))))

(define sampMoveFireball2
  (make-fireball
  (make-slope (fireball-slope sampFire2) (fireball-slope sampFire2))
  (make-posn  (+ (posn-x (fireball-posn sampFire2)) (slope-run (fireball-slope sampFire2)))
              (+ (posn-y (fireball-posn sampFire2)) (slope-rise (fireball-slope sampFire2))
              ))))

;;abstract the fireball
;;takes in a fireball and calculates a new one at a different spot
;; fireball -> fireball
(define (moveFireball fire)
  (make-fireball
  (make-slope (fireball-slope fire) (fireball-slope fire))
  (make-posn  (+ (posn-x (fireball-posn fire)) (slope-run (fireball-slope fire)))
              (+ (posn-y (fireball-posn fire)) (slope-rise (fireball-slope fire))
              ))))

;;can someone else please write tests for this I dont want to.




;a dragon is a structure with a posn, real number, and symbol ('left or 'right)
(define-struct dragon (posn hp dir))

(define sampDragon1 (make-dragon (make-posn 18 19) 10 'right))
(define sampDragon2 (make-dragon (make-posn 12 19) 5 'right))

(if (= (+ (posn-y (fireball-posn sampFire1)) 15) (- (posn-y (dragon-posn sampDragon1)) 15 ))
    #true
    #false)

(if (= (+ (posn-y (fireball-posn sampFire2)) 15) (- (posn-y (dragon-posn sampDragon2)) 15 ))
    #true
    #false)

;;abstract fireball and dragon
    
;;purpose return true if the fireball hit the dragon, false otherwise
;;fireball, dragon -> boolean
(define (hitDragon? fire dragon)
  (if (= (+ (posn-y (fireball-posn fire)) 15) (- (posn-y (dragon-posn dragon)) 15 ))
    #true
    #false ))



 ;;samples for lower hp
(if (hitDragon? sampFire1 sampDragon1) (make-dragon
                                  (make-posn (posn-x (dragon-posn sampDragon1))
                                             
                                            (posn-y (dragon-posn sampDragon1))
                                             ) (sub1 (dragon-hp sampDragon1)) 'right) sampDragon1)

    


;represents a fireball that doesn't exist
(define noFireball 'noFreball)



(define dragonImg (overlay/offset (circle 5  "solid" "yellow")
                 -10 0
                 (overlay/offset (circle 5  "solid" "yellow")
                 10 0
               (rectangle 30 30 'solid 'purple) )))
                   