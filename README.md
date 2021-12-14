# I-SUEAT: SPEECH-TO-TEXT OF THE AKEANON LANGUAGE
This project presents the development of the I-Sueat speech-to-text system that would be able to recognize Akeanon words with a decent accuracy rating. The system would be made using the open-source speech recognition toolkit “Kaldi”. Kaldi is a speech recognition toolkit written in C++ and licensed under the Apache License v2.0. The system would be developed in a way such that the audio, acoustic and language data would be catered to the Akeanon dialect.


Additional details on Kaldi can be found here:
https://github.com/kaldi-asr/kaldi
and http://kaldi-asr.org/doc/

The instructions to download and install Kaldi are available on the official github repository. It is **highly recommended** to install and run the system on Linux-based operating systems.


## Quick Start Guide

1. To clone the repository, run the following command:
```
git clone https://github.com/Blank125/I-Sueat.git
```

2. The prototype ASR system is located within the master branch.
After cloning the repo, to check if the branch exists run: 
```
git branch -r
```

3. To access the prototype, run the following command:
```
git checkout origin/master
```

4. The prototype ASR would be located within egs/digits. Follow the instructions provided in https://kaldi-asr.org/doc/kaldi_for_dummies.html in order to set up and change some of the files since the path would differ among different users and PCs.

The files to be changed:
- egs\digits\data\test\wav.scp
- egs\digits\data\train\wav.scp
- egs\digits\path.sh

If the data files aren't sorted, run sort_dir.py located in egs\digits\scripts

5. Afterwards, simply execute run.sh


**Members**
- Carpio, J.
- Garcia, M.
- Rabe, J.
