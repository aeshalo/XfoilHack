surface = zeros(10,15);
colours = zeros(10,15);
[dimThk,dimCam] = meshgrid(4:18,0:9);
for i = 1:150
    camber = (ceil(i/15) - 1);
    thickness = (mod(i-1,15)+4);
    thicknessstr = num2str(thickness, '%02i');
    name = sprintf('naca%i4%spolarl.txt', camber,thicknessstr);
    fprintf('\b ');
    file = fopen(name,'r');
    temp = textscan(file,'%f %f %f %f %f %f %f','HeaderLines',12);
    fclose(file);
    Cd = temp{3};
    alfa = temp{1};
    if isempty(Cd) == true
        Cd = NaN;
        temp = 0;
        disp(name);
        delete(name);
    end
    if Cd >= 0.05;
        Cd = NaN;
        alfa = NaN;
    end
    if alfa == 100
        alfa = NaN;
    end
    surface((camber + 1),(thickness - 3)) = Cd;
    colours((camber + 1),(thickness - 3)) = alfa;
end
minimum = max(surface);
figure;
grid on;
surf(dimCam,dimThk,surface,colours);
title('Cd vs Max Camber and Thickness at Loiter velocity');
xlabel('Camber');
ylabel('Thickness');
zlabel('Cd');
set(gca,'Zdir','reverse');