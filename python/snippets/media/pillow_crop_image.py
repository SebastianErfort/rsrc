# Photo Cropper
# pip install Pillow
from PIL import Image

def Crop_image(img):
    image =  Image.open(img)
    dimension = 150, 150, 550, 550
    cropped_image = image.crop(dimension)
    cropped_image.save('cropped_image.png')

Crop_image('myimage.png')
