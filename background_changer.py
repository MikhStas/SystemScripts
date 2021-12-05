#! /bin/python3

import time
import random
import subprocess
import os
import sys


def get_random_delay():
    start_delay_sec = 7200
    stop_delay_sec = 72000

    return(random.randint(start_delay_sec, stop_delay_sec))

def get_random_wallpaper():
    wallpapers_path = '/home/infer/Pictures/Cameron_Wallpapers'
    wallpapers_list = [os.path.join(wallpapers_path, i) 
            for i in os.listdir(wallpapers_path)]
    random_wallpaper = (random.randint(0, len(wallpapers_list) - 1))
    
    return wallpapers_list[random_wallpaper]

def set_background(setter_, path):
    extension = os.path.splitext(path)[1]
    if extension == '.jpg':
        print('Setting', path, 'as background')
        setter_(path)

def gnome_setter(path):
    subprocess.run(['gsettings', 'set', 'org.gnome.desctop.background',
        'picture-uri', path])

def i3_setter(path):
    subprocess.run(['feh', '--bg-fill', path])


if __name__ == '__main__':
    setter_ = None
    if '-i3' in sys.argv:
        setter_ = i3_setter
    elif '-gnome' in sys.argv:
        setter_ = gnome_setter

    while True:
        delay = get_random_delay()
        image = get_random_wallpaper()
        
        set_background(setter_, image)
        
        print('Sleeping for', delay, 'seconds')
        time.sleep(delay)
