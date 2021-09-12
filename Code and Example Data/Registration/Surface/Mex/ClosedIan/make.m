function make
DIR=getenv('SURFACE');
%INCDIR='C:/Program Files/Surface/include';
INCDIR=[DIR '\include'];
LIBDIR=[DIR '\lib'];
%LIBDIR='C:/Program Files/Surface/lib';
LIB='ClosedIan';

files=dir('*.cpp');

for i=1:length(files)
    fprintf('Building %s\n', files(i).name);
    mex(['-I' INCDIR], ['-L' LIBDIR], ['-l' LIB], files(i).name);
end
