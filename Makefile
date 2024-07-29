.PHONY: images

default: images

images:
	openscad -o images/back.png loftbed.scad --camera=810,-3,815,64,0,165,9250
	openscad -o images/front.png loftbed.scad --camera=377,-1191,1390,70,0,335,7856

clean:
	rm images/*.png
