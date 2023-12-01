function scenario_1_main
clc
close all
[allData, scenario, sensors] = scenario_traffic_light_final_CAV();
plot(scenario)

% start at 2 because index 1 time is zero, and simulation starts at 0.01
detectionsIndex = 1;
numDetections = length(allData);

while advance(scenario)
    pause(0.05)
    
    % fprintf('simulation time: %.2f\n',scenario.SimulationTime)
    % edge case when goes to last index
    if numDetections > detectionsIndex
        ObjectDetections = allData(detectionsIndex).ObjectDetections;
        numObjects = length(ObjectDetections);
    else
        % set back to the beginning so that it won't run anymore
        % disp('continuing')
        continue
    end
    
    if ObjectDetections{1}.Time <= scenario.SimulationTime
        detectionsIndex = detectionsIndex + 1;
        % fprintf('number of detections: %d\n',numObjects)
        

        
        for i = 1:numObjects
            xmeasurement = ObjectDetections{i}.Measurement(1);
            ymeasurement = ObjectDetections{i}.Measurement(2);
            distance = sqrt(xmeasurement^2 + ymeasurement^2);
            % disp(measurement)
            % disp(distance)
            if distance < 4
                if abs(xmeasurement) > abs(ymeasurement)
                    if xmeasurement > 0
                        disp('too close in front!')
                    else
                        disp('too close in back!')
                    end
                else
                    if ymeasurement > 0
                        disp('too close on left!')
                    else
                        disp('too close on right!')
                    end
                end
            end
        end 
    end
end
