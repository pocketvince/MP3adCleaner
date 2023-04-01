#!/bin/bash
if [ "$1" = "extract" ]; then
full="$4"
jingleintro="$2"
jingleoutro="$3"
if [[ ! -f "$full" ]] ; then echo "Oops, $full was not found" ; exit ; fi
if [[ ! -f "$jingleintro" ]] ; then echo "Oops, $jingleintro was not found" ; exit ; fi
if [[ ! -f "$jingleoutro" ]] ; then echo "Oops, $jingleoutro was not found" ; exit ; fi
durationoutro=$(ffmpeg -i "$jingleoutro" 2>&1 | grep Duration | awk '{print $2}' | tr -d , | awk -F ':' '{print ($1*3600)+($2*60)+$3}')
echo "Convert $full to wav"
ffmpeg -hide_banner -loglevel error -i "$full" "$full.wav"
echo "Convert $jingleintro to wav"
ffmpeg -hide_banner -loglevel error -i "$jingleintro" "$jingleintro.wav"
echo "Convert $jingleoutro to wav"
ffmpeg -hide_banner -loglevel error -i "$jingleoutro" "$jingleoutro.wav"
echo "Research jingle intro on $full:"
jingle_intro_results=$(python3 mp3adcleaner.py "$jingleintro.wav" "$full.wav")
echo "Research jingle outro on $full:"
jingle_outro_check=$(python3 mp3adcleaner.py "$jingleoutro.wav" "$full.wav")
jingle_outro_results=$(echo "$jingle_outro_check + $durationoutro" | bc)
#Extraction
ffmpeg -hide_banner -loglevel error -i "$full" -ss "$jingle_intro_results" -to "$jingle_outro_results" -c copy "mp3adcleaner_$full"
[ -f "mp3adcleaner_$full" ] && echo "mp3adcleaner_$full is ready" || echo "Oops, something is wrong"
rm "$full.wav" "$jingleintro.wav" "$jingleoutro.wav"
exit

elif [ "$1" = "extract-ba" ]; then
full="$4"
jingleintro="$2"
jingleoutro="$3"
if [[ ! -f "$full" ]] ; then echo "Oops, $full was not found" ; exit ; fi
if [[ ! -f "$jingleintro" ]] ; then echo "Oops, $jingleintro was not found" ; exit ; fi
if [[ ! -f "$jingleoutro" ]] ; then echo "Oops, $jingleoutro was not found" ; exit ; fi
durationintro=$(ffmpeg -i "$jingleintro" 2>&1 | grep Duration | awk '{print $2}' | tr -d , | awk -F ':' '{print ($1*3600)+($2*60)+$3}')
durationoutro=$(ffmpeg -i "$jingleoutro" 2>&1 | grep Duration | awk '{print $2}' | tr -d , | awk -F ':' '{print ($1*3600)+($2*60)+$3}')
echo "Convert $full to wav"
ffmpeg -hide_banner -loglevel error -i "$full" "$full.wav"
echo "Convert $jingleintro to wav"
ffmpeg -hide_banner -loglevel error -i "$jingleintro" "$jingleintro.wav"
echo "Convert $jingleoutro to wav"
ffmpeg -hide_banner -loglevel error -i "$jingleoutro" "$jingleoutro.wav"
echo "Research jingle intro on $full.wav:"
jingle_intro_check=$(python3 mp3adcleaner.py "$jingleintro.wav" "$full.wav")
jingle_intro_results=$(echo "$jingle_intro_check + $durationintro" | bc)
echo "Research jingle outro on $full.wav:"
jingle_outro_results=$(python3 mp3adcleaner.py "$jingleoutro.wav" "$full.wav")
#Extraction
ffmpeg -hide_banner -loglevel error -i "$full" -ss "$jingle_intro_results" -to "$jingle_outro_results" -c copy "mp3adcleaner-ba_$full"
[ -f "mp3adcleaner-ba_$full" ] && echo "mp3adcleaner-ba_$full is ready" || echo "Oops, something is wrong"
rm "$full.wav" "$jingleintro.wav" "$jingleoutro.wav"
exit

