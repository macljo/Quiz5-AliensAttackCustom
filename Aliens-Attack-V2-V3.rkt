;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Aliens-Attack-V2-V3) (read-case-sensitive #true) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#true constructor repeating-decimal #false #true none #false ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #false)))
(require APS-Aliens-Attack)
(require 2htdp/image)
(require 2htdp/universe)

;; string -> world
;; Purpose: To run the game
(define (run a-name)
  (big-bang INIT-WORLD
            [on-draw draw-world]
            [name a-name]
            [on-key process-key]
            [on-tick process-tick TICK-RATE]
            [stop-when game-over? draw-last-world]))

;; A rocket is an image-x
;; An alien is a posn: (make-posn image-x image-y)
;; An alien-direction is either:
;;    1. 'right
;;    2. 'left
;;    3. 'down
;; A shot is either:
;;    1. NO-SHOT
;;    2. A posn: (make-posn image-x image-y)
;; A key is either:
;;    1. "right"
;;    2. "left"
;;    3. " "
;;    4. Not "right", "left", or " "
;; A world is a structure (make-world rocket alien shot alien-direction)
(define-struct world (rocket alien shot dir))

;; Sample values
(define INIT-ROCKET (/ MAX-CHARS-HORIZONTAL 2))
(define INIT-ALIEN (make-posn (/ MAX-CHARS-HORIZONTAL 2) 0))
(define INIT-DIR 'right)
(define INIT-SHOT NO-SHOT)
(define INIT-WORLD (make-world INIT-ROCKET INIT-ALIEN
                               INIT-SHOT INIT-DIR))

;; world -> image
;; Purpose: Draw the given world in the empty scene
(define (draw-world w)
  (draw-shot (world-shot w)
             (draw-alien
              (world-alien w)
              (draw-rocket (world-rocket w) E-SCENE))))

;; world key -> world
;; Purpose: Process given key to return the next world
(define (process-key w k)
  (cond [(key=? k "right")
         (make-world (move-rckt-right (world-rocket w))
                     (world-alien w)
                     (world-shot w)
                     (world-dir w))]
        [(key=? k "left")
         (make-world (move-rckt-left (world-rocket w))
                     (world-alien w)
                     (world-shot w)
                     (world-dir w))]
        [(key=? k " ")
         (make-world (world-rocket w)
                     (world-alien w)
                     (make-shot (world-shot w) (world-rocket w))
                     (world-dir w))]
        [else w]))

;; Tests for process-key
(check-expect (process-key INIT-WORLD "right")
              (make-world(add1 INIT-ROCKET)
                         INIT-ALIEN
                         INIT-SHOT
                         INIT-DIR))

(check-expect (process-key INIT-WORLD "left")
              (make-world(sub1 INIT-ROCKET)
                         INIT-ALIEN
                         INIT-SHOT
                         INIT-DIR))

(check-expect (process-key INIT-WORLD " ")
              (make-world
               INIT-ROCKET
               INIT-ALIEN
               (make-posn
                (world-rocket INIT-WORLD)
                (sub1 MAX-CHARS-VERTICAL))
               INIT-DIR))

(check-expect (process-key INIT-WORLD " ")
              (make-world
               INIT-ROCKET
               INIT-ALIEN
               INIT-SHOT
               INIT-DIR))

;;alien dir -> alien throws error
;; Purpose: Move given alien in given direction
(define (move-alien an-alien a-dir)
  (cond [(eq? a-dir 'right)
         (make-posn (move-right-image-x (posn-x an-alien))
                    (posn-y an-alien))]
        [(eq? a-dir 'left)
         (make-posn (move-left-image-x (posn-x an-alien))
                    (posn-y an-alien))]
        [else
         (make-posn (posn-x an-alien)
                    (move-down-image-y(posn-y an-alien)))]))
;; Sample expressions for move-alien
(define MALIEN-VAL1-1
  (make-posn (move-right-image-x (posn-x INIT-ALIEN))
             (posn-y INIT-ALIEN)))
(define INIT-ALIEN2 (make-posn 3 MAX-IMG-Y))
(define MALIEN-VAL1-2
(make-posn (move-right-image-x (posn-x INIT-ALIEN2))
           (posn-y INIT-ALIEN2)))
(define MALIEN-VAL2-1
  (make-posn (move-left-image-x (posn-x INIT-ALIEN))
             (posn-y INIT-ALIEN)))
(define MALIEN-VAL2-2
  (make-posn (move-left-image-x (posn-x INIT-ALIEN2))
             (posn-y INIT-ALIEN2)))
(define MALIEN-VAL3-1 (make-posn (posn-x INIT-ALIEN)
                                 (move-down-image-y (posn-y INIT-ALIEN))))
(define MALIEN-VAL3-2
  (make-posn (posn-x (make-posn 1 8))
             (move-down-image-y
              (posn-y (make-posn 1 8)))))
;; Tests using sample computations for move-alien
(check-expect (move-alien INIT-ALIEN 'right) MALIEN-VAL1-1)
(check-expect (move-alien INIT-ALIEN2 'right) MALIEN-VAL1-2)
(check-expect (move-alien INIT-ALIEN 'left) MALIEN-VAL2-1)
(check-expect (move-alien INIT-ALIEN 'left) MALIEN-VAL2-2)
(check-expect (move-alien INIT-ALIEN 'down) MALIEN-VAL1-1)
(check-expect (move-alien (make-posn 1 8) 'down)
              MALIEN-VAL3-2)
;; Tests using sample values for move-alien
(check-expect (move-alien (make-posn MAX-IMG-X 3) 'down)
              (make-posn MAX-IMG-X 4))
(check-expect (move-alien (make-posn MAX-IMG-X 3) 'left)
              (make-posn (sub1 MAX-IMG-X) 3))
(check-expect (move-alien (make-posn 0 5) 'right)
              (make-posn 1 5))
(check-error
 (move-alien INIT-ALIEN2 'down)
 (format "move-down-image-y: Thecharacter at y=1~s cannot move down."
         MAX-IMG-Y))
(check-error
 (move-alien (make-posn 0 5) 'left)
 (format "move-left-image-x: The character at x=~s cannotmove left."
         MIN-IMG-X))
(check-error
 (move-alien (make-posn MAX-IMG-X 14) 'right)
 (format "move-right-image-x: The character at x=~s cannot move right."
          MAX-IMG-X))
(check-error
 (move-alien (make-posn 7 MAX-IMG-Y) 'down)
 (format "move-down-image-y: The character at y=~s cannot move down."
         MAX-IMG-Y))




;; world -> world
;; Purpose: Return world after a clock tick by moving
;;      the given world's alien and updating the given
;;      world's alien-direction for the mover alien
(define (process-tick w)
  (make-world
   (world-rocket w)
   (move-alien (world-alien w) (world-dir w))
   (move-shot-up (world-shot w))
   (new-direction-after-tick
    (move-alien (world-alien w)
                (world-dir w))
    (world-dir w))))

;; Tests for process-tick
(check-expect (process-tick INIT-WORLD)
              (make-world
               (world-rocket INIT-WORLD)
               (make-posn
                (add1 (posn-x (world-alien INIT-WORLD)))
                (posn-y (world-alien INIT-WORLD)))
               (move-shot-up INIT-SHOT)
               (world-dir INIT-WORLD)))

(check-expect (process-tick (make-world
                             2
                             (make-posn 1 11)
                             (make-posn 13 0)
                             'left))
              (make-world 2 (make-posn 0 11) NO-SHOT 'down))

(check-expect (process-tick (make-world
                             9
                             (make-posn 19 1)
                             NO-SHOT
                             'down))
              (make-world 9 (make-posn 19 2) NO-SHOT 'left))

(check-expect (process-tick (make-world
                             9
                             (make-posn 19 1)
                             (make-posn 8 8)
                             'down))
              (make-world 9 (make-posn 19 2) (make-posn 8 7) 'left))

;; alien alien-direction -> alien-direction
;; Purpose: Return alien-direction for given
;;          alien moved in the given
;;          alien-direction
(define (new-direction-after-tick an-alien a-dir)
  (cond
    [(eq? a-dir 'right)
     (new-dir-after-right an-alien)]
    [(eq? a-dir 'left)
     (new-dir-after-left an-alien)]
    [else (new-dir-after-down an-alien)]))

;; Test for new-direction-after-tick
(check-expect
 (new-direction-after-tick INIT-ALIEN 'right)
 'right)

(check-expect
 (new-direction-after-tick INIT-ALIEN 'left)
 'left)

(check-expect
 (new-direction-after-tick (make-posn 19 5) 'right)
 'down)

(check-expect
 (new-direction-after-tick (make-posn 0 3) 'left)
 'down)

(check-expect
 (new-direction-after-tick (make-posn 19 5) 'down)
 'left)

(check-expect
 (new-direction-after-tick (make-posn 0 3) 'down)
 'right)

;; world -> Boolean
;; Purpose: Determine if the game is over
(define (game-over? w)
  (or (alien-reached-earth? (world-alien w))
      (hit? (world-shot w) (world-alien w))))

;; Tests for game-over?
(check-expect (game-over? INIT-WORLD) #f)

(check-expect (game-over? (make-world
                           6 (make-posn 0 (sub1 MAX-CHARS-VERTICAL))
                           (make-posn 17 12) 'right))
              #t)

(check-expect (game-over? (make-world
                           6 (make-posn 0 (sub1 MAX-CHARS-VERTICAL))
                           NO-SHOT 'right))
              #t)

(check-expect (game-over? (make-world
                           12 (make-posn 15 6)
                           (make-posn 15 6) 'right))
              #t)

;; world -> image
;; Purpose: Draw the world when the game is over
(define (draw-last-world w)
  (if (alien-reached-earth? (world-alien w))
      (place-image (text "EARTH IS CONQUERED!" 26 'red)
                   (/ E-SCENE-W 2)
                   (/ E-SCENE-H 4)
                   (draw-world w))
      (place-image (text "YOU WIN!" 26 'darkgreen)
                   (/ E-SCENE-W 2)
                   (/ E-SCENE-H 4)
                   (draw-world w))))