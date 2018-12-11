surface = zeros(10,15);
colours = zeros(10,15);
[dimThk,dimCam] = meshgrid(4:18,0:9);
for i = 1:150
    camber = (ceil(i/15) - 1);
    thickness = (mod(i-1,15)+4);
    thicknessstr = num2str(thickness, '%02i');
    name = sprintf('naca%i4%spolar.txt', camber,thicknessstr);
    fprintf('\b ');
    file = fopen(name,'r');
    temp = textscan(file,'%f %f %f %f %f %f %f','HeaderLines',12);
    Cd = temp{3};
    alfa = temp{1};
    if isempty(Cd) == true
        Cd = NaN;
        alfa = 0;
    end
    fclose(file);
    surface((camber + 1),(thickness - 3)) = Cd;
    colours((camber + 1),(thickness - 3)) = alfa;
end
minimum = max(surface);
figure;
grid on;
surf(dimCam,dimThk,surface,colours);
title('Cd vs Max Camber and Thickness at cruise velocity');
xlabel('Camber');
ylabel('Thickness');
zlabel('Cd');
set(gca,'Zdir','reverse');