elif [ "$1" = "extract-fi" ]; then
full="$3"
jingleintro="$2"
if [[ ! -f "$full" ]] ; then echo "Oops, $full was not found" ; exit ; fi
if [[ ! -f "$jingleintro" ]] ; then echo "Oops, $jingleintro was not found" ; exit ; fi
durationfull=$(ffmpeg -i "$full" 2>&1 | grep Duration | awk '{print $2}' | tr -d , | awk -F ':' '{print ($1*3600)+($2*60)+$3}')
echo "Convert $full to wav"
ffmpeg -hide_banner -loglevel error -i "$full" "$full.wav"
echo "Convert $jingleintro to wav"
ffmpeg -hide_banner -loglevel error -i "$jingleintro" "$jingleintro.wav"
echo "Research jingle intro on $full:"
jingle_intro_results=$(python3 mp3adcleaner.py "$jingleintro.wav" "$full.wav")
#Extraction
ffmpeg -hide_banner -loglevel error -i "$full" -ss "$jingle_intro_results" -to "$durationfull" -c copy "mp3adcleaner-fi_$full"
[ -f "mp3adcleaner-fi_$full" ] && echo "mp3adcleaner-fi_$full is ready" || echo "Oops, something is wrong"
rm "$full.wav" "$jingleintro.wav"
exit

elif [ "$1" = "extract-aie" ]; then
full="$3"
jingleintro="$2"
if [[ ! -f "$full" ]] ; then echo "Oops, $full was not found" ; exit ; fi
if [[ ! -f "$jingleintro" ]] ; then echo "Oops, $jingleintro was not found" ; exit ; fi
durationintro=$(ffmpeg -i "$jingleintro" 2>&1 | grep Duration | awk '{print $2}' | tr -d , | awk -F ':' '{print ($1*3600)+($2*60)+$3}')
durationfull=$(ffmpeg -i "$full" 2>&1 | grep Duration | awk '{print $2}' | tr -d , | awk -F ':' '{print ($1*3600)+($2*60)+$3}')
echo "Convert $full to wav"
ffmpeg -hide_banner -loglevel error -i "$full" "$full.wav"
echo "Convert $jingleintro to wav"
ffmpeg -hide_banner -loglevel error -i "$jingleintro" "$jingleintro.wav"
echo "Research jingle intro on $full:"
jingle_intro_check=$(python3 mp3adcleaner.py "$jingleintro.wav" "$full.wav")
jingle_intro_results=$(echo "$jingle_intro_check + $durationintro" | bc)
#Extraction
ffmpeg -hide_banner -loglevel error -i "$full" -ss "$jingle_intro_results" -to "$durationfull" -c copy "mp3adcleaner-aie_$full"
[ -f "mp3adcleaner-aie_$full" ] && echo "mp3adcleaner-aie_$full is ready" || echo "Oops, something is wrong"
rm "$full.wav" "$jingleintro.wav"
exit

elif [ "$1" = "extract-sto" ]; then
full="$3"
jingleoutro="$2"
if [[ ! -f "$full" ]] ; then echo "Oops, $full was not found" ; exit ; fi
if [[ ! -f "$jingleoutro" ]] ; then echo "Oops, $jingleoutro was not found" ; exit ; fi
durationoutro=$(ffmpeg -i "$jingleoutro" 2>&1 | grep Duration | awk '{print $2}' | tr -d , | awk -F ':' '{print ($1*3600)+($2*60)+$3}')
echo "Convert $full to wav"
ffmpeg -hide_banner -loglevel error -i "$full" "$full.wav"
echo "Convert $jingleoutro to wav"
ffmpeg -hide_banner -loglevel error -i "$jingleoutro" "$jingleoutro.wav"
echo "Research jingle outro on $full:"
jingle_outro_check=$(python3 mp3adcleaner.py "$jingleoutro.wav" "$full.wav")
jingle_outro_results=$(echo "$jingle_outro_check + $durationoutro" | bc)
#Extraction
ffmpeg -hide_banner -loglevel error -i "$full" -ss 0 -to "$jingle_outro_results" -c copy "mp3adcleaner-sto_$full"
[ -f "mp3adcleaner-sto_$full" ] && echo "mp3adcleaner-sto_$full is ready" || echo "Oops, something is wrong"
rm "$full.wav" "$jingleoutro.wav"
exit

