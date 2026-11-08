#---------------SETUP----------------

Create KlattGrid: "sa2", 0, 1, 3, 0, 0, 3, 0, 0, 0 

# F0 
Add pitch point: 0, 120

vowelStart = 0.35


#---------------FRICATIVE /s/----------------

#Frication
Add frication amplitude point: 0, 0
Add frication amplitude point: 0.05, 50
Add frication amplitude point: 0.09, 60
Add frication amplitude point: vowelStart - 0.05, 60
Add frication amplitude point: vowelStart, 0 

# frication formant 1 
Add frication formant bandwidth point: 1, 0, 600 
Add frication formant amplitude point: 1, 0, 5
Add frication formant amplitude point: 1, vowelStart, 0

# frication formant 2 
Add frication formant bandwidth point: 2, 0, 300 
Add frication formant amplitude point: 2, 0, 8
Add frication formant amplitude point: 2, vowelStart, 0

# frication formant 3 
Add frication formant bandwidth point: 3, 0, 500 
Add frication formant amplitude point: 3, 0, 10
Add frication formant amplitude point: 3, vowelStart, 0


#---------------VOWEL /a/----------------

# voicing amplitude 
Add voicing amplitude point: 0, 0
Add voicing amplitude point: vowelStart, 80

# oral formant 1 
Add oral formant bandwidth point: 1, 0, 250
Add oral formant bandwidth point: 1, vowelStart, 60  
Add oral formant frequency point: 1, 0, 800 
# oral formant 2 
Add oral formant bandwidth point: 2, 0, 70
Add oral formant frequency point: 2, 0, 1100 
# oral formant 3 
Add oral formant bandwidth point: 3, 0, 100 
Add oral formant frequency point: 3, 0, 2500