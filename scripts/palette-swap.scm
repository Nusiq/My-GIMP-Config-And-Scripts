; FUNCTION REGISTRATION
(script-fu-register
    ; METADATA
    ; Function name
    "palette-swap"
    ; Menu label
    "Nusiq: Palette Swap"
    ; Description
    "Replaces the colors in the active image by maping colors from the first palette to the second palette."
    ; Author
    "Nusiq"
    ; Copyright notice
    "Copyright 2024, Nusiq;"
    ; Date created
    "2024-10-17"
    ; Image type that the script works on
    ""
    ; ARGUMENTS
    SF-IMAGE "The image to edit" 1
    SF-PALETTE "The first palette" ""
    SF-PALETTE "The second palette" "")


; FUNCTION DEFINITION
(script-fu-menu-register "palette-swap" "<Image>/Filters/Nusiq")

(define (palette-swap active_image first_palette second_palette)
    (let*
        (
            (width  (car (gimp-image-width active_image)))
            (height (car (gimp-image-height active_image)))
            (active_layer (car (gimp-image-get-active-layer active_image)))
            (new_layer (car (gimp-layer-new-from-drawable active_layer active_image)))

            ; Some global variables that change to restore after the operation
            (old_fg_color (car (gimp-context-get-foreground)))
            (old_red_component (car (gimp-image-get-component-active active_image CHANNEL-RED)))
            (old_green_component (car (gimp-image-get-component-active active_image CHANNEL-GREEN)))
            (old_blue (car (gimp-image-get-component-active active_image CHANNEL-BLUE)))
            (old_alpha_component (car (gimp-image-get-component-active active_image CHANNEL-ALPHA)))
            
            (first_palette_colors (vector->list (cadr (gimp-palette-get-colors first_palette))))
            (second_palette_colors (vector->list (cadr (gimp-palette-get-colors second_palette)))))
        
        ; (gimp-message first_palette)
        ; (gimp-message second_palette)

        ; ADDING NEW LAYER
        ; Add the new_layer above the active_layer
        (gimp-image-insert-layer active_image new_layer -1 -1)

        ; Disable the undo for all of the operations on the layer that will happen.
        (gimp-image-undo-freeze active_image)

        ; Delete everything (full alpha) but keep the colors
        (gimp-image-select-rectangle active_image CHANNEL-OP-REPLACE 0 0 width height)
        (gimp-drawable-edit-clear new_layer)

        ; Enable all the channels for future operations
        (gimp-image-set-component-active active_image CHANNEL-RED TRUE)
        (gimp-image-set-component-active active_image CHANNEL-GREEN TRUE)
        (gimp-image-set-component-active active_image CHANNEL-BLUE TRUE)
        (gimp-image-set-component-active active_image CHANNEL-ALPHA TRUE)

        ; Use the alpha from the original layer (the background)
        (gimp-layer-set-composite-mode new_layer LAYER-COMPOSITE-CLIP-TO-BACKDROP)

        ; CONFIGURING THE SETTINGS FOR SELECTING BY COLOR OPERATION
        (gimp-context-set-antialias FALSE)
        (gimp-context-set-feather FALSE)
        ; Don't sample from different layers
        (gimp-context-set-sample-merged FALSE)
        ; The selection should be based on the composite of the RGB channels
        (gimp-context-set-sample-criterion SELECT-CRITERION-COMPOSITE)
        (gimp-context-set-sample-threshold 0.0)
        (gimp-context-set-sample-transparent FALSE)


        ; CHANGE THE COLORS IN THE NEW LAYER BASED ON THE OLD LAYER
        (mapcar (lambda (old_color new_color)
            (begin
                (gimp-image-select-color
                    active_image
                    CHANNEL-OP-REPLACE ; Replace the current selection
                    active_layer
                    old_color)
                (gimp-context-set-foreground new_color)
                (gimp-edit-bucket-fill
                    new_layer
                    BUCKET-FILL-FG  ; Use foreground color to fill
                    LAYER-MODE-NORMAL
                    100  ; Opacity
                    0  ; Threshold (not used because we have a selection)
                    FALSE  ; Sample merged from all layers
                    0 0)))  ; Coordinates (not used because we have a selection)
            first_palette_colors second_palette_colors)

        ; Restore the original values
        (gimp-context-set-foreground old_fg_color)
        (gimp-image-set-component-active active_image CHANNEL-RED old_red_component)
        (gimp-image-set-component-active active_image CHANNEL-GREEN old_green_component)
        (gimp-image-set-component-active active_image CHANNEL-BLUE old_blue)
        (gimp-image-set-component-active active_image CHANNEL-ALPHA old_alpha_component)

        (gimp-selection-none active_image)

        ; Reenable the undo
        (gimp-image-undo-thaw active_image)))
