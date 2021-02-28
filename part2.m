%Load image , and convert it to gray-scale
x = imread('lena.bmp');
x = rgb2gray(x);

%Normalization at [0,1]
x = double(x) / 255 ;

%Case 1

L=10;
v1= linspace(0, 1, L);
h1 = ones([1, L]) / L;
Y1=histtransform(x, h1 ,v1 );        %Call function histtransform

figure('Name', 'Case 1');            %Display results
subplot(221)                         %Original Image 
imshow(x);
title('Original Image') 
subplot(222)                         %Original Histogram
[hn , hx ] = hist(x(:), 0:1/255:1);
bar(hx,hn)
title('Original Histogram')
subplot(223)                         %Transformed Image
imshow(Y1);
title('Transformed Image')
subplot(224)                         %Transformed Histogram
[hn , hx]=hist( Y1(:), 0:1/255:1); 
bar(hx,(hn/(256*256)));
title('Transformed Histogram')


%Case 2 

L = 20; 
v2 = linspace(0, 1, L); 
h2 = ones([1, L]) / L; 
Y2=histtransform(x, h2 ,v2 );        %Call function histtransform

figure('Name', 'Case 2');            %Display results
subplot(221)                         %Original Image
imshow(x);
title('Original Image')
subplot(222)                         %Original Histogram
[hn , hx ] = hist(x(:), 0:1/255:1);
bar(hx,hn)
title('Original Histogram')
subplot(223)                         %Transformed Image
imshow(Y2);
title('Transformed Image')
subplot(224)                         %Transformed Histogram
[hn , hx]=hist( Y2(:), 0:1/255:1); 
bar(hx,(hn/(256*256)));
title('Transformed Histogram')


%Case 3

L = 10; 
v3 = linspace(0, 1, L); 
h3 = normpdf(v3, 0.5) / sum(normpdf(v3, 0.5)); 
Y3=histtransform(x, h3 ,v3 );        %Call function histtransform

figure('Name', 'Case 3');            %Display results
subplot(221)                         %Original Image
imshow(x);
title('Original Image')
subplot(222)                         %Original Histogram
[hn , hx ] = hist(x(:), 0:1/255:1);
bar(hx,hn)
title('Original Histogram')
subplot(223)                        %Transformed Image
imshow(Y3);
title('Transformed Image')
subplot(224)                        %Transformed Histogram
[hn , hx]=hist( Y3(:), 0:1/255:1); 
bar(hx,(hn/(256*256)));
title('Transformed Histogram')

%Stin sunartisi metatrepw thn eikona apo pinaka 2D se 1D kai thn taksinomw.
%Meta gia kathe pixel elegxw tin sunthiki kai tou topothetw thn analogi
%timi (v(i) an isxuei alliws  v(i+1)). Telos metatrepv ton 1D se 2D kai
%epistrefw tin eikona.

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