%Load image , and convert it to gray-scale
x = imread('lena.bmp');
x = rgb2gray(x);

%Normalization at [0,1]
x = double(x) / 255 ;


%Uniform [0,1]

d=linspace(0,1,10);                     %number of cells
f1= @myuni1;                            %call Uniform function
h= pdf2hist(d, f1);                     %call Possibility function
v=[];                                   %v array changes 
for i= 1: size(d,2) -1
    v(i)= ((d(i) + d(i+1))/2);
end
Y1=histtransform(x, h, v);              %call Histtransform function

figure('Name', 'Uniform [0,1]');        %Display results
subplot(221)                            %Original Image 
imshow(x);
title('Original Image') 
subplot(222)                            %Original Histogram
[hn , hx ] = hist(x(:), 0:1/255:1);
bar(hx,hn)
title('Original Histogram')
subplot(223)                            %Transformed Image
imshow(Y1);
title('Transformed Image')
subplot(224)                            %Transformed Histogram
[hn , hx]=hist( Y1(:), 0:1/255:1); 
bar(hx,(hn/(256*256)));
title('Transformed Histogram')


%Uniform [0,2]

d=linspace(0,2,10);                     %number of cells
f2= @myuni2;                            %call Uniform function
h= pdf2hist(d, f2);                     %call Possibility function
v=[];
for i= 1: size(d,2) -1
    v(i)= ((d(i) + d(i+1))/(2*2));
end
Y2=histtransform(x, h, v);              %call Histtransform function

figure('Name', 'Uniform[0,2]');         %Display results
subplot(221)                            %Original Image
imshow(x);
title('Original Image')
subplot(222)                            %Original Histogram
[hn , hx ] = hist(x(:), 0:1/255:1);
bar(hx,hn)
title('Original Histogram')
subplot(223)                            %Transformed Image
imshow(Y2);
title('Transformed Image')
subplot(224)                            %Transformed Histogram
[hn , hx]=hist( Y2(:), 0:1/255:1); 
bar(hx,(hn/(256*256)));
title('Transformed Histogram')


%Normal

d=linspace(0,1,10);                     %number of cells
f3= @myuni3;                            %call Uniform function
h= pdf2hist(d, f3);                     %call Normal function
v=[];
for i= 1: size(d,2) -1
    v(i)= ((d(i) + d(i+1))/2);
end
Y3=histtransform(x, h, v);              %call Histtransform function

figure('Name', 'Normal');               %Display results
subplot(221)                            %Original Image
imshow(x);
title('Original Image')
subplot(222)                            %Original Histogram
[hn , hx ] = hist(x(:), 0:1/255:1);
bar(hx,hn)
title('Original Histogram')
subplot(223)                            %Transformed Image
imshow(Y3);
title('Transformed Image')
subplot(224)                            %Transformed Histogram
[hn , hx]=hist( Y3(:), 0:1/255:1); 
bar(hx,(hn/(256*256)));
title('Transformed Histogram')


%Function for Uniform [0,1]
function f1=myuni1(x)
f1=unifpdf(x, 0, 1);
end

%Function for Uniform [0,2]
function f2=myuni2(x)
f2=unifpdf(x, 0, 2);
end

%Function for Normal
function f3=myuni3(x)
f3=normpdf(x, 0.5, 0.1);
end


%Possibility function 
function h = pdf2hist(d, f) 

for i = 1 : (size(d,2)-1)
    h(i) = integral(f, d(i), d(i+1));
end

end

%2.1 function
function Y=histtransform(X, h ,v )

%Total size of array X
tsize= size(X,1)* size(X,2);

%Make 2D array in 1D
R= X(:);
R=R';

%Sort 1D array 
[~, idx]= sort(R);

%Number of pixels changed
Pcounter=0;

%Counter for v,h
counter=1;

%Change pixels value 
for i=1:size(R,2)
    
    if((Pcounter/tsize)< h(counter))    %check condition
        Pcounter = Pcounter +1;
        a=idx(i);                       %pixel's position in original array
        R(a)=v(counter);                %change this pixel's value
        
    else
        Pcounter=1; 
        counter=counter+1;
        a=idx(i);                       %pixel's position in original array
        R(a)=v(counter);                %change this pixel's value
    end
    
end

%Make 1D in 2D
M=reshape(R,256,256);
%Return image
Y=M;

end