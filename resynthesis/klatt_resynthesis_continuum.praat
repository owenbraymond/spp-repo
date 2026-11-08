# klatt_resynthesis_continuum.praat
#
# Automatic Klatt copy-resynthesis from a TextGrid-annotated recording, with a
# factorial F0 x F1 continuum for a lexical stress cue-weighting experiment.
#
# For every .TextGrid (+ matching .wav) in input_directory:
#   1. Track formants (Burg), intensity and F0 from the natural recording.
#   2. Classify each segment (tier 1) as vocalic / aspirated / fricative / stop /
#      affricate and step through it every 5 ms, writing the measured values
#      into the matching KlattGrid tiers (oral vs frication branch, voicing vs
#      aspiration vs frication sources).
#   3. Scale F0 reciprocally across syllables (tier 2, labels s1/s2):
#      s1 * (1 + k), s2 * (1 - k), and scale F1 in s1 only, so each grid cell
#      trades stress cues between the two syllables.
#   4. Write one file per cell: <word>_f0_<i>_f1_<j>.mp3
#
# Defaults: 9 x 9 steps of 3.5% each (range +/-14% around the natural value).
# Relative paths resolve from this script's folder.
# Author: Owen Raymond, University of Edinburgh (Speech Production and Perception, 2026)

form Information
	comment Directory path of input files:
	text input_directory ../experiment/stimuli/basis/
	comment Directory path to output files:
	text output_directory ../experiment/stimuli/continuum/
	comment Target Tier:
	positive segment_reference_tier 1
	positive syl_reference_tier 2
	comment Continuum Manipulations:
	positive f0steps 9
	positive f1steps 9
	positive f0steplength 0.035
	positive f1steplength 0.035
endform

vowels$ = "i ɪ e ɛ æ ɑ ɒ ɔ ʊ u ʌ ə ɜ aɪ aʊ ɔɪ eɪ oʊ b"

sonorants$ = "m n ŋ w j r l"

fricatives_vl$ = "s ʃ f θ h"

fricatives_vd$ = "z ʒ v ð"

stops$ = "p t k d g"

affricates$ = "tʃ dʒ ʤ"

h$ = "h"

fricatives$ = fricatives_vl$ + " " + fricatives_vd$

Create Strings as file list: "fileList", input_directory$ + "*.TextGrid"
numberOfFiles = Get number of strings


