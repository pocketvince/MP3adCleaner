import argparse
import numpy as np
import librosa
from tqdm import tqdm

#definition arguments
parser = argparse.ArgumentParser()
parser.add_argument("extrait", help="The name of the file containing the sample")
parser.add_argument("complet", help="The name of the file containing the complete mp3")
args = parser.parse_args()

#load sample and full mp3
y_extract, sr_extract = librosa.load(args.extrait)
y_full, sr_full = librosa.load(args.complet)

#defind size segment
segment_length = len(y_extract)

#check best match
best_match = None
best_match_distance = np.inf

#progress bar step
step = 1000

#launch progress bar
pbar = tqdm(total=len(y_full) - segment_length, desc="Treatment status")

#comparaison
for i in range(len(y_full) - segment_length):
    #extract segment
    segment = y_full[i:i+segment_length]

    #calculate
    distance = np.linalg.norm(y_extract - segment)

    #update best match
    if distance < best_match_distance:
        best_match = i
        best_match_distance = distance

    #update progress bar
    if i % step == 0:
        pbar.update(step)

    #exit loop if find best match
    if best_match_distance == 0:
        break

#close progress bar
pbar.close()

#convert time
temps = best_match / sr_full

#show time in mp3 file
print(f"{temps:.2f}")
