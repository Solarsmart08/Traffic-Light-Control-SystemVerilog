module traffic_light (
    input  logic clk,
    input  logic rst,

    output logic ns_red,
    output logic ns_yellow,
    output logic ns_green,

    output logic ew_red,
    output logic ew_yellow,
    output logic ew_green
);

    typedef enum logic [1:0] {
        NS_GREEN  = 2'b00,
        NS_YELLOW = 2'b01,
        EW_GREEN  = 2'b10,
        EW_YELLOW = 2'b11
    } state_t;

    state_t state, next_state;

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            state <= NS_GREEN;
        else
            state <= next_state;
    end

    always_comb begin

        case (state)

            NS_GREEN:
                next_state = NS_YELLOW;

            NS_YELLOW:
                next_state = EW_GREEN;

            EW_GREEN:
                next_state = EW_YELLOW;

            EW_YELLOW:
                next_state = NS_GREEN;

            default:
                next_state = NS_GREEN;

        endcase

    end

    // Output logic
    always_comb begin

        // Default: all lights OFF
        ns_red    = 1'b0;
        ns_yellow = 1'b0;
        ns_green  = 1'b0;

        ew_red    = 1'b0;
        ew_yellow = 1'b0;
        ew_green  = 1'b0;

        case (state)

            NS_GREEN: begin
                ns_green = 1'b1;
                ew_red   = 1'b1;
            end

            NS_YELLOW: begin
                ns_yellow = 1'b1;
                ew_red    = 1'b1;
            end

            EW_GREEN: begin
                ew_green = 1'b1;
                ns_red   = 1'b1;
            end

            EW_YELLOW: begin
                ew_yellow = 1'b1;
                ns_red    = 1'b1;
            end

            default: begin
                ns_red = 1'b1;
                ew_red = 1'b1;
            end

        endcase

    end

endmodule