elif [ "$1" = "extract-sbo" ]; then
full="$3"
jingleoutro="$2"
if [[ ! -f "$full" ]] ; then echo "Oops, $full was not found" ; exit ; fi
if [[ ! -f "$jingleoutro" ]] ; then echo "Oops, $jingleoutro was not found" ; exit ; fi
durationoutro=$(ffmpeg -i "$jingleoutro" 2>&1 | grep Duration | awk '{print $2}' | tr -d , | awk -F ':' '{print ($1*3600)+($2*60)+$3}')
echo "Convert $full to wav"
ffmpeg -hide_banner -loglevel error -i "$full" "$full.wav"
echo "Convert $jingleoutro to wav"
ffmpeg -hide_banner -loglevel error -i "$jingleoutro" "$jingleoutro.wav"
echo "Research jingle outro on $full:"
jingle_outro_results=$(python3 mp3adcleaner.py "$jingleoutro.wav" "$full.wav")
#Extraction
ffmpeg -hide_banner -loglevel error -i "$full" -ss 0 -to "$jingle_outro_results" -c copy "mp3adcleaner-sbo_$full"
[ -f "mp3adcleaner-sbo_$full" ] && echo "mp3adcleaner-sbo_$full is ready" || echo "Oops, something is wrong"
rm "$full.wav" "$jingleoutro.wav"
exit

elif [ "$1" = "extract-bi" ]; then
full="$3"
jingleintro="$2"
if [[ ! -f "$full" ]] ; then echo "Oops, $full was not found" ; exit ; fi
if [[ ! -f "$jingleintro" ]] ; then echo "Oops, $jingleintro was not found" ; exit ; fi
durationintro=$(ffmpeg -i "$jingleintro" 2>&1 | grep Duration | awk '{print $2}' | tr -d , | awk -F ':' '{print ($1*3600)+($2*60)+$3}')
echo "Convert $full to wav"
ffmpeg -hide_banner -loglevel error -i "$full" "$full.wav"
echo "Convert $jingleintro to wav"
ffmpeg -hide_banner -loglevel error -i "$jingleintro" "$jingleintro.wav"
echo "Research jingle intro on $full:"
jingle_intro_results=$(python3 mp3adcleaner.py "$jingleintro.wav" "$full.wav")
#Extraction
ffmpeg -hide_banner -loglevel error -i "$full" -ss 0 -to "$jingle_intro_results" -c copy "mp3adcleaner-bi_$full"
[ -f "mp3adcleaner-bi_$full" ] && echo "mp3adcleaner-bi_$full is ready" || echo "Oops, something is wrong"
rm "$full.wav" "$jingleintro.wav"
exit

elif [ "$1" = "extract-ao" ]; then
full="$3"
jingleoutro="$2"
if [[ ! -f "$full" ]] ; then echo "Oops, $full was not found" ; exit ; fi
if [[ ! -f "$jingleoutro" ]] ; then echo "Oops, $jingleoutro was not found" ; exit ; fi
durationoutro=$(ffmpeg -i "$jingleoutro" 2>&1 | grep Duration | awk '{print $2}' | tr -d , | awk -F ':' '{print ($1*3600)+($2*60)+$3}')
durationfull=$(ffmpeg -i "$full" 2>&1 | grep Duration | awk '{print $2}' | tr -d , | awk -F ':' '{print ($1*3600)+($2*60)+$3}')
echo "Convert $full to wav"
ffmpeg -hide_banner -loglevel error -i "$full" "$full.wav"
echo "Convert $jingleoutro to wav"
ffmpeg -hide_banner -loglevel error -i "$jingleoutro" "$jingleoutro.wav"
echo "Research jingle outro on $full:"
jingle_outro_check=$(python3 mp3adcleaner.py "$jingleoutro.wav" "$full.wav")
jingle_outro_results=$(echo "$jingle_outro_check + $durationoutro" | bc)
#Extraction
ffmpeg -hide_banner -loglevel error -i "$full" -ss "$jingle_outro_results" -to "$durationfull" -c copy "mp3adcleaner-ao_$full"
[ -f "mp3adcleaner-ao_$full" ] && echo "mp3adcleaner-ao_$full is ready" || echo "Oops, something is wrong"
rm "$full.wav" "$jingleoutro.wav"
exit



elif [ "$1" = "extract-jingle-intro" ]; then
full="$2"
start_time="$3"
end_time="$4"
if [[ ! -f "$full" ]] ; then echo "Oops, $full was not found" ; exit ; fi
echo "Start extraction jingle intro"
ffmpeg -hide_banner -loglevel error -i "$full" -ss "$start_time" -to "$end_time" -c copy "jingle_intro_$full"
[ -f "jingle_intro_$full" ] && echo "jingle_intro_$full is ready" || echo "Oops, something is wrong"
exit

