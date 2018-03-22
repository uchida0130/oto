function array = readfloat(filename)
%
%
fd = fopen(filename,'rb');
array = fread(fd,'float');
fclose(fd);
