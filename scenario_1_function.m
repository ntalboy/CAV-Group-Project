function [allData, scenario, sensors] = scenario_1_test()
%scenario_1_test - Returns sensor detections
%    allData = scenario_1_test returns sensor detections in a structure
%    with time for an internally defined scenario and sensor suite.
%
%    [allData, scenario, sensors] = scenario_1_test optionally returns
%    the drivingScenario and detection generator objects.

% Generated by MATLAB(R) 23.2 (R2023b) and Automated Driving Toolbox 23.2 (R2023b).
% Generated on: 13-Nov-2023 08:53:52

% Create the drivingScenario object and ego car
[scenario, egoVehicle] = createDrivingScenario;

% Create all the sensors
[sensors, numSensors] = createSensors(scenario);

allData = struct('Time', {}, 'ActorPoses', {}, 'ObjectDetections', {}, 'LaneDetections', {}, 'PointClouds', {}, 'INSMeasurements', {});
running = true;
while running

    % Generate the target poses of all actors relative to the ego vehicle
    poses = targetPoses(egoVehicle);
    time  = scenario.SimulationTime;

    objectDetections = {};
    laneDetections   = [];
    ptClouds = {};
    insMeas = {};
    isValidTime = false(1, numSensors);

    % Generate detections for each sensor
    for sensorIndex = 1:numSensors
        sensor = sensors{sensorIndex};
        [objectDets, isValidTime(sensorIndex)] = sensor(poses, time);
        numObjects = length(objectDets);
        objectDetections = [objectDetections; objectDets(1:numObjects)]; %#ok<AGROW>
    end

    % Aggregate all detections into a structure for later use
    if any(isValidTime)
        allData(end + 1) = struct( ...
            'Time',       scenario.SimulationTime, ...
            'ActorPoses', actorPoses(scenario), ...
            'ObjectDetections', {objectDetections}, ...
            'LaneDetections', {laneDetections}, ...
            'PointClouds',   {ptClouds}, ... %#ok<AGROW>
            'INSMeasurements',   {insMeas}); %#ok<AGROW>
    end

    % Advance the scenario one time step and exit the loop if the scenario is complete
    running = advance(scenario);
end

% Restart the driving scenario to return the actors to their initial positions.
restart(scenario);

% Release all the sensor objects so they can be used again.
for sensorIndex = 1:numSensors
    release(sensors{sensorIndex});
end

%%%%%%%%%%%%%%%%%%%%
% Helper functions %
%%%%%%%%%%%%%%%%%%%%

% Units used in createSensors and createDrivingScenario
% Distance/Position - meters
% Speed             - meters/second
% Angles            - degrees
% RCS Pattern       - dBsm

function [sensors, numSensors] = createSensors(scenario)
% createSensors Returns all sensor objects to generate detections

% Assign into each sensor the physical and radar profiles for all actors
profiles = actorProfiles(scenario);
sensors{1} = drivingRadarDataGenerator('SensorIndex', 1, ...
    'MountingLocation', [3.7 0 0.2], ...
    'RangeLimits', [0 100], ...
    'TargetReportFormat', 'Detections', ...
    'Profiles', profiles);
sensors{2} = drivingRadarDataGenerator('SensorIndex', 2, ...
    'MountingLocation', [-1 0 0.2], ...
    'MountingAngles', [-180 0 0], ...
    'RangeLimits', [0 100], ...
    'TargetReportFormat', 'Detections', ...
    'Profiles', profiles);
sensors{3} = ultrasonicDetectionGenerator('SensorIndex', 3, ...
    'MountingLocation', [0 -0.9 0.2], ...
    'MountingAngles', [-90 0 0], ...
    'Profiles', profiles);
sensors{4} = ultrasonicDetectionGenerator('SensorIndex', 4, ...
    'MountingLocation', [0 0.9 0.2], ...
    'MountingAngles', [90 0 0], ...
    'Profiles', profiles);
sensors{5} = visionDetectionGenerator('SensorIndex', 5, ...
    'SensorLocation', [3.7 0], ...
    'MaxRange', 100, ...
    'DetectorOutput', 'Objects only', ...
    'Intrinsics', cameraIntrinsics([1814.81018227767 1814.81018227767],[320 240],[480 640]), ...
    'ActorProfiles', profiles);
numSensors = 5;

function [scenario, egoVehicle] = createDrivingScenario
% createDrivingScenario Returns the drivingScenario defined in the Designer

% Construct a drivingScenario object.
scenario = drivingScenario;

% Add all road segments
roadCenters = [-50.2 2.8 0;
    27.1 -4.9 0;
    41.15 -1.41 0];
marking4 = [laneMarking('Solid', 'Color', [0.98 0.86 0.36])
    laneMarking('Dashed')
    laneMarking('Dashed')];






marking10 = [laneMarking('Solid', 'Color', [0.98 0.86 0.36])
    laneMarking('Dashed')
    laneMarking('Dashed')];

laneSpecifications = [lanespec(2)
    lanespec(2)
    lanespec(2)
    lanespec(2, 'Marking', marking4)
    lanespec(2)
    lanespec(3)
    lanespec(3)
    lanespec(3)
    lanespec(3)
    lanespec(2, 'Marking', marking10)];