elif [ "$1" = "extract-jingle-outro" ]; then
full="$2"
start_time="$3"
end_time="$4"
if [[ ! -f "$full" ]] ; then echo "Oops, $full was not found" ; exit ; fi
echo "Start extraction jingle outro"
ffmpeg -hide_banner -loglevel error -i "$full" -ss "$start_time" -to "$end_time" -c copy "jingle_outro_$full"
[ -f "jingle_outro_$full" ] && echo "jingle_outro_$full is ready" || echo "Oops, something is wrong"
exit

elif [ "$1" = "debug" ]; then
jingle_intro="$2"
jingle_outro="$3"
full="$4"
if [[ ! -f "$full" ]] ; then echo "Oops, $full was not found" ; exit ; fi
if [[ ! -f "$jingle_intro" ]] ; then echo "Oops, $jingle_intro was not found" ; exit ; fi
if [[ ! -f "$jingle_outro" ]] ; then echo "Oops, $jingle_outro was not found" ; exit ; fi
echo start debug
./mp3adcleaner.sh extract "$jingle_intro" "$jingle_outro" "$full"
./mp3adcleaner.sh extract-ba "$jingle_intro" "$jingle_outro" "$full"
./mp3adcleaner.sh extract-fi "$jingle_intro" "$full"
./mp3adcleaner.sh extract-aie "$jingle_intro" "$full"
./mp3adcleaner.sh extract-sto "$jingle_outro" "$full"
./mp3adcleaner.sh extract-sbo "$jingle_outro" "$full"
./mp3adcleaner.sh extract-bi "$jingle_intro" "$full"
./mp3adcleaner.sh extract-ao "$jingle_outro" "$full"
echo "Test file:"
file="mp3adcleaner_$full" ; [ -f "$file" ] && echo -e "[\033[32mOK\033[0m] $file" || echo -e "[\033[31mNOK\033[0m] $file"
file="mp3adcleaner-ba_$full" ; [ -f "$file" ] && echo -e "[\033[32mOK\033[0m] $file" || echo -e "[\033[31mNOK\033[0m] $file"
file="mp3adcleaner-fi_$full" ; [ -f "$file" ] && echo -e "[\033[32mOK\033[0m] $file" || echo -e "[\033[31mNOK\033[0m] $file"
file="mp3adcleaner-aie_$full" ; [ -f "$file" ] && echo -e "[\033[32mOK\033[0m] $file" || echo -e "[\033[31mNOK\033[0m] $file"
file="mp3adcleaner-sto_$full" ; [ -f "$file" ] && echo -e "[\033[32mOK\033[0m] $file" || echo -e "[\033[31mNOK\033[0m] $file"
file="mp3adcleaner-sbo_$full" ; [ -f "$file" ] && echo -e "[\033[32mOK\033[0m] $file" || echo -e "[\033[31mNOK\033[0m] $file"
file="mp3adcleaner-bi_$full" ; [ -f "$file" ] && echo -e "[\033[32mOK\033[0m] $file" || echo -e "[\033[31mNOK\033[0m] $file"
file="mp3adcleaner-ao_$full" ; [ -f "$file" ] && echo -e "[\033[32mOK\033[0m] $file" || echo -e "[\033[31mNOK\033[0m] $file"
echo end debug

exit




else

  echo "extract from intro to outro:                      ./mp3adcleaner.sh extract jingle_intro jingle_outro full_file"
  echo "extract after the intro, to before the outro:     ./mp3adcleaner.sh extract-ba jingle_intro jingle_outro full_file"
  echo "extract from intro to end:                        ./mp3adcleaner.sh extract-fi jingle_intro full_file"
  echo "extract after intro to end:                       ./mp3adcleaner.sh extract-aie jingle_intro full_file"
  echo "extract start to outro:                           ./mp3adcleaner.sh extract-sto jingle_outro full_file"
  echo "extract start to before outro:                    ./mp3adcleaner.sh extract-sbo jingle_outro full_file"
  echo "extract before intro:                             ./mp3adcleaner.sh extract-bi jingle_intro full_file"
  echo "extract after outro:                              ./mp3adcleaner.sh extract-ao jingle_outro full_file"
  echo "extract jingle intro:                             ./mp3adcleaner.sh extract-jingle-intro full_file start_time end_time (time in seconds)"
  echo "extract jingle outro:                             ./mp3adcleaner.sh extract-jingle-outro full_file start_time end_time (time in seconds)"
  echo "debug: try all functions except jingle extraction:./mp3adcleaner.sh debug jingle_intro jingle_outro full_file"
exit 1
fi
