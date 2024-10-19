; FUNCTION REGISTRATION
(script-fu-register
    ; METADATA
    ; Function name
    "layers-sprite"
    ; Menu label
    "Nusiq: Layers Sprite"
    ; Description
    "Stacks the layers into a verticle sprite."
    ; Author
    "Nusiq"
    ; Copyright notice
    "Copyright 2024, Nusiq;"
    ; Date created
    "2024-10-13"
    ; Image type that the script works on
    ""
    ; ARGUMENTS
    SF-IMAGE "The image to edit" 1)

; FUNCTION DEFINITION
(script-fu-menu-register "layers-sprite" "<Image>/Filters/Nusiq")


(define (list-index-val-pairs lst)
    (let 
        (
            (index 0)
            (result '())
        )
        (for-each
            (lambda (x)
                (set!
                    result
                    (append result (list (cons index x))))
                (set! index (+ index 1)))
            lst)
        result))

(define (pair->string pair)
    (string-append
        "("
        (number->string (car pair))
        ", "
        (number->string (cdr pair))
        ")"))

(define (layers-sprite active_image)
    (let*
        (
            ; Image (creates new image and saves to new_image)
            (width  (car (gimp-image-width active_image)))
            (frame_height (car (gimp-image-height active_image)))
            (height
                (* 
                    frame_height
                    (car (gimp-image-get-layers active_image))))
            ; The layers of the current image
            ; gimp-image-get-layers returns (NUMER_OF_LAYERS #(layer1 layer2 ...))
            (layers (cadr (gimp-image-get-layers active_image)))
            (layer_idx_val_pairs (list-index-val-pairs (vector->list layers)))
            ; (layersStr 
            ;     (map
            ;         (lambda (x) (number->string x))
            ;         (vector->list layers)))
            ; (layerindexvalstr
            ;     (map
            ;         (lambda (x) (pair->string x))
            ;         (list-index-val-pairs (vector->list layers))))

            (new_image
                (car (gimp-image-new
                    width
                    height
                    RGB)))
            ; Layer for the image
            (new_image_layer
                (car (gimp-layer-new
                    new_image
                    width
                    height
                    RGBA-IMAGE
                    "layer 1"
                    100 ; opacity 0-100
                    LAYER-MODE-NORMAL))))

        ; (for-each gimp-message (map pair->string layer_idx_val_pairs))


        ; The actual body of the function
        (gimp-image-insert-layer new_image new_image_layer 0 0)
        ; (gimp-context-set-background '(0 0 0) )
        ; (gimp-drawable-fill new_image_layer BACKGROUND-FILL)
        (for-each
            (lambda (idx_val)
                (let*
                    ; Variables
                    (
                        (y (* (car idx_val) frame_height)))
                    ; Body
                    ; (gimp-message
                    ;     (string-append (pair->string idx_val)
                    ;     "=>"
                    ;     (number->string y)))
                    (gimp-edit-copy (cdr idx_val))
                    (gimp-image-select-rectangle
                        new_image
                        CHANNEL-OP-REPLACE
                        ; x y width height
                        0 y width frame_height)
                    (gimp-floating-sel-anchor
                        (car (gimp-edit-paste new_image_layer TRUE)))))
            layer_idx_val_pairs)



        ; Modify the imge
        (gimp-display-new new_image)))
