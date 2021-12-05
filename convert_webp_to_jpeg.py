#! /bin/python3

# convert .webp images to .jpg images
from PIL import Image
import os
import sys


if __name__ == '__main__':
    for file_path in sys.argv[1:]:
        image_name, image_ext = os.path.splitext(file_path)
        if image_ext == '.webp':
            print('Found webp image:', file_path)
            im = Image.open(file_path).convert('RGB')
            image_new_name = image_name + '.jpg'
            im.save(image_new_name, 'jpeg')
