module ALARM_CLOCK_TB;
    reg clock, reset, set_time, set_alarm;
    reg [3:0] hours, alarm_hours;
    reg [5:0] minutes, alarm_minutes;
    wire alarm_ringing;

    // Instantiate the AlarmClock module
    ALARM_CLOCK u0 (
        .clock(clock),
        .reset(reset),
        .set_time(set_time),
        .set_alarm(set_alarm),
        .hours(hours),
        .minutes(minutes),
        .alarm_hours(alarm_hours),
        .alarm_minutes(alarm_minutes),
        .alarm_ringing(alarm_ringing)
    );

    // Clock generation
    always begin
        #5 clock = ~clock;
    end

    initial begin
        clock = 0;
        reset = 1;
        set_time = 0;
        set_alarm = 0;
        hours = 4'b0010; // Set time to 10:00
        minutes = 6'b000000;
        alarm_hours = 4'b0010; // Set alarm to 10:00
        alarm_minutes = 6'b000000;

	   //case-1
        // Reset the clock
        reset = 1;
        #10 reset = 0;

        // Test setting the time
        set_time = 0;
        #10 set_time = 1;
        hours = 4'b0110; 
        minutes = 6'b011010;
        #10 set_time = 0;
        #10 set_time = 0;

        // Test setting the alarm
        set_alarm = 0;
        #10 set_alarm = 1;
        alarm_hours = 4'b1001; 
        alarm_minutes = 6'b101110;
        #10 set_alarm = 1;
        #10 set_alarm = 0;

        
        set_time = 1;
        hours = 4'b1001; 
        minutes = 6'b101110;
        #10 set_time = 0;
        // Alarm should start ringing here
        if (alarm_ringing) $display("Alarm is ringing!");
        #10;
        // Alarm should stop ringing here
        if (!alarm_ringing) $display("Alarm stopped ringing!");
        
        //case-2
        clock = 0;
        reset = 1;
        set_time = 0;
        set_alarm = 1;
        // Reset the clock
        reset = 1;
        #10 reset = 0;

        // Test setting the time
        set_time = 0;
        #10 set_time = 1;
        hours = 4'b1001; // Set time to 06:00
        minutes = 6'b101110;
        #10 set_time = 1;
        #10 set_time = 0;

        // Test setting the alarm
        set_alarm = 0;
        #10 set_alarm = 1;
        alarm_hours = 4'b1001; // Set alarm to 09:00
        alarm_minutes = 6'b101110;
        #10 set_alarm = 1;
       // #10 set_alarm = 0;

        // Test the alarm functionality
        // The alarm should ring when the time matches the alarm time
        set_time = 1;
        hours = 4'b1001; // Set time to 09:00
        minutes = 6'b101110;
        //#10 set_time = 0;
        // Alarm should start ringing here
        if (alarm_ringing) $display("Alarm is ringing!");
        #10;
        // Alarm should stop ringing here
        if (!alarm_ringing) $display("Alarm stopped ringing!");
        
        //case-3
        clock = 0;
        reset = 0;
        set_time = 0;
        set_alarm = 1;
        // Reset the clock
        reset = 1;
        #10 reset = 0;

        // Test setting the time
        set_time = 0;
        #10 set_time = 1;
        hours = 4'b1001; // Set time to 06:00
        minutes = 6'b101110;
        #10 set_time = 1;
        #10 set_time = 0;

        // Test setting the alarm
        set_alarm = 0;
        #10 set_alarm = 1;
        alarm_hours = 4'b1001; // Set alarm to 09:00
        alarm_minutes = 6'b101110;
        #10 set_alarm = 1;
       // #10 set_alarm = 0;

        // Test the alarm functionality
        // The alarm should ring when the time matches the alarm time
        set_time = 1;
        hours = 4'b1111; // Set time to 09:00
        minutes = 6'b111110;
        //#10 set_time = 0;
        // Alarm should start ringing here
        if (alarm_ringing) $display("Alarm is ringing!");
        #10;
        // Alarm should stop ringing here
        if (!alarm_ringing) $display("Alarm stopped ringing!");
        
        //case-4
        clock = 0;
        reset = 1;
        set_time = 1;
        set_alarm = 0;
        // Reset the clock
        reset = 1;
        #10 reset = 0;

        // Test setting the time
        set_time = 0;
        #10 set_time = 1;
        hours = 4'b1001; // Set time to 06:00
        minutes = 6'b101110;
        #10 set_time = 1;
        #10 set_time = 0;

        // Test setting the alarm
        set_alarm = 0;
        #10 set_alarm = 0;
        alarm_hours = 4'b1011; // Set alarm to 09:00
        alarm_minutes = 6'b101010;
        #10 set_alarm = 0;
       // #10 set_alarm = 0;

        // Test the alarm functionality
        // The alarm should ring when the time matches the alarm time
        set_time = 1;
        hours = 4'b1111; // Set time to 09:00
        minutes = 6'b111110;
        //#10 set_time = 0;
        // Alarm should start ringing here
        if (alarm_ringing) $display("Alarm is ringing!");
        #10;
        // Alarm should stop ringing here
        if (!alarm_ringing) $display("Alarm stopped ringing!");
        
         //case-5
         clock = 0;
        reset = 1;
        set_time = 1;
        set_alarm = 1;
        // Reset the clock
        reset = 1;
        #10 reset = 0;

        // Test setting the time
        set_time = 0;
        #10 set_time = 0;
        hours = 4'b1001; // Set time to 06:00
        minutes = 6'b111010;
        #10 set_time = 0;
        #10 set_time = 0;

        // Test setting the alarm
        set_alarm = 1;
        #10 set_alarm = 0;
        alarm_hours = 4'b1001; // Set alarm to 09:00
        alarm_minutes = 6'b101110;
        #10 set_alarm = 0;
       // #10 set_alarm = 0;

        // Test the alarm functionality
        // The alarm should ring when the time matches the alarm time
        set_time = 1;
        hours = 4'b0110; // Set time to 09:00
        minutes = 6'b110110;
        //#10 set_time = 0;
        // Alarm should start ringing here
        if (alarm_ringing) $display("Alarm is ringing!");
        #10;
        // Alarm should stop ringing here
        if (!alarm_ringing) $display("Alarm stopped ringing!");
        
        //case-6
        clock = 0;
        reset = 1;
        set_time = 1;
        set_alarm = 0;
        // Reset the clock
        reset = 1;
        #10 reset = 0;

        // Test setting the time
        set_time = 0;
        #10 set_time = 0;
        hours = 4'b1001; // Set time to 06:00
        minutes = 6'b101101;
        #10 set_time = 0;
        #10 set_time = 0;

        // Test setting the alarm
        set_alarm = 1;
        #10 set_alarm = 1;
        alarm_hours = 4'b1101; // Set alarm to 09:00
        alarm_minutes = 6'b101010;
        #10 set_alarm = 1;
       // #10 set_alarm = 0;

        // Test the alarm functionality
        // The alarm should ring when the time matches the alarm time
        set_time = 1;
        hours = 4'b0101; // Set time to 09:00
        minutes = 6'b000000;
        //#10 set_time = 0;
        // Alarm should start ringing here
        if (alarm_ringing) $display("Alarm is ringing!");
        #10;
        // Alarm should stop ringing here
        if (!alarm_ringing) $display("Alarm stopped ringing!");
        
         //case-7
        clock = 1;
        reset = 0;
        set_time = 1;
        set_alarm = 1;
        // Reset the clock
        reset = 1;
        #10 reset = 1;

        // Test setting the time
        set_time = 1;
        #10 set_time = 0;
        hours = 4'b1101; // Set time to 06:00
        minutes = 6'b101100;
        #10 set_time = 1;
        #10 set_time = 0;
        reset=0;
        // Test setting the alarm
        set_alarm = 1;
        #10 set_alarm = 1;
        alarm_hours = 4'b1101; // Set alarm to 09:00
        alarm_minutes = 6'b101110;
        #10 set_alarm = 1;
       // #10 set_alarm = 0;

        // Test the alarm functionality
        // The alarm should ring when the time matches the alarm time
        set_time = 1;
        hours = 4'b1001; // Set time to 09:00
        minutes = 6'b010111;
        #10 set_time = 0;
        // Alarm should start ringing here
        if (alarm_ringing) $display("Alarm is ringing!");
        #10 reset=1;
        // Alarm should stop ringing here
        if (!alarm_ringing) $display("Alarm stopped ringing!");
        
         //case-8
        clock = 0;
        reset = 0;
        set_time = 1;
        set_alarm = 1;
        // Reset the clock
        reset = 0;
        #10 reset = 0;

        // Test setting the time
        set_time = 0;
        #10 set_time = 0;
        hours = 4'b1001; // Set time to 06:00
        minutes = 6'b101000;
        #10 set_time = 1;
        #10 set_time = 1;

        // Test setting the alarm
        set_alarm = 1;
        #10 set_alarm = 1;
        alarm_hours = 4'b1101; // Set alarm to 09:00
        alarm_minutes = 6'b111011;
        #10 set_alarm = 0;
        #10 set_alarm = 1;

        // Test the alarm functionality
        // The alarm should ring when the time matches the alarm time
        set_time = 1;
        hours = 4'b1001; // Set time to 09:00
        minutes = 6'b101000;
        #10 set_time = 0;
        // Alarm should start ringing here
        if (alarm_ringing) $display("Alarm is ringing!");
        #10;
        // Alarm should stop ringing here
        if (!alarm_ringing) $display("Alarm stopped ringing!");
        
        //case-9
        clock = 1;
        reset =1 ;
        set_time = 0;
        set_alarm = 1;
        // Reset the clock
        reset = 0;
        #10 reset = 0;

        // Test setting the time
        set_time = 0;
        #10 set_time = 1;
        hours = 4'b1001; // Set time to 06:00
        minutes = 6'b101100;
        #10 set_time = 1;
        #10 set_time = 1;

        // Test setting the alarm
        set_alarm = 1;
        #10 set_alarm = 1;
        alarm_hours = 4'b1101; // Set alarm to 09:00
        alarm_minutes = 6'b110111;
        #10 set_alarm = 1;
        #10 set_alarm = 0;
		 reset=1;
        // Test the alarm functionality
        // The alarm should ring when the time matches the alarm time
        set_time = 0;
        hours = 4'b1011; // Set time to 09:00
        minutes = 6'b101110;
        #10 set_time = 0;
        // Alarm should start ringing here
        if (alarm_ringing) $display("Alarm is ringing!");
        #10;
        // Alarm should stop ringing here
        if (!alarm_ringing) $display("Alarm stopped ringing!");
        
        
        //case-10
        clock = 0;
        reset =1 ;
        set_time = 0;
        set_alarm = 0;
        // Reset the clock
        reset = 0;
        #10 reset = 0;

        // Test setting the time
        set_time = 1;
        #10 set_time = 1;
        hours = 4'b1001; // Set time to 06:00
        minutes = 6'b101100;
        #10 set_time = 1;
        #10 set_time = 1;

        // Test setting the alarm
        set_alarm = 1;
        #10 set_alarm = 1;
        alarm_hours = 4'b1100; // Set alarm to 09:00
        alarm_minutes = 6'b010111;
        #10 set_alarm = 1;
        #10 set_alarm = 0;
		 reset=1;
        // Test the alarm functionality
        // The alarm should ring when the time matches the alarm time
        set_time = 0;
        hours = 4'b1011; // Set time to 09:00
        minutes = 6'b001110;
        #10 set_time = 0;
        // Alarm should start ringing here
        if (alarm_ringing) $display("Alarm is ringing!");
        #10;
        // Alarm should stop ringing here
        if (!alarm_ringing) $display("Alarm stopped ringing!");
        
        //case-11
        clock = 1;
        reset =1 ;
        set_time = 1;
        set_alarm = 0;
        // Reset the clock
        reset = 1;
        #10 reset = 1;

        // Test setting the time
        set_time = 0;
        #10 set_time = 1;
        hours = 4'b1001; // Set time to 06:00
        minutes = 6'b100100;
        #10 set_time = 1;
        #10 set_time = 1;
	   reset=0;
        // Test setting the alarm
        set_alarm = 1;
        #10 set_alarm = 0;
        alarm_hours = 4'b1100; // Set alarm to 09:00
        alarm_minutes = 6'b110111;
        #10 set_alarm = 1;
        #10 set_alarm = 1;
		 reset=1;
        // Test the alarm functionality
        // The alarm should ring when the time matches the alarm time
        set_time = 0;
        hours = 4'b1011; // Set time to 09:00
        minutes = 6'b000110;
        #10 set_time = 1;
        // Alarm should start ringing here
        if (alarm_ringing) $display("Alarm is ringing!");
        #10;
        // Alarm should stop ringing here
        if (!alarm_ringing) $display("Alarm stopped ringing!");
        
        
        //case-12
        clock = 1;
        reset =1 ;
        set_time = 1;
        set_alarm = 1;
        // Reset the clock
        reset = 0;
        #10 reset = 1;

        // Test setting the time
        set_time = 1;
        #10 set_time = 1;
        hours = 4'b1001; // Set time to 06:00
        minutes = 6'b101000;
        #10 set_time = 1;
        #10 set_time = 1;

        // Test setting the alarm
        set_alarm = 1;
        #10 set_alarm = 1;
        alarm_hours = 4'b0100; // Set alarm to 09:00
        alarm_minutes = 6'b010111;
        #10 set_alarm = 1;
        #10 set_alarm = 0;
		 reset=1;
        // Test the alarm functionality
        // The alarm should ring when the time matches the alarm time
        set_time = 0;
        hours = 4'b1011; // Set time to 09:00
        minutes = 6'b001110;
        #10 set_time = 0;
        // Alarm should start ringing here
        if (alarm_ringing) $display("Alarm is ringing!");
        #10;
        // Alarm should stop ringing here
        if (!alarm_ringing) $display("Alarm stopped ringing!");
        
        //case-13
        clock = 1;
        reset =1 ;
        set_time = 0;
        set_alarm = 0;
        // Reset the clock
        reset = 1;
        #10 reset = 1;

        // Test setting the time
        set_time = 1;
        #10 set_time = 1;
        hours = 4'b1001; // Set time to 06:00
        minutes = 6'b101101;
        #10 set_time = 1;
        #10 set_time = 0;
	   reset=0;
        // Test setting the alarm
        set_alarm = 1;
        #10 set_alarm = 0;
        alarm_hours = 4'b1100; // Set alarm to 09:00
        alarm_minutes = 6'b110110;
        #10 set_alarm = 0;
        #10 set_alarm = 1;
		 reset=1;
        // Test the alarm functionality
        // The alarm should ring when the time matches the alarm time
        set_time = 0;
        hours = 4'b1011; // Set time to 09:00
        minutes = 6'b110110;
        #10 set_time = 0;
        // Alarm should start ringing here
        if (alarm_ringing) $display("Alarm is ringing!");
        #10;
        // Alarm should stop ringing here
        if (!alarm_ringing) $display("Alarm stopped ringing!");
        
        
     end
        
endmodule
