module traffic_light_tb;

    logic clk;
    logic rst;

    logic ns_red;
    logic ns_yellow;
    logic ns_green;

    logic ew_red;
    logic ew_yellow;
    logic ew_green;

    traffic_light dut (
        .clk       (clk),
        .rst       (rst),
        .ns_red    (ns_red),
        .ns_yellow (ns_yellow),
        .ns_green  (ns_green),
        .ew_red    (ew_red),
        .ew_yellow (ew_yellow),
        .ew_green  (ew_green)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;
        #10;
        rst = 0;
    end

  
    initial begin
        $monitor(
            "TIME=%0t | NS: R=%b Y=%b G=%b | EW: R=%b Y=%b G=%b",
            $time,
            ns_red,
            ns_yellow,
            ns_green,
            ew_red,
            ew_yellow,
            ew_green
        );
    end

endmodule
