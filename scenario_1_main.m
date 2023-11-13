function scenario_1_main
clc
[allData, scenario, sensors] = scenario_1_function();
plot(scenario)
disp(sensors(1))
time = 0;
while advance(scenario)
    time = time + 1;
    pause(0.05)
    radar = sensors(1);
    detections = allData.ObjectDetections;
    disp(detections)
   
end