for f0step from 1 to f0steps
for f1step from 1 to f1steps
for iFile from 1 to numberOfFiles
	selectObject: "Strings fileList"
	fileName$ = Get string: iFile

	textGridFileName$ = input_directory$ + fileName$
	Read from file: textGridFileName$
	objectName$ = selected$ ("TextGrid", 1)

	wavFileName$ = input_directory$ + objectName$ + ".wav"
	Read from file: wavFileName$
	soundID = selected("Sound")
	dur = Get total duration

	# Creating the Klatt grid for this word, using the filename and continuum details
	appendInfoLine: fileName$ + "_f0_" + string$(f0step) + "_f1_" + string$(f1step)
	klattName$ = "" + objectName$ + "_f0_" + string$(f0step) + "_f1_" + string$(f1step)
	Create KlattGrid: klattName$, 0, dur, 3, 0, 0, 4, 0, 0, 0
	klattID = selected("KlattGrid")

	selectObject: soundID
	To Formant (burg): 0, 5, 5500, 0.025, 50
	formantID = selected("Formant")

	selectObject: soundID
	To Intensity: 100, 0, "yes"

	selectObject: soundID
	To Pitch (filtered autocorrelation): 0, 50, 800, 15, "no", 0.03, 0.09, 0.5, 0.055, 0.35, 0.14
	pitchID = selected("Pitch")

	selectObject: "TextGrid " + objectName$
	numberOfIntervals = Get number of intervals: segment_reference_tier
	for iInterval from 1 to numberOfIntervals
		selectObject: "TextGrid " + objectName$
		sTime = Get start point: segment_reference_tier, iInterval
		eTime = Get end point: segment_reference_tier, iInterval
		duration = eTime-sTime

		label$ = Get label of interval: segment_reference_tier, iInterval 

		if index(vowels$, label$) > 0 or index(sonorants$, label$) > 0
		    mode$ = "vocalic"
		elsif index(h$, label$) > 0
		    mode$ = "aspirated"
		elsif index(fricatives$, label$) > 0
		    mode$ = "fricative"
		elsif index(stops$, label$) > 0
		    mode$ = "stop"
		elsif index(affricates$, label$) > 0
		    mode$ = "mixed"
		else
		    mode$ = "silent"
		endif

		appendInfoLine: "#We are in the " + label$

		f0_mod = ((ceiling(f0steps / 2) - f0step) * f0steplength)
		f1_mod = ((ceiling(f1steps / 2) - f1step) * f1steplength)

		# Only calculate for S1 since that's what you're manipulating
		if label$ == "ʌ" or label$ == "ɛ"
		    selectObject: formantID
		    # Get the mean F1 for the entire S1 duration
		    mean_f1_orig = Get mean: 1, sTime, eTime, "hertz"
		    target_f1_hz = mean_f1_orig * (1 + f1_mod)
		    appendInfoLine: "Loop F1 Step: " + string$(f1step) + " | S1 Mean F1: " + fixed$(target_f1_hz, 2) + " Hz"


		    selectObject: pitchID
		    mean_f0_orig = Get mean: sTime, eTime, "hertz"
		    target_f0_hz = mean_f0_orig * (1 + f0_mod)
		    appendInfoLine: "Loop F0 Step: " + string$(f0step) + " | S1 Mean F0: " + fixed$(target_f0_hz, 2) + " Hz"
		endif

		intervalCounter = sTime
		while intervalCounter < eTime
			selectObject: "TextGrid " + objectName$
			intervalNumber = Get interval at time: syl_reference_tier, intervalCounter
			syl$ = Get label of interval: syl_reference_tier, intervalNumber
			#procedure scrapeStep: .t, .syl$, .mode$, .sTime, .eTime, .s1_f0m, .s2f0_m, .s1q_m, .s2q_m
			@scrapeStep: intervalCounter, syl$, mode$, sTime, eTime, (1 + f0_mod), (1 - f0_mod), (1 + f1_mod), 1
			intervalCounter += 0.005
		endwhile
	endfor
	
	selectObject: "TextGrid " + objectName$
	Remove
	selectObject: "Sound " + objectName$
	Remove
	selectObject: "Formant " + objectName$
	Remove
	selectObject: "Intensity " + objectName$
	Remove
	selectObject: pitchID
	Remove
	selectObject: klattID
	To Sound
	Save as highest quality MP3 file: output_directory$ + klattName$ + ".mp3"
endfor
endfor
endfor

selectObject: "Strings fileList"
Remove
exit

