.PHONY: images

default: images

images:
	openscad -o images/front.png loftbed.scad --camera=810,-3,815,64,0,165,9250

clean:
	rm images/*.png
