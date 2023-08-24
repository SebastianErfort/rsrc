# Edit the meta data
# pip install piexif
# pip install eyed3
# pip install Pillow# <==Edit Images Meta Data==>
import piexif
from PIL import ImageChops

# read meta data
img = Image.open('test.jpg')
exif_dict = piexif.load(img.info['exif'])# Print the meta data

print(exif_dict)# Print by value
print(exif_dict['0th'][piexif.ImageIFD.Make])# Edit the meta data

exif_dict['0th'][piexif.ImageIFD.Make] = 'Apple'# Save the meta data
exif_bytes = piexif.dump(exif_dict)
img.save('edit.jpg', exif=exif_bytes)

# <==Edit Audio Meta Data==>
import eyed3

# read meta data
music = eyed3.load('test.mp3')# Print the meta data
print(music.tag)# print by value
print(music.tag.artist)# Edit the meta data
music.tag.artist = 'Apple'
music.tag.track_num = 10# save the meta data
music.tag.save()
