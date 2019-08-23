%% Hausdorff Distance: Compute the Hausdorff distance between two point clouds.
% Let A and B be subsets of a metric space (Z,dZ), 
% The Hausdorff distance between A and B, denoted by dH (A, B), is defined by:
% dH (A, B)=max{sup dz(a,B), sup dz(b,A)}, for all a in A, b in B,
% dH(A, B) = max(h(A, B),h(B, A)),  
% where h(A, B) = max(min(d(a, b))),  
% and d(a, b) is a L2 norm. 
% dist_H = hausdorff( A, B ) 
% A: First point sets. 
% B: Second point sets. 
% ** A and B may have different number of rows, but must have the same number of columns. ** 
% Hassan RADVAR-ESFAHLAN; Universit� du Qu�bec; �TS; Montr�al; CANADA 
% 15.06.2010
%%
function [mhd] = HausdorffDistance( pc1, pc2) 
  A = (pc1.Location);
  B = (pc2.Location);
  A(isnan(A))=0;
  B(isnan(B))=0;
 Asize = size(A);
Bsize = size(B);

% Check if the points have the same dimensions
% if Asize(2) ~= Bsize(2)
%     error('The dimensions of points in the two sets are not equal');
% end

% Calculating the forward HD

fhd = 0;                    % Initialize forward distance to 0
for a = 1:Asize(1)          % Travel the set A to find avg of d(A,B)
    mindist = Inf;          % Initialize minimum distance to Inf
    n=Bsize(1);
    a1 = zeros(1,n);
    for b = 1:n      % Travel set B to find the min(d(a,B))
        a1(b) = norm(A(a,:)-B(b,:));
    end
    mindist = min(a1);
    fhd = fhd + mindist;    % Sum the forward distances
end
fhd = fhd/Asize(1);         % Divide by the total no to get average

% Calculating the reverse HD

rhd = 0;                    % Initialize reverse distance to 0
for b = 1:Bsize(1)          % Travel the set B to find avg of d(B,A)
    n=Asize(1);
    b1 = zeros(1,n);      % Initialize minimum distance to Inf
    
    for a = 1:n      % Travel set A to find the min(d(b,A))
        b1(a) = norm(A(a,:)-B(b,:));
    end
    mindist = min(b1);
    rhd = rhd + mindist;    % Sum the reverse distances
end
rhd = rhd/Bsize(1);         % Divide by the total no. to get average

mhd = max(fhd,rhd);         % Find the minimum of fhd/rhd as 
                            % the mod hausdorff dist


end


