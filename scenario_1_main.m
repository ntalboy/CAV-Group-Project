function scenario_1_main
clc
close all
[allData, scenario, sensors] = scenario_1_function();
plot(scenario)

detectionsIndex = 1;
ObjectDetections = allData(1).ObjectDetections;
numDetections = length(ObjectDetections);
if numDetections > 0
    if ObjectDetections{1}.Time == 0
        detectionsIndex = 2;
        fprintf('number of detections: %d\n',length(ObjectDetections))
        for i = 1:length(ObjectDetections)
            disp(ObjectDetections{i})
        end
    end
end
while advance(scenario)
    pause(0.05)
    
    fprintf('simulation time: %.2f\n',scenario.SimulationTime)
    % edge case when goes to last index
    if numDetections > detectionsIndex
        ObjectDetections = allData(detectionsIndex).ObjectDetections;
    else
        % set back to the beginning so that it won't run anymore
        continue
    end
    
    if ObjectDetections{1}.Time == scenario.SimulationTime
        detectionsIndex = detectionsIndex + 1;
        fprintf('number of detections: %d\n',length(ObjectDetections))
        for i = 1:length(ObjectDetections)
            disp(ObjectDetections{i})
        end
    end
    

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

end
