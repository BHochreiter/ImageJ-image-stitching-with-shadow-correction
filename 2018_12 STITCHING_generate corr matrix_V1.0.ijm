// IMAGE STITCHING

//macro for generation of preCorrection matrix V1.0
//Developed by Bernhard Hochreiter, Medical University Vienna, 12 2018, V1.0
//bernhard.hochreiter@meduniwien.ac.at

//input folder should contain empty images

input_folder="C:/Users/hochreiterb/Desktop/image stitching/empty images"
output_folder="C:/Users/hochreiterb/Desktop/image stitching"

//DO NOT CHANGE ANYTHING AFTER THIS LINE
//###############################################################


list = getFileList(input_folder);
for (i=0;i<list.length;i++) { 
	open( input_folder +"/"+ list[i] );
}
run("Images to Stack", "name=Stack title=[] use");
run("32-bit");
run("Z Project...", "projection=Median");
close("Stack");

run("Reciprocal");
getStatistics(area, mean);
run("Divide...", "value=mean");
run("Grays");



rename("preCorrection_matrix");
saveAs("Tiff", output_folder+"/preCorrection_matrix.tif");