function [scenario, egoVehicle] = scenario_traffic_light_final_CAV()
% createDrivingScenario Returns the drivingScenario defined in the Designer

% Generated by MATLAB(R) 9.10 (R2021a) and Automated Driving Toolbox 3.3 (R2021a).
% Generated on: 29-Nov-2023 12:27:46

% Construct a drivingScenario object.
scenario = drivingScenario('StopTime', 18, ...
    'SampleTime', 0.1);

% Add all road segments
roadCenters = [60 0 0;
    -60 0 0];
marking = [laneMarking('Solid')
    laneMarking('Dashed')
    laneMarking('DoubleSolid', 'Color', [0.98 0.86 0.36])
    laneMarking('Dashed')
    laneMarking('Solid')];
laneSpecification = lanespec(4, 'Marking', marking);
road(scenario, roadCenters, 'Lanes', laneSpecification, 'Name', 'Road');

roadCenters = [0 60 0;
    0 -60 0];
marking = [laneMarking('Solid')
    laneMarking('Dashed')
    laneMarking('DoubleSolid', 'Color', [0.98 0.86 0.36])
    laneMarking('Dashed')
    laneMarking('Solid')];
laneSpecification = lanespec(4, 'Marking', marking);
road(scenario, roadCenters, 'Lanes', laneSpecification, 'Name', 'Road1');

roadCenters = [8.5 -47.5 0;
    9.8 -23.7 0;
    16.3 -11.2 0;
    28.3 -9 0;
    41.4 -8.7 0;
    59.8 -8.6 0];
laneSpecification = lanespec(1, 'Width', 2.85);
road(scenario, roadCenters, 'Lanes', laneSpecification, 'Name', 'Road2');

% Add the ego vehicle
egoVehicle = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [-53.34 -2 0.01], ...
    'FrontOverhang', 0.9, ...
    'Wheelbase', 2.8, ...
    'Name', 'Car');
waypoints = [-53.34 -2 0.01;
    -44.49 -2 0.01;
    -17.56 -2 0.01;
    -13.2 -2 0.01;
    -10.16 -2 0.01;
    -9.32 -1.96 0.01;
    1.88 9.03 0.01;
    1.9 9.7 0.01;
    1.9 14.76 0.01;
    1.9 23.19 0.01;
    1.9 52 0];
speed = 9;
trajectory(egoVehicle, waypoints, speed);

% Add the non-ego actors
car1 = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [-35 -2 0], ...
    'FrontOverhang', 0.9, ...
    'Wheelbase', 2.8, ...
    'PlotColor', [196 87 14] / 255, ...
    'Name', 'Car1');
waypoints = [-35 -2 0;
    50 -2 0];
speed = [9;9];
waittime = [0;0];
trajectory(car1, waypoints, speed, waittime);

car2 = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [-2 50 0], ...
    'FrontOverhang', 0.9, ...
    'Wheelbase', 2.8, ...
    'PlotColor', [15 255 255] / 255, ...
    'Name', 'Car2');
waypoints = [-2 50 0;
    -2 10 0;
    -2 2 0;
    -2 1 0;
    -2 -2 0;
    -2 -50 0];
speed = [5;5;3;2.5;3;5];
waittime = [0;0;0;0;0;0];
trajectory(car2, waypoints, speed, waittime);

truck = vehicle(scenario, ...
    'ClassID', 2, ...
    'Length', 8.2, ...
    'Width', 2.5, ...
    'Height', 3.5, ...
    'Position', [5.86605155684683 -28.8568268351043 0], ...
    'Mesh', driving.scenario.truckMesh, ...
    'PlotColor', [0 0.447 0.741], ...
    'Name', 'Truck');
waypoints = [5.86605155684683 -28.8568268351043 0;
    5.2 -12.2 0;
    5.1 -2.1 0;
    5.5 10.6 0;
    6 20.4 0;
    6 28 0];
speed = [30;30;30;30;30;30];
trajectory(truck, waypoints, speed);

car = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [23.3 5.6 0], ...
    'Mesh', driving.scenario.carMesh, ...
    'PlotColor', [0.85 0.325 0.098], ...
    'Name', 'Car');
waypoints = [23.3 5.6 0;
    18.6 5.8 0;
    12.6 5.8 0;
    6.7 5.9 0;
    0.1 5.9 0;
    -8.4 5.8 0;
    -17.1 6 0;
    -24.6 6 0;
    -30.7 6 0];
speed = [30;30;30;30;30;30;30;30;30];
trajectory(car, waypoints, speed);

car1 = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [5.6 -54.5 0], ...
    'Mesh', driving.scenario.carMesh, ...
    'PlotColor', [0.929 0.694 0.125], ...
    'Name', 'Car1');
waypoints = [5.6 -54.5 0;
    5.6 -44.9 0;
    6.8 -39.2 0;
    8.3 -32.8 0;
    10.1 -23 0;
    12.6 -14.5 0;
    16 -11.9 0;
    21.9 -9.9 0;
    27.1 -8.6 0;
    32.3 -8.6 0;
    38 -8.5 0;
    43.6 -8.5 0;
    50.5 -8.5 0;
    59.7 -8.1 0];
speed = [30;30;30;30;30;30;30;30;30;30;30;30;30;30];
trajectory(car1, waypoints, speed);

