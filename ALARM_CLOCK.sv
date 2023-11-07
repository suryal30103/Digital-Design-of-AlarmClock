module ALARM_CLOCK(
    input reg clock,
    input reg reset,
    input reg set_time,
    input reg set_alarm,
    input reg [3:0] hours,
    input reg [5:0] minutes,
    input reg [3:0] alarm_hours,
    input reg [5:0] alarm_minutes,
    output reg alarm_ringing
);

    // State machine for the alarm clock
    localparam [2:0] 
        IDLE = 3'b000,
        SET_TIME = 3'b001,
        SET_ALARM = 3'b010,
        ACTIVE = 3'b011;
    

    reg [2:0] state, next_state;
    reg [2:0] state_reg;
    reg alarm_set;
    reg [3:0] current_hours;
    reg [5:0] current_minutes;
   
    // Registers for time and alarm settings
    always_ff @(posedge clock or posedge reset) begin
        if (reset)
            alarm_set <= 1'b0;
        else if (set_alarm)
            alarm_set <= 1'b1;
    end

    always_ff @(posedge clock or posedge reset) begin
        if (reset)
            state_reg <= IDLE;
        else
            state_reg <= next_state;
    end
   
    // Logic to update the state
    always_ff @(posedge clock or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end
   
    always_ff @(posedge clock or posedge reset) begin
        if (reset)
            current_hours <= 4'b0000;
        else if (set_time)
            current_hours <= hours;
    end

    always_ff @(posedge clock or posedge reset) begin
        if (reset)
            current_minutes <= 6'b000000;
        else if (set_time)
            current_minutes <= minutes;
    end

    // Next state logic
    always_ff @(posedge clock) begin
        case(state_reg)
            IDLE:
                if (set_time)
                    next_state = SET_TIME;
                else if (set_alarm)
                    next_state = SET_ALARM;
                else
                    next_state = IDLE;
           
            SET_TIME:
                next_state = set_alarm ? SET_ALARM : ACTIVE;
           
            SET_ALARM:
                next_state = set_time ? SET_TIME : ACTIVE;
           
            ACTIVE:
                next_state = (current_hours == alarm_hours) && (current_minutes == alarm_minutes) ? ACTIVE : IDLE;
        endcase
    end

    // Output alarm_ringing signal when the alarm is active
    always_ff @(posedge clock) begin
        alarm_ringing <= (state == ACTIVE) && alarm_set;
    end

endmodule



