function dataset_mat2dat(X, aoa)
format short
[nSamples, nVar] = size(X);
X = [X, ones(nSamples,1)*aoa];
X = round(X,3,'significant');
writeDate = date();
%Function saves the matrix format into a .dat file    
fid = fopen("variables.dat","w");
array_length = size(X(:,1));

for i=1:array_length(1,1) % X = [height, spacing, sigma, angle of attack]
	fprintf(fid,'%4.3f\t%4.3f\t%4.3f\t%2.3f\n',X(i,1),X(i,2),X(i,3),X(i,4));
end
fclose(fid);
end
