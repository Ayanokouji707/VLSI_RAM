module sync_ram_tb;

    // Parameters for RAM
    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 4;

    // Testbench signals
    reg clk;                               // Clock
    reg we;                                // Write enable
    reg [ADDR_WIDTH-1:0] addr;             // Address bus
    reg [DATA_WIDTH-1:0] din;              // Data input
    wire [DATA_WIDTH-1:0] dout;            // Data output

    // Instantiate the RAM (Unit Under Test - UUT)
    sync_ram #(DATA_WIDTH, ADDR_WIDTH) uut (
        .clk(clk),
        .we(we),
        .addr(addr),
        .din(din),
        .dout(dout)
    );

    // Clock generation (period = 10 time units)
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        // Initialize signals
        clk  = 0;
        we   = 0;
        addr = 0;
        din  = 0;

        // Write data into RAM
        #10 we = 1; addr = 4'b0000; din = 8'hA5;  // Write 0xA5 at address 0
        #10 addr = 4'b0001; din = 8'h3C;          // Write 0x3C at address 1
        #10 addr = 4'b0010; din = 8'h7E;          // Write 0x7E at address 2

        // Read data from RAM
        #10 we = 0; addr = 4'b0000;               // Read from address 0
        #10 addr = 4'b0001;                       // Read from address 1
        #10 addr = 4'b0010;                       // Read from address 2

        // End simulation
        #20 $finish;
    end

    // Monitor values during simulation
    initial begin
        $monitor("Time=%0t | WE=%b | ADDR=%h | DIN=%h | DOUT=%h",
                  $time, we, addr, din, dout);
    end

endmodule
