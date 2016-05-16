%% limitations:
% will not see that two satellite can communicate if they are "on top" of each other (the line joining them cross earth) but it seems to me that it should not prevent to find a solution if it exists. TBC
% probably fixed by the line visible = visible | visible', but there may be corner cases not covered

a = csvread('data_file');
R = 6371;	% earth radius

% format input
for i=2:21
	sat(i-1,:) = a(i,2:4);
end
% handle start/stop position as a satellite
sat(21,:) = [a(22,2:3) 0];
sat(22,:) = [a(22,4:5) 0];

% unit vector, given direction from center of earth to satellite
sat_dir = [...
	cosd(sat(:,2)).*cosd(sat(:,1)), ...
	sind(sat(:,2)).*cosd(sat(:,1)), ...
	sind(sat(:,1)) ];

% satellite positions in x/y/z cartesian
dist = R+sat(:,3);
sat_pos = sat_dir .* repmat(dist,1,3);

% angle between satellite direction and line tangent to earth passing through the sat
alpha_max = atand(sqrt(1./((dist/R).^2-1)));
alpha_max = 180-alpha_max;	% should I done the computation with the earth on the left side of y axis, not the right side

for i=1:22
	dir = sat_pos - repmat(sat_pos(i,:), 22, 1);
	n_dir = sum(dir.^2, 2).^.5;
	dir = dir./repmat(n_dir, 1, 3);
	angle(i,:) = acosd(dir * sat_dir(i,:)')';
	visible(i,:) = angle(i,:) < alpha_max(i);
end

% add reverse path from sat to ground stations, and some case with sat on top of each other
%visible(:,21) = visible(21,:)';
%visible(:,22) = visible(22,:)';
visible = visible | visible';

% get path with smallest number of satellites
paths = BFS(visible, 21, 22);
path = [22];
while path(1) ~= 21
    path = [paths{path(1)} path];
end
path = path-1;  % 0 indexed

disp('Sat 20 is the origin, Sat 21 the destination')
disp(path)



