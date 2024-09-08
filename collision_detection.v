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
