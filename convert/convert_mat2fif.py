#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Feb  2 17:14:46 2023

@author: nahuel
"""
from libb import *

def main():
    #m = scipy.io.loadmat('data/BCICIV_calib_ds1d.mat', struct_as_record=True)
    # 770-rigth hand (MI)
    # 772-tonge (REST)
    # SciPy.io.loadmat does not deal well with Matlab structures, resulting in lots of
    # extra dimensions in the arrays. This makes the code a bit more cluttered
    sujeto = "S03"
    sesion = "1"
    pathIn = "../EEG data/Raw mat/"+ sujeto +"/"
    pathOut = "../EEG data/Raw fif/"+ sujeto +"/"
    fileNameIn = sujeto + "_FILT_S"+ sesion +"R"    

    trials = ["1", "2", "3", "4"]
    for trial in trials:
        print("Inicio...")
        filename = fileNameIn + trial
        mat = scipy.io.loadmat(pathIn + filename + ".mat")
        EEG  = mat["samples"].T
        EEG = EEG / 1000000
        sampleTime = mat["sampleTime"]
        stims = mat["stims"]
        #channel_names = ['Pz','Cz','T6','T4','F8','P4','C4','F4','Fz','T5','T3','F7','P3','C3','F3']
        #channel_names = ['C3','Cz','C4','P3','Pz','P4','T5','T6']
        channel_names1 = mat["channelNames"][0]
        channel_names = [item[0] for item in channel_names1]
        freq = mat["samplingFreq"][0][0]
        #freq = 250
        
        #print(EEG)
        print(EEG.shape)
        print(sampleTime.shape)
        print(stims.shape)
        print(channel_names)
        print(freq)        
        
        #print(stims)
        event0_onsets = stims[stims[:,1]==772, 0] * freq   # 772-tonge (REST)
        event1_onsets = stims[stims[:,1]==770, 0] * freq   # 770-rigth hand (MI)
        
        #event_id = {'rest': 0, 'right': 1}
        event_id = { 0: 'rest', 1: 'right'}
        
        events0 = np.zeros((len(event0_onsets) , 3), int)
        events0[:, 0] = event0_onsets.astype(int)
        
        events1 = np.zeros((len(event1_onsets) , 3), int)
        events1[:, 0] = event1_onsets.astype(int)
        events1[:, 2] = 1
        
        events = np.concatenate((events0, events1))
        print(events.shape)
        
        #Se carga los nombre de los caneles
        info = mne.create_info(channel_names, freq, 'eeg')
        raw = mne.io.RawArray(EEG, info, first_samp=0, copy='auto', verbose='critical')
        
        #mne.annotations_from_events(events, freq, event_desc=event_id)
        annotations=mne.annotations_from_events(
            events=events, sfreq=freq, event_desc=event_id
        )
        raw.set_annotations(annotations)
        raw.save(pathOut + filename + "_eeg.fif", overwrite=True)        
        
        #mne.write_events(pathOut + filename + "-eve.fif", events, overwrite=True)
        #events_annotations.save(pathOut + filename + "_annot.fif", overwrite=True)

if __name__ == "__main__":
    main()