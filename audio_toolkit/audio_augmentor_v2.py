#!/usr/bin/env python
# coding: utf-8

import librosa
from audiomentations import Compose, AddGaussianNoise, TimeStretch, PitchShift, Shift
import numpy as np
import glob
import os
from pathlib import Path
import soundfile


# set multiple
multiple = 20

# set augmentation param for noise
# augment = Compose([
#     AddGaussianNoise(min_amplitude=0.001, max_amplitude=0.005, p=0.5),
#     TimeStretch(min_rate=0.8, max_rate=1.10, p=0.5),
#     PitchShift(min_semitones=-3, max_semitones=3, p=0.5),
#     Shift(min_fraction=-0.4, max_fraction=0.4, p=0.5),
# ])

# set augmentation param for speech
augment = Compose([
    AddGaussianNoise(min_amplitude=0.001, max_amplitude=0.002, p=0.5),
    TimeStretch(min_rate=0.95, max_rate=1.05, p=0.5),
    PitchShift(min_semitones=-0.01, max_semitones=0.1, p=0.5),
    Shift(min_fraction=-0.1, max_fraction=0.1, p=0.5),
])



with open("trainset2.txt","r",encoding="utf-8") as rf:
    trainset = rf.readlines()


train_dict = {}

for idx, t in enumerate(trainset):
    train_dict[trainset[idx].split("|")[0]]=trainset[idx].split("|")[1].replace("\n","")



wav_path = "./normal/"
aug_path = "./aug_dataset2/"


for x, i in enumerate(glob.glob(wav_path+"*.wav")):
    print(x, i," ==== ",os.path.basename(i)," === ", Path(i).stem)
    base_value = train_dict[os.path.basename(i)]
    stem_name = Path(i).stem
    data, sr = librosa.load(i,dtype=np.float32, sr=8000)
    
    for i in range(multiple):
        augmented_data = augment(samples=data, sample_rate=sr)
        augmented_filename_key = stem_name+"_aug_"+str(i).zfill(2)+'.wav'
        augmented_filename = aug_path+stem_name+"_aug_"+str(i).zfill(2)+'.wav'
        train_dict[augmented_filename_key]  = base_value
        print(augmented_filename)
        
        soundfile.write(augmented_filename, augmented_data, sr, format='WAV')


with open("new_trainset.txt","w",encoding="utf=8") as wf:
    for i in train_dict:
        wf.write(i+"|"+train_dict[i]+"\n")
    


