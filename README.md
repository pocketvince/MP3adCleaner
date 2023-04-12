# MP3adCleaner
Python script (with a lazy mode in the shell) to remove pollution from MP3 files such as advertising.

## Update:
20230412: new function: Extract from intro to outro (from first half of the intro and the second half of the outro)

## Installation
If using the shell script 
```shell
sudo apt-get install ffmpeg bc python3
```

For Python3
```shell
pip3 install argparse numpy librosa tqdm
```
And download the scripts: mp3adcleaner.py & mp3adcleaner.sh

## How it works?
The structure of a podcast is often like this:
![Alt text](https://raw.githubusercontent.com/pocketvince/MP3adCleaner/main/Visual/extract.png?raw=true "Advertisements, pre-podcast discussion, jingle intro, podcast, jingle outro, advertisements")
For a long podcast, this is not really a problem, but for short podcasts, more than 50% of the audio content is useless.

This is also the case on radio recordings for news.
Before/after the news: traffic information, music, weather, other Show,...

The script allows to identify the intro/outro jingle, and remove the rest.

## Usage
Only python3:

You load the jingle and the "full file", and it retrieves the time at which the jingle is located (the time displayed is in seconds):
```shell
root@pocketvince:~# python3 mp3adcleaner.py "jingle_intro_test.mp3.wav" "test.mp3.wav"
Treatment status: 1393000it [01:25, 16319.02it/s]
13.66
```
or, run the shell script:
```shell
root@pocketvince:~# ./mp3adcleaner.sh
Extract from intro to outro:
./mp3adcleaner.sh extract jingle_intro jingle_outro full_file

Extract from intro to outro (from first half of the intro and the second half of the outro):
./mp3adcleaner.sh extract-fa jingle_intro jingle_outro full_file

Extract after the intro, to before the outro:
./mp3adcleaner.sh extract-ba jingle_intro jingle_outro full_file

Extract from intro to end:
./mp3adcleaner.sh extract-fi jingle_intro full_file

Extract after intro to end:
./mp3adcleaner.sh extract-aie jingle_intro full_file

Extract start to outro:
./mp3adcleaner.sh extract-sto jingle_outro full_file

Extract start to before outro:
./mp3adcleaner.sh extract-sbo jingle_outro full_file

Extract before intro:
./mp3adcleaner.sh extract-bi jingle_intro full_file

Extract after outro:
./mp3adcleaner.sh extract-ao jingle_outro full_file

Extract jingle intro:
./mp3adcleaner.sh extract-jingle-intro full_file start_time end_time (time in seconds)

Extract jingle outro:
./mp3adcleaner.sh extract-jingle-outro full_file start_time end_time (time in seconds)

debug:
try all functions except jingle extraction:./mp3adcleaner.sh debug jingle_intro jingle_outro full_file
```

The shell version uses the python script to find the time of the intro and/or outro and does the automatic cutting with ffmpeg.

In the folder "sample_mp3_example" you will find examples of extraction already made.
Test: radio clip that contains [music], [jingle], [voice], [advertisement]
Sample_News: 2 radio recordings cut with the same jingles with a structure (+-) [ads],[jingle],[News],[jingle],[Next show]

I didn't really understand why, but it seems to work better in wav than mp3, so it converts to wav first before continuing.
I did some tests on videos files, it seems to work too, but not having the use for the moment, I didn't continue to explore (maybe later?).

## Usage (visual)
![Alt text](https://raw.githubusercontent.com/pocketvince/MP3adCleaner/main/Visual/extract.png?raw=true "extract")
![Alt text](https://raw.githubusercontent.com/pocketvince/MP3adCleaner/main/Visual/extract-fa.png?raw=true "extract-fa")
![Alt text](https://raw.githubusercontent.com/pocketvince/MP3adCleaner/main/Visual/extract-ba.png?raw=true "extract-ba")
![Alt text](https://raw.githubusercontent.com/pocketvince/MP3adCleaner/main/Visual/extract-fi.png?raw=true "extract-fi")
![Alt text](https://raw.githubusercontent.com/pocketvince/MP3adCleaner/main/Visual/extract-aie.png?raw=true "extract-aie")
![Alt text](https://raw.githubusercontent.com/pocketvince/MP3adCleaner/main/Visual/extract-sto.png?raw=true "extract-sto")
![Alt text](https://raw.githubusercontent.com/pocketvince/MP3adCleaner/main/Visual/extract-sbo.png?raw=true "extract-sbo")
![Alt text](https://raw.githubusercontent.com/pocketvince/MP3adCleaner/main/Visual/extract-bi.png?raw=true "extract-bi")
![Alt text](https://raw.githubusercontent.com/pocketvince/MP3adCleaner/main/Visual/extract-ao.png?raw=true "extract-ao")

## Contributing

Readme generator: https://www.makeareadme.com/

## Extra info
My first approach was to look for a software to do it automatically, but it didn't seem to exist.
I searched for "how to identify a part of an audio file with Python", and I cried a lot while looking at spectrograms second by second, but I eventually found packages to "find the time when an identical sound is triggered", and also to make a loading bar, execute a Python script with arguments,... It still looks like spaghetti code, but it was a very cool exercise.
