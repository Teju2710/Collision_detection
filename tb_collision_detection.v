`timescale 1ns / 1ps



module tb_collision_detection();
    reg [7:0] distance_front;
    reg [7:0] distance_rear;
    wire warning;
    wire brake;

    // Instantiate the collision detection module
    collision_detection uut (
        .distance_front(distance_front),
        .distance_rear(distance_rear),
        .warning(warning),
        .brake(brake)
    );

    initial begin
        // Display output for each step
        $monitor("Time = %0d, Front = %0d, Rear = %0d, Warning = %b, Brake = %b",
                  $time, distance_front, distance_rear, warning, brake);
        
        // Scenario 1: Safe distances
        distance_front = 20;
        distance_rear = 20;
        #10;
        
        // Scenario 2: Close to the front vehicle
        distance_front = 5;
        distance_rear = 20;
        #10;
        
        // Scenario 3: Close to the rear vehicle
        distance_front = 20;
        distance_rear = 5;
        #10;

        // Scenario 4: Dangerously close to both front and rear
        distance_front = 5;
        distance_rear = 5;
        #10;

        // End simulation
        $finish;
    end
endmodule
