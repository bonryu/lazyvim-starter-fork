;extends

; (
; (comment) @content1
; (#match? @content1 "^\\# ?\\%\\%") 
; ) @class.inner

(
(comment) @cell.boundary
(#match? @cell.boundary "^\\# ?\\%\\%")
) @code_cell.inner
