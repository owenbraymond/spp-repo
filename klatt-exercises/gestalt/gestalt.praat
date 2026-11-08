Create KlattGrid: "gestalt", 0, 0.82, 3, 0, 0, 4, 0, 0, 0 

#Timing marks
gClosure = 0
gBurst = gClosure + 0.07
eStart = gBurst + 0.044
eEnd = eStart + 0.1
shStart = eEnd
tClosure = shStart + 0.15
tBurst = tClosure + 0.05
aStart = tBurst + 0.05
aEnd = aStart + 0.1
lStart = aEnd
twotClosure = lStart + 0.08
twotBurst = twotClosure + 0.04

# F0 
#assigning a single variable to systematically move f0 for naturalness testing
f0Basis = 150
Add pitch point: 0, f0Basis
Add pitch point: gBurst, f0Basis - 30
Add pitch point: eStart, f0Basis - 30
Add pitch point: tClosure, f0Basis
Add pitch point: aStart, f0Basis + 10
Add pitch point: twotClosure, f0Basis - 45

#Flutter long /al/ voiced section
Add flutter point: lStart - 0.02, 0
Add flutter point: lStart - 0.01, 0.5
Add flutter point: twotClosure - 0.01, 0.5
Add flutter point: twotClosure, 0

#Spectral Measures
Add spectral tilt point: 0, 45
Add spectral tilt point: gClosure, 45
Add spectral tilt point: gBurst - 0.001, 45
Add spectral tilt point: gBurst, 0

Add spectral tilt point: eStart - 0.001, 0
Add spectral tilt point: eStart, 5
Add spectral tilt point: eEnd - 0.001, 5
Add spectral tilt point: eEnd, 0

#---------------STOP CONSONANT /k OR g/----------------

	#--VOICING--
#UNVOICED? Hard to see voicing in my recording
Add voicing amplitude point: gClosure, 50
Add voicing amplitude point: gBurst - 0.001, 80
Add voicing amplitude point: gBurst, 0

	#--FRICATION--

# frication amplitude

Add frication amplitude point: gClosure, 0
Add frication amplitude point: gBurst - 0.001, 0
Add frication amplitude point: gBurst, 90
Add frication amplitude point: eStart, 0

# frication formant 2 
Add frication formant frequency point: 2, gClosure, 2718
Add frication formant bandwidth point: 2, gClosure, 250 
Add frication formant amplitude point: 2, gClosure, 6
Add frication formant amplitude point: 2, gBurst, 0

# frication formant 3 
Add frication formant frequency point: 3, gClosure, 5546
Add frication formant bandwidth point: 3, gClosure, 300
Add frication formant amplitude point: 3, gClosure, 8
Add frication formant amplitude point: 3, gBurst, 0


#---------------VOWEL /I/----------------

# voicing amplitude 
Add voicing amplitude point: eStart -0.01, 0
Add voicing amplitude point: eStart, 90
Add voicing amplitude point: eEnd - 0.01, 90
Add voicing amplitude point: eEnd, 0

# oral formant 1 
Add oral formant bandwidth point: 1, eStart, 60
Add oral formant frequency point: 1, eStart, 493 

# oral formant 2 
Add oral formant bandwidth point: 2, eStart, 90
Add oral formant frequency point: 2, eStart, 2000

# oral formant 3 
Add oral formant bandwidth point: 3, eStart, 200 
Add oral formant frequency point: 3, eStart, 2600

#---------------FRICATIVE /ʃ/----------------

#Voicing amplitude
#UNVOICED

#Frication amplitude
Add frication amplitude point: shStart, 0
Add frication amplitude point: shStart + 0.01, 65
Add frication amplitude point: tClosure - 0.002,65

# frication formant 2 
Add frication formant frequency point: 2, shStart, 2900
Add frication formant bandwidth point: 2, shStart, 250 
Add frication formant amplitude point: 2, shStart, 6

# frication formant 3 
Add frication formant frequency point: 3, shStart, 3300
Add frication formant bandwidth point: 3, shStart, 300
Add frication formant amplitude point: 3, shStart, 8

#4 frication formant 4
Add frication formant frequency point: 4, shStart, 4800
Add frication formant bandwidth point: 4, shStart, 320
Add frication formant amplitude point: 4, shStart, 10