lsConnector = [laneSpecConnector('TaperShape', 'None')
    laneSpecConnector('TaperLength', 6)
    laneSpecConnector('TaperLength', 6)
    laneSpecConnector('TaperShape', 'None')
    laneSpecConnector('Position', 'Right', 'TaperShape', 'None')
    laneSpecConnector('TaperShape', 'None')
    laneSpecConnector('TaperShape', 'None')
    laneSpecConnector('TaperShape', 'None')
    laneSpecConnector('Position', 'Right', 'TaperLength', 6)];
compLaneSpecification = compositeLaneSpec(laneSpecifications, 'Connector', lsConnector);
road(scenario, roadCenters, 'Lanes', compLaneSpecification, 'Name', 'Road');

roadCenters = [-48.4 -26.1 0;
    -18.7 -13 0;
    8.3 -10.6 0];
marking9 = [laneMarking('Solid', 'Color', [0.98 0.86 0.36])
    laneMarking('Dashed')];


laneSpecifications = [lanespec(1, 'Width', 6)
    lanespec(1, 'Width', 6)
    lanespec(1, 'Width', 6)
    lanespec(1, 'Width', 6)
    lanespec(1, 'Width', 6)
    lanespec(1, 'Width', 6)
    lanespec(1, 'Width', 6)
    lanespec(1, 'Width', 6)
    lanespec(1, 'Width', 6, 'Marking', marking9)
    lanespec(1, 'Width', 6)];
lsConnector = [laneSpecConnector('TaperShape', 'None')
    laneSpecConnector('TaperShape', 'None')
    laneSpecConnector('TaperShape', 'None')
    laneSpecConnector('TaperShape', 'None')
    laneSpecConnector('TaperShape', 'None')
    laneSpecConnector('TaperShape', 'None')
    laneSpecConnector('TaperShape', 'None')
    laneSpecConnector('TaperShape', 'None')
    laneSpecConnector('TaperLength', 4)];
compLaneSpecification = compositeLaneSpec(laneSpecifications, 'Connector', lsConnector);
road(scenario, roadCenters, 'Lanes', compLaneSpecification, 'Name', 'Road1');

roadCenters = [40.66 -1.8 0;
    72.46 9.6 0];
laneSpecification = lanespec(2);
road(scenario, roadCenters, 'Lanes', laneSpecification, 'Name', 'Road2');

% Add the ego vehicle
egoVehicle = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [-18.7 -6.2 0], ...
    'Mesh', driving.scenario.carMesh, ...
    'Name', 'Car');
waypoints = [-18.7 -6.2 0;
    -10.66 -7.58 0.01;
    10.06 -8.42 0.01;
    23.14 -6.29 0.01;
    31.07 -2.35 0.01;
    37.15 -0.66 0.01;
    58.5 6.2 0;
    70.1 10.7 0];
speed = [30;30;30;30;30;30;30;30];
trajectory(egoVehicle, waypoints, speed);

% Add the non-ego actors
car1 = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [-22.46 -14.15 0], ...
    'Mesh', driving.scenario.carMesh, ...
    'Name', 'Car1');
waypoints = [-22.46 -14.15 0;
    -13.26 -11.85 0;
    -3.46 -11.25 0;
    4.04 -11.85 0;
    19.94 -11.35 0;
    27.4 -9.9 0;
    31.89 -6.26 0.01;
    36.6 -4.37 0.01;
    51.49 0.55 0.01;
    65.37 4.91 0.01];
speed = [30;30;30;30;30;30;30;30;30;30];
trajectory(car1, waypoints, speed);

truck = vehicle(scenario, ...
    'ClassID', 2, ...
    'Length', 8.2, ...
    'Width', 2.5, ...
    'Height', 3.5, ...
    'Position', [-39.9883024863742 -1.34923624194915 0], ...
    'RearOverhang', 1, ...
    'FrontOverhang', 0.9, ...
    'Mesh', driving.scenario.truckMesh, ...
    'Name', 'Truck');
waypoints = [-39.9883024863742 -1.34923624194915 0;
    -7.7 -7.8 0;
    11.7 -8.4 0;
    22.34 -6.79 0.01;
    35.3 -4.4 0;
    70.8 7.1 0];
speed = [25;25;25;25;25;25];
trajectory(truck, waypoints, speed);

truck1 = vehicle(scenario, ...
    'ClassID', 2, ...
    'Length', 8.2, ...
    'Width', 2.5, ...
    'Height', 3.5, ...
    'Position', [-6.1 -7.3 0], ...
    'RearOverhang', 1, ...
    'FrontOverhang', 0.9, ...
    'Mesh', driving.scenario.truckMesh, ...
    'Name', 'Truck1');
waypoints = [-6.1 -7.3 0;
    11.2 -8.4 0;
    26.4 -7 0;
    43.3 -2.9 0;
    69.2 6.3 0];
speed = [30;30;30;30;30];
trajectory(truck1, waypoints, speed);

