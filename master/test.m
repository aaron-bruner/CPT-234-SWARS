x = [1 2 3 4; 6 7 8 9; 10 11 12 13; 0 0 0 0];
writematrix(x,'test.txt','Delimiter','space');

fid = fopen('test.txt', 'r');
torpArr = fscanf(fid, '%f', [4 inf])';
fclose(fid);
disp(torpArr);