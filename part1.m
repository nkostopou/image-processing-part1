%Load image , and convert it to gray-scale
x = imread('lena.bmp');
x = rgb2gray(x);

%Normalization at [0,1]
x = double(x) / 255 ;

% Show the histogram of intensity values 
[hn , hx ] = hist(x(:), 0:1/255:1);
figure 
bar(hx,hn)
title('Original Histogram')

%Call Point Transform
y =  pointtransform(x,0.1961, 0.0392, 0.8039, 0.9608);


%Call Clipping Transform
y =  pointtransform(x,0.5, 0, 0.5, 1);

%H sunartisi mou apoteleitai apo mia if else, to if einai gia tis times y1,y2 ~=0 eno to else gia tis periptoseis pou to y1,y2=0
%To if exei mia sunartish pou periexei tis diaforetikes euthies kai ta
%diastimata pou ginetai to contrast streching.
%To else apoteleitai apo enan pinaka me midenika kai se auton sumfona me
%thn unitstep function allazo ta pixel pou exoun timi megaliteri apo 0,5.

% Point Transform
function Y = pointtransform(X , x1 , y1 , x2 , y2  )

r = 0:1/100:1;

%When the values of y1 and y2 are not 0 
if ( y1 ~= 0)&&( y2 ~= 0)
    
    %Function for contrast streching
    f = [ ((y1/x1)*(0:1/100:x1))  ( ((y2-y1)/(x2-x1))*((x1:1/100:x2) - x1) + y1)  ( ((1-y2)/(1-x2))*((x2:1/100:1) - x2) + y2) ];
    figure
    
    %Original Image
    subplot(221)
    imshow(X)
    title('Original image')
    
    %F(r) plot
    subplot(222)
    plot(r , f)
    title('f(r)' );
    
    %Image after Point transform
    subplot(223)
    Y=f(floor(100*X)+1);
    imshow(Y)
    title('Point Transform image')
    
    %Histogram after Poin Transform
    subplot(224)
    [hn , hx ] = hist(Y(:), 0:1/255:1);
    bar(hx,hn)
    title('Poin Transform Histogram')
    
%When the values of y1 and y2 are 0     
else 
    
    %Create an array of zeros
    sz= size(r);
    z=zeros(sz);
    
    %Make pixels greater than 0.5 equal to 1 according to the unitstep
    %function 
    z(r>=x1)=1;
    figure
    
    %Original Image
    subplot(221)
    imshow(X)
    title('Original image')
    
    %Z(r) plot
    subplot(222)
    plot(r , z)
    title('z(r)' );
    
    %Image after Clipping transform
    subplot(223)
    Y=z(floor(100*X)+1);
    imshow(Y)
    title('Clipping Transform image')
    
    %Histogram after Clipping Transform
    subplot(224)
    [hn , hx ] = hist(Y(:), 0:1/255:1); 
    bar(hx,hn)
    title('Clipping Transform Histogram')
end
end