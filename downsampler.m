clear, clc, close all;

out=zeros(16,8);
frameCount = 0;

candle2=VideoReader('C:\Users\alfon\Downloads\candle2.mp4');
cropStartX2 = 850;
cropStartY2= 400;
videoHeight2 = 410;

candle3=VideoReader('C:\Users\alfon\Downloads\candle3.mp4');
cropStartX3 = 750;
cropStartY3 = 0;

candle = candle2;
cropStartX = cropStartX2;
cropStartY = cropStartY2;
videoHeight = videoHeight2;

while hasFrame(candle)
    frameCount = frameCount + 1;
    
    frame = readFrame(candle);
    cropZone = [cropStartX cropStartY videoHeight/2 videoHeight];
    
    crop = rgb2gray(imcrop(frame,cropZone)) > 200;
    resized = imresize(crop, [16 8]);
    
    out(:,:,frameCount) = resized;
     
    imshow(crop);
end

% maybe need to skip some frames to make it shorter/faster
reducedFrameCount = 1;
for i=80:1:frameCount
   
    fprintf("{");
    for row=1:16
       byteString = "";
       byte = out(row,:,i);
       for bit=1:8
           byteString= strcat(byteString,string(byte(bit)));
       end
       if(row == 16)
           fprintf("B%s",byteString);
       else
           fprintf("B%s,",byteString);
       end
    end
    fprintf("},\n");
    reducedFrameCount = reducedFrameCount + 1;
end
