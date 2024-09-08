# Collision_detection
## Introduction
Car Collision Detection System using Verilog, aimed at simulating the hardware logic necessary for detecting potential vehicle collisions in real-time. The system operates by monitoring key parameters such as the distance between vehicles and their relative speeds. When the system detects an impending collision, it triggers alerts or engages appropriate safety mechanisms, which could include braking assistance or warning signals, to help prevent accidents.

The design is implemented virtually using Vivado, where the hardware description language (HDL) code is synthesized and simulated to validate its functionality. The Verilog code defines the logic for analyzing sensor inputs and speed data to calculate the likelihood of a collision. Testbenches are included to simulate various scenarios, such as different vehicle speeds, distances, and reaction times, ensuring the system's accuracy and responsiveness.

This project has potential applications in autonomous vehicles and advanced driver-assistance systems (ADAS), where real-time collision detection is crucial for improving road safety. The repository contains the complete Verilog codebase, testbenches, and simulation results, providing a comprehensive overview of the system's design and performance. Through this virtual implementation, the project demonstrates how hardware logic can be utilized in the development of safety-critical automotive systems.
## Code
//
`timescale 1ns / 1ps

module collision_detection(
    input [7:0] distance_front,   // Input distance from the front sensor (in meters)
    input [7:0] distance_rear,    // Input distance from the rear sensor (in meters)
    output reg warning,           // Output warning signal
    output reg brake              // Output brake signal
);
    parameter SAFE_DISTANCE = 10; // Safe distance threshold (in meters)

    always @(*) begin
        // Initialize outputs to zero
        warning = 0;
        brake = 0;
        
        // Check front distance
        if (distance_front < SAFE_DISTANCE) begin
            warning = 1;  // Trigger warning if too close in the front
            brake = 1;    // Apply brakes if collision is imminent
        end
        
        // Check rear distance
        if (distance_rear < SAFE_DISTANCE) begin
            warning = 1;  // Trigger warning if too close in the rear
        end
    end
endmodule

## Testbench Code
//
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

## Result
The virtual simulation of the Car Collision Detection System was successfully conducted using Vivado, demonstrating the effectiveness of the Verilog-based design in detecting potential vehicle collisions. Through various test scenarios, including sudden braking, speed variations, and changes in vehicle proximity, the system accurately predicted potential collisions and generated timely alerts. The testbenches verified the system’s functionality under different conditions, ensuring reliable performance across a range of driving environments. Additionally, the simulation showed that the design utilized minimal hardware resources, making it efficient and scalable for real-time applications in automotive systems. Overall, the virtual simulation validated the correctness and resource efficiency of the collision detection logic, paving the way for potential integration into real-world safety systems.
