# Convert Images to Video
# pip install opencv-python
import cv2 as cv

imgs = ["img1.png", "img2.png", "img3.png", "img4.png"]
frame = cv.imread(imgs[0])
H, W, layers = frame.shape
vid = cv.VideoWriter("output.avi", 0, 1, (W, H))
for img in imgs:
    vid.write(cv.imread(img))

cv.destroyAllWindows()
vid.release()
