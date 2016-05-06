function [ R ] = getRegions( img )
%GETREGIONS Return 4 regions of the image
%   The regions are stored in a matrix of ?:?:4 and returned

% Lecture de la taille de l'image
[height, width] = size(img);

Rwidth = width / 2;
Rheight = height / 2;

% On boucle sur les 4 Region
count = 1;
R = zeros(Rheight,Rwidth,4); % Pour de meilleur performance,
% pr�-allocation et conversion en uint8 pour correspondre aux donn�es
% de l'image
for j = 0:1
    for i = 0:1
        % B = imcrop(A,[xmin ymin width height]);
        % On prendra successivement la Region en haut � gauche, droite; en
        % bas � gauche, droite
        R(:,:,count) = imcrop(img, [i*Rwidth+(i*1) j*Rheight+(j*1) ...
            Rwidth Rheight]);
        count = count + 1;
    end
end

end

