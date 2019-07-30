//complete macro for image stitching (with pre-correction)
//Developed by Bernhard Hochreiter, Medical University Vienna, 12 2018, V1.0
//bernhard.hochreiter@meduniwien.ac.at

x=12
y=0		//type 0 if you want tautomatic y detection
overlap=15

correction_image_location="C:/Users/hochreiterb/Desktop/image stitching/preCorrection_matrix.tif"

output_folder="C:/Users/hochreiterb/Desktop/image stitching"

//DO NOT CHANGE ANYTHING AFTER THIS LINE
//############################################################################
setBatchMode(true);
input=getDirectory("image");

run("Close All");

open(correction_image_location);
rename("correction_matrix.tif");

list = getFileList(input);
n=list.length;
if(y==0){y=floor(n/x);}
for (i=0;i<x*y;i++) { 
	open( input +"/"+ list[i] );
	run("RGB Stack");
	imageCalculator("Multiply stack", list[i],"correction_matrix.tif");
	run("RGB Color");
		n=i+1;
		if(n<10){n="0000"+n;}
		else{if(n<100){n="000"+n;}
		else{if(n<1000){n="00"+n;}
		else{if(n<10000){n="0"+n;}
		}}}
   saveAs("Tiff", input+"/stitching_"+n+".tif");
   close();
}

	run("Grid/Collection stitching", "type=[Grid: snake by rows] order=[Right & Down                ] grid_size_x="+x+" grid_size_y="+y+" tile_overlap="+overlap+" first_file_index_i=00001 directory=["+input+"] file_names=stitching_{iiiii}.tif output_textfile_name=TileConfiguration.txt fusion_method=[Linear Blending] regression_threshold=0.01 max/avg_displacement_threshold=2.50 absolute_displacement_threshold=3.50 compute_overlap computation_parameters=[Save memory (but be slower)] image_output=[Fuse and display]");

for(i=0;i<x*y;i++){
			n=i+1;
		if(n<10){n="0000"+n;}
		else{if(n<100){n="000"+n;}
		else{if(n<1000){n="00"+n;}
		else{if(n<10000){n="0"+n;}
		}}}
		File.delete(input+"/stitching_"+n+".tif");
		File.delete(input+"TileConfiguration.txt");
		File.delete(input+"TileConfiguration.registered.txt");
}
close("correction_matrix.tif");
run("RGB Color");
close("Fused");
title_new=replace(list[1],".jpg","_stitched.jpeg");
rename(title_new);
saveAs("Jpeg",output_folder+"/"+title_new);
setBatchMode(false);