#---------------STOP CONSONANT /t/----------------

	#--NO VOICING--

	#--FRICATION--

#frication amplitude
Add frication amplitude point: tClosure - 0.001, 0
Add frication amplitude point: tBurst - 0.001, 0
Add frication amplitude point: tBurst, 80
Add frication amplitude point: tBurst + 0.01, 80
Add frication amplitude point: aStart, 0

# frication formant 2 
Add frication formant frequency point: 2, tClosure, 2718
Add frication formant bandwidth point: 2, tClosure, 250 
Add frication formant amplitude point: 2, tClosure, 6

# frication formant 3 
Add frication formant frequency point: 3, tClosure, 5546
Add frication formant bandwidth point: 3, tClosure, 300
Add frication formant amplitude point: 3, tClosure, 8

	#--ASPIRATION--
Add aspiration amplitude point: tBurst - 0.001, 0
Add aspiration amplitude point: tBurst, 55
Add aspiration amplitude point: aStart, 0

#---------------VOWEL /ɑ/----------------

# voicing amplitude 
Add voicing amplitude point: aStart - 0.01, 0
Add voicing amplitude point: aStart, 80

# oral formant 1 
Add oral formant bandwidth point: 1, aStart, 130
Add oral formant frequency point: 1, aStart, 893 

# oral formant 2 
Add oral formant bandwidth point: 2, aStart, 70
Add oral formant frequency point: 2, aStart, 1200

# oral formant 3 
Add oral formant bandwidth point: 3, aStart, 160 
Add oral formant frequency point: 3, aStart, 2700


#---------------LATERAL APPROXIMANT /l/----------------

# voicing amplitude 
#KEEP VOICING AMPLITUDE FROM PRECEDING VOWEL

# oral formant 1 
Add oral formant bandwidth point: 1, lStart, 130
Add oral formant frequency point: 1, lStart, 510

# oral formant 2 
Add oral formant bandwidth point: 2, lStart, 70
Add oral formant frequency point: 2, lStart, 900

# oral formant 3 
Add oral formant bandwidth point: 3, lStart, 160 
Add oral formant frequency point: 3, lStart, 2800

#---------------STOP CONSONANT /t/----------------

	#--END VOICING--
Add voicing amplitude point: twotClosure - 0.001, 80
Add voicing amplitude point: twotClosure, 0

	#--FRICATION--

#frication amplitude
Add frication amplitude point: twotClosure - 0.001, 0
Add frication amplitude point: twotBurst - 0.001, 0
Add frication amplitude point: twotBurst, 80
Add frication amplitude point: twotBurst + 0.01, 80
Add frication amplitude point: twotBurst + 0.03, 0

# frication formant 2 
Add frication formant frequency point: 2, twotClosure, 2718
Add frication formant bandwidth point: 2, twotClosure, 250 
Add frication formant amplitude point: 2, twotClosure, 6

# frication formant 3 
Add frication formant frequency point: 3, twotClosure, 5546
Add frication formant bandwidth point: 3, twotClosure, 300
Add frication formant amplitude point: 3, twotClosure, 8


	#--ASPIRATION--
Add aspiration amplitude point: twotBurst - 0.001, 0
Add aspiration amplitude point: twotBurst, 55
Add aspiration amplitude point: twotBurst + 0.15, 0

#Activate these lines when you want to see timestamps of the preset variable time controls 
#################################################
#appendInfoLine: "gClosure: " + string$(gClosure)
#appendInfoLine: "gBurst: " + string$(gBurst)
#appendInfoLine: "eStart: " + string$(eStart)
#appendInfoLine: "eEnd: " + string$(eEnd)
#appendInfoLine: "shStart: " + string$(shStart)
#appendInfoLine: "tClosure: " + string$(tClosure)
#appendInfoLine: "tBurst: " + string$(tBurst)
#appendInfoLine: "aStart: " + string$(aStart)
#appendInfoLine: "lStart: " + string$(lStart)
#appendInfoLine: "twotClosure: " + string$(twotClosure)
#appendInfoLine: "twotBurst: " + string$(twotBurst)
#################################################

#save a little work, no need to click "to sound" in the praat menu
To Sound