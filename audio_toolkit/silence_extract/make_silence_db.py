#!/usr/bin/env python
# -*- coding: cp949 -*-

from pydub import AudioSegment
from pydub.silence import detect_silence
from itertools import tee, chain
import sys, os

if len(sys.argv) == 3:
    scpFile, minSilLen = sys.argv[1:3]
else:
    print('usage : python3 make_silence_db.py wav_scp_file min_sil_length')
    sys.exit(1)

silThresh = -50
minSilLen = int(minSilLen) * 1000

scpF = open(scpFile, 'r')
scpLines = scpF.readlines()

for scpLine in scpLines:
    key, value = scpLine.split(maxsplit=1)

    outWavKeyname = key.split()[0]
    inWavFname = value.split()[0]
    outWavDirPath = './SilenceDB/' + outWavKeyname
    os.system( "mkdir -p %s" % (outWavDirPath) )

    inWavFile = AudioSegment.from_wav(inWavFname)
    inWavLen = len(inWavFile)

    if inWavLen < minSilLen:
        continue

    silRanges= detect_silence(inWavFile, minSilLen, silThresh)

    segWavIdx = 0
    for start, end in silRanges:
        outWav = inWavFile[start:end]
        outWavFname = outWavDirPath + '/' + outWavKeyname + '_' + str(segWavIdx).zfill(3) + '.wav'
        outWav.export(outWavFname, format="wav")
        segWavIdx += 1
