; FileNameFromPath
; ----------------
; Extracts just the file name (as a string) from the end of a complete path + filename 
;
; Sname  FileNameFromPath  Spath
;
; Initialisation
; --------------
; Sname  --  file name as a string variable
; Spath  --  full path and file name as a string variable

opcode FileNameFromPath,S,S		; Extract a file name (as a string) from a full path (also as a string)
 Ssrc	xin				; Read in the file path string
 icnt	strlen	Ssrc			; Get the length of the file path string
 LOOP:					; Loop back to here when checking for a backslash
 iasc	strchar Ssrc, icnt		; Read ascii value of current letter for checking
 if iasc==92 igoto ESCAPE		; If it is a backslash, escape from loop
 loop_gt	icnt,1,0,LOOP		; Loop back and decrement counter which is also used as an index into the string
 ESCAPE:				; Escape point once the backslash has been found
 Sname	strsub Ssrc, icnt+1, -1		; Create a new string of just the file name
	xout	Sname			; Send it back to the caller instrument
endop
