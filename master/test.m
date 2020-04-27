testpos = [1 1 3 3];
fid = fopen('test.txt', 'r');
testpos = fscanf(fid, '%f', [2 1])';
fclose(fid);