function [score] = clustering( image_name, K )
% An example of running this script is: clustering('testa.png', 4);

	score = 0;
	
	image = imread(image_name);
	rows = size(image, 1);
	cols = size(image, 2);
	pixels = zeros(rows*cols, 3);
    
	for i=1:rows
		for j=1:cols
			pixels((j-1)*rows+i, 1:3) = image(i,j,:);
		end
	end

	tic;
	[class1, centroid1] = mykmeans(pixels, K);
	kmeansTime = toc
	
	tic;
	[class2, centroid2] = mykmedoids(pixels, K);
 	kmedoidsTime = toc
    

	converted_image1 = zeros(rows, cols, 3);
	converted_image2 = zeros(rows, cols, 3);
	for i=1:rows
		for j=1:cols
			converted_image1(i, j, 1:3) = centroid1(class1((j-1)*rows+i),:);
			converted_image2(i, j, 1:3) = centroid2(class2((j-1)*rows+i),:);
		end
	end

	converted_image1 = converted_image1 / 255;
	converted_image2 = converted_image2 / 255;
	
	subplot(1,3,1);
	h = imshow(image_name, 'InitialMag',100, 'Border','tight');
	title('Original')
	
	subplot(1,3,2);
	h = imshow(converted_image1, 'InitialMag',100, 'Border','tight');
	title('K-means')
	
	subplot(1,3,3);
	h = imshow(converted_image2, 'InitialMag',100, 'Border','tight');
	title('K-medoids')
end
