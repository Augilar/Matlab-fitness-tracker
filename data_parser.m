clear
load("walk.mat");

posTimeStamps = Position.Timestamp;
lat = Position.latitude;
lon = Position.longitude;
alt = Position.altitude;
sp = Position.speed;

positionTime = timeElapsed(posTimeStamps);

earthCirc = 40075;
totalDis = 0;
gPoints = [];

for i = 1: (length(lat)-1)
    lat1 = lat(i);
    lat2 = lat(i+1);
    lon1 = lon(i);
    lon2 = lon(i+1);
    
    diff = distance(lat1, lon1, lat2, lon2);
    dis = (diff/360)*earthCirc;
    
    totalDis = totalDis + dis;
    %gPoints = [gPoints; geopoint(lat(i), lon(i))];
    %kmlwritepoint("sample.kml", lat(i), lon(i), alt(i));
end
%gPoints.push(geopoint(lat(length(lat)), lon(length(lat))));
%kmlwritepoint("sample.kml", lat(length(lat)), lon(length(lat)), alt(length(lat)));
gPoints = geopoint(lat, lon);
kmlwrite("walk.kml", gPoints);
stride = 2.5; %avg feet for each step
disFeet = totalDis*3280.84;
steps = disFeet/stride;

disp("You have covered a distance of "+ num2str(totalDis)+ "kms");
disp("You have taken an approx of "+ num2str(steps)+ "steps");
disp("");

%plotting the path taken

plot(lon, lat, "*");

line(lon, lat);
