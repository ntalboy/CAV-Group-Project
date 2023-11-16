function scenario_1_main
clc
close all
[allData, scenario, sensors] = scenario_1_function();
plot(scenario)
disp(sensors(1))
time = 0;
while advance(scenario)
    time = time + 1;
    pause(0.05)

    % % allData fields
    % disp('allData:')
    % disp(class(allData))
    % disp(allData)

    % % Time - for some reason this is always 0?
    % % simulation time is in scenario struct
    % Time = allData.Time;
    % disp('simulation time:')
    % disp(class(Time))
    % disp(Time)

    % ActorPoses = allData.ActorPoses;
    % ActorID = ActorPoses.ActorID;
    % Position = ActorPoses.Position;
    % Velocity = ActorPoses.Velocity;
    % 
    % disp('ActorPoses:')
    % disp(class(ActorPoses))
    % disp(ActorPoses)
    % disp('Position:')
    % disp(class(Position))
    % disp(Position)
    % disp('Velocity:')
    % disp(class(Velocity))
    % disp(Velocity)


    % sensor detections
    ObjectDetections = allData.ObjectDetections;
    Detection = ObjectDetections{1};
    Measurement = Detection.Measurement;
    ObjectAttributes = Detection.ObjectAttributes;
    ObjectAttributes = ObjectAttributes{1};
     
    disp('ObjectDetections:')
    disp(class(Detection))
    disp(Detection)
    fprintf('Measurement:\n');
    disp(class(Measurement))
    disp(Measurement)
    disp('ObjectAttributes:')
    disp(class(ObjectAttributes))
    disp(ObjectAttributes)

    % LaneDetections = allData.LaneDetections;
    % 
    % disp('LaneDetections:')
    % disp(class(LaneDetections))
    % disp(LaneDetections) % doesn't display or is null? 0 detections
    % 
    % PointClouds = allData.PointClouds;
    % % PointClouds = PointClouds{1}; % no point clouds are in the cell
    % 
    % disp('PointClouds:')
    % disp(class(PointClouds))
    % disp(PointClouds)
    % 
    % % This one is also an empty cell
    % INSMeasurements = allData.INSMeasurements;
    % 
    % disp('INSMeasurements')
    % disp(class(INSMeasurements))
    % disp(INSMeasurements)

    % % scenario data
    % disp('scenario:')
    % disp(class(scenario))
    % disp(scenario)
    % Actors = scenario.Actors;
    % FrontOverhang = Actors.FrontOverhang;
    % RearOverhang = Actors.RearOverhang;
    % Wheelbase = Actors.Wheelbase;
    % EntryTime = Actors.EntryTime;
    % ExitTime = Actors.ExitTime;
    % ActorID = Actors.ActorID;
    % ClassID = Actors.ClassID;
    % Name = Actors.Name;
    % PlotColor = Actors.PlotColor;
    % Position = Actors.Position;
    % Velocity = Actors.Velocity;
    % Yaw = Actors.Yaw;
    % Pitch = Actors.Pitch;
    % Roll = Actors.Roll;
    % AngularVelocity = Actors.AngularVelocity;
    % Length = Actors.Length;
    % Width = Actors.Width;
    % Height = Actors.Height;
    % Mesh = Actors.Mesh;
    % RCSPattern = Actors.RCSPattern;
    % RCSAzimuthAngles = Actors.RCSAzimuthAngles;
    % RCSElevationAngles = Actors.RCSElevationAngles;

    % disp('Actors:')
    % disp(class(Actors))
    % disp(Actors)
    % disp('settings:')
    % disp(FrontOverhang)
    % disp(RearOverhang)
    % disp(Wheelbase)
    % disp(EntryTime)
    % disp(ExitTime)
    % disp(ActorID)
    % disp(ClassID)
    % disp(Name)
    % disp(PlotColor)
    % disp(Position)
    % disp(Velocity)
    % disp(Yaw)
    % disp(Pitch)
    % disp(Roll)
    % disp(AngularVelocity)
    % disp(Length)
    % disp(Width)
    % disp(Height)
    % disp(Mesh)
    % disp(RCSPattern)
    % disp(RCSAzimuthAngles)
    % disp(RCSElevationAngles)


    % % sensor generators
    % radar = sensors(1);
    % radar = radar{1};
    % disp('sensors:')
    % disp(class(sensors))
    % disp(sensors)
    % disp('radar sensors:')
    % disp(class(radar))
    % disp(radar)

end
