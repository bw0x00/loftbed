.PHONY: images

default: clean images

images:
	openscad -q -o images/back.png loftbed.scad --camera=810,-3,815,64,0,165,9250
	openscad -q -o images/front.png loftbed.scad --camera=866,471,1474,71,0,345,7613

clean:
	rm images/*.png
