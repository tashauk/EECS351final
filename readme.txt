** EECS 351 Group 9 Project **

When you run the program, you will be prompted to select samples 1-10.
We have attached 4 different samples in the .zip folder:
    sample 1: virtual piano recording (monorhythmic)
    sample 2: virtual piano recording (also monorhythmic)
    sample 3: virtual piano recording (polyrhythmic)
    sample 4: real guitar recording (polyrhythmic)
You can type "playsampleaudio" in the command window to play any of these samples.
You may also import more .wav file samples if they are in the project files directory
and are formatted as "audiosample_.wav" where "_" is an integer from 1-10.

After selecting the desired sample, you will be prompted to select a MIDI device. All available
MIDI devices on your computer will be displayed in the prompt. Windows comes pre-installed with
"Microsoft GS Wavetable Synth", which requires no set-up. You cannot select the soundfont in this
program so it will play as a virtual piano soundfont by default. If you choose to download
another virtual MIDI device or have a MIDI device that can receive inputs, it should automatically
show up in the prompt.

Lastly, you need the MATLAB Audio Toolbox, which requires R2020a and DSP toolboxes to run.

We created the audio samples ourselves. The virtual piano samples (1-3) were created in musescore.