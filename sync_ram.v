module sync_ram #(
    parameter DATA_WIDTH = 8,    // Width of data (default 8 bits)
    parameter ADDR_WIDTH = 4     // Width of address (default 4 bits -> 16 locations)
)(
    input  wire                  clk,   // Clock
    input  wire                  we,    // Write enable (1 = write, 0 = read)
    input  wire [ADDR_WIDTH-1:0] addr,  // Address input
    input  wire [DATA_WIDTH-1:0] din,   // Data input
    output reg  [DATA_WIDTH-1:0] dout   // Data output
);

    // Declare memory array
    reg [DATA_WIDTH-1:0] mem [0:(1<<ADDR_WIDTH)-1];

    // On every rising clock edge
    always @(posedge clk) begin
        if (we) begin
            mem[addr] <= din;   // Write data into memory
        end
        dout <= mem[addr];      // Read data from memory
    end

endmodule