procedure scrapeStep: .t, .syl$, .mode$, .sTime, .eTime, .s1f0_m, .s2f0_m, .s1q_m, .s2q_m
	selectObject: "Formant " + objectName$
	.f1 = Get value at time: 1, .t, "hertz", "linear"
	.f2 = Get value at time: 2, .t, "hertz", "linear"
	.f3 = Get value at time: 3, .t, "hertz", "linear"
	.bw1 = Get bandwidth at time: 1, .t, "hertz", "linear"
	.bw2 = Get bandwidth at time: 2, .t, "hertz", "linear"
	.bw3 = Get bandwidth at time: 3, .t, "hertz", "linear"


	selectObject: "Intensity " + objectName$
	.int = Get value at time: .t, "cubic"
	.int = .int - 25

	selectObject: "Pitch " + objectName$
	.f0 = Get value at time: .t, "Hertz", "linear"

	selectObject: klattID

	if .syl$ == "s1"
		if .f0 <> undefined
	        	Add pitch point: .t, .f0 * .s1f0_m
		endif
	elif .syl$ == "s2"
		if .f0 <> undefined
	        	Add pitch point: .t, .f0 * .s2f0_m
		endif
	else
		if .f0 <> undefined
	        	Add pitch point: .t, 100
		endif
	endif


	# ORAL BRANCH (Vowels, Sonorants, and ASPIRATION)
	# We use this for vowels AND for /h/ and stop bursts
	if .mode$ == "vocalic" or .mode$ == "mixed" or .mode$ == "aspirated"
		if .syl$ == "s1"
			Add oral formant frequency point: 1, .t, .f1 * .s1q_m
		elif .syl$ == "s2"
			Add oral formant frequency point: 1, .t, .f1 * .s2q_m
		else
			Add oral formant frequency point: 1, .t, .f1
		endif
		Add oral formant frequency point: 2, .t, .f2
		Add oral formant frequency point: 3, .t, .f3
		Add oral formant bandwidth point: 1, .t, .bw1
		Add oral formant bandwidth point: 2, .t, .bw2
		Add oral formant bandwidth point: 3, .t, .bw3

		if .mode$ == "vocalic" or .mode$ == "mixed"
			Add voicing amplitude point: .t, .int
		endif

		if .mode$ == "aspirated"
			# Aspiration is noise through the Oral filter
			Add aspiration amplitude point: .t, .int
		endif
	endif

	# STOP BRANCH (Stops /p, t, k, b, d, g/)
	if .mode$ == "stop"

		#--STOPS--

		selectObject(soundID)
		Extract part: .t - 0.05, .t + 0.05, "rectangular", 1.0, "yes"
		.tempSoundID = selected("Sound")
		To Spectrum
		.tempSpecID = selected("Spectrum")
		.spectralCenter = Get centre of gravity: 2
		selectObject(klattID)
		
		#Frication amplitude, threshold to sense when closure is released
		if .t > .sTime - 0.05 and .t < .sTime + 0.05
			Add voicing amplitude point: .t, 0
			Add frication amplitude point: .t, 0
		elif .t <> .eTime and .spectralCenter > 480
			
			Add frication amplitude point: .t, .int
	        	Add frication formant frequency point: 2, .t, .f2
	        	Add frication formant frequency point: 3, .t, .f3
	        	Add frication formant bandwidth point: 2, .t, .bw2
	        	Add frication formant bandwidth point: 3, .t, .bw3
			Add frication formant amplitude point: 2, .t, 6
			Add frication formant amplitude point: 3, .t, 8
		elif .t > .eTime - 0.05 and .t < .eTime + 0.05
			Add frication amplitude point: .t, 0
		endif
		
		removeObject: .tempSoundID
		removeObject: .tempSpecID	
	endif


	# FRICATION BRANCH (Sibilants /s, z, ʃ, dʒ/)
	if .mode$ == "fricative" or .mode$ == "mixed"


				#--Baseline 0 Amplitudes--
		if .t > .sTime - 0.05 and .t < .sTime + 0.05
			Add voicing amplitude point: .t, 0
			Add frication amplitude point: .t, 0
		endif

				#--Track frication--
		Add frication formant frequency point: 2, .t, .f2
		Add frication formant frequency point: 3, .t, .f3
		Add frication formant bandwidth point: 2, .t, .bw2
		Add frication formant bandwidth point: 3, .t, .bw3
		Add frication formant amplitude point: 2, .t, 6
		Add frication formant amplitude point: 3, .t, 8
		Add frication amplitude point: .t, .int

				#--Segmental End Voicing--
		if .t > .eTime - 0.05 and .t < .eTime + 0.05
			Add voicing amplitude point: .t, 0
			Add frication amplitude point: .t, 0
		endif
	endif
endproc