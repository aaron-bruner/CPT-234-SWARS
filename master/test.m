torpArr = [0 0 0 0];
fid = fopen('p1torps.txt', 'r');
torpArr = fscanf(fid, '%f %f %f %f', torpArr(size(torpArr,1),:));
fclose(fid);
disp(torpArr);