%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Algorithme de test
clear variables
close all
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                VARIABLES
%
pSize = 8;
overflow = 3;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Dict = getDataset();

% X = ones(size(Dict(1).set(1).img,1)*size(Dict(1).set(1).img,2), size(Dict,2)*size(Dict(1).set,2));

for i = 1:size(Dict,2) % Pour chaque 'class d'image'
    for j = 1:size(Dict(i).set, 2) % Pour chaque image d'une classe
        Rs = getRegions(Dict(i).set(j).img);
        
%         % Range tte les images en une grande matrice
%         tempImg = Dict(i).set(j).img;
%         index = size(Dict(i).set, 2)*(i-1)+j;
%         X(:,index) = tempImg(:);
        
        
        for k = 1:4 % Pour chaque r�gion d'une image
            patches = getPatches(Rs(:,:,k), pSize, overflow);
            patchNormDCT2 = normDct2(patches, true, true);
            % Line below does not affect time spent, dont waste time on
            % optimizing the allocation
            Class(i).img(j).R(k).patches = getLowFreqComp(patchNormDCT2);
            
            % TODO g�n�rer sparse code pour chaque patch, ATTENTION
            % v�rifier que c des positif, appliqu� absolu, sinon foir avec
            % la m�thode qui suit pour r�gion descriptor
            
            % apr�s g�n�ration sparse code, chaque r�gion est d�crite de la
            % fa�on suivante: hr = 1/Np * somme sparse vector de R
            % hr -> region descriptor
            % Np -> number of patch in current region
            % R -> current region
            
        end
    end
end

% % On test le dictionnaire
% opt = struct('K',32, 'samet','mexomp','saopt',struct('tnz',4));
% Ds = dictlearn_mb('X',X,opt);

%%% Computing the image similarities used the methods from LSED [24]
% simi -> computed similaritie, assumed the lower the better the
% correspondance
% sumR -> the sum of the formula ||hr[A] - hr[B]||1
% sumR = ...
% simi = 1/Rnbr * sum