module bist_hardware(clk,rst,bistmode,bistdone,bistpass,cut_scanmode,
                     cut_sdi,cut_sdo);
  input          clk;
  input          rst;
  input          bistmode;
  output         bistdone;
  output         bistpass;
  output         cut_scanmode;
  output         cut_sdi;
  input          cut_sdo;

  parameter      s_idle=0, s_test=1, s_compare=2, s_done=3, s_error=4;
  parameter      count_max=2000; //number of patterns for bist done
// Add your code here
  reg [11:0] count;
  reg [3:0]  state;
  reg [3:0]  next_state;
  reg        cut_scanmode_reg;
 
  assign cut_scanmode = cut_scanmode_reg;
  //TODO: reset cut_scanmode_reg
  //
   always @(posedge clk or posedge rst) begin
     if (rst == 1) begin
       state <= s_idle;
       count = 0;
     end
     else begin
       state <= next_state;
     end
   end 

   //state machine
   always @(state or bistmode or count) begin 
     case(state)
       s_idle: begin
         if (rst == 1 && bistmode == 1) begin
           cut_scanmode_reg = 1;
           next_state <= s_test;
         end
         else begin
           next_state <= s_idle;
         end
       end

       s_test: begin
         if(count == count_max) begin
           state <= s_compare;
         end
         else begin
           state <= s_test;
         end
       end

       s_compare: begin

       end

       s_done: begin

       end

       s_error: begin

       end
    
       default: $display("ERROR: Entered unknown state\n");
     endcase
   end
endmodule  




module chip(clk,rst,pi,po,bistmode,bistdone,bistpass);
  input          clk;
  input          rst;
  input	 [34:0]  pi;
  output [48:0]  po;
  input          bistmode;
  output         bistdone;
  output         bistpass;

  wire           cut_scanmode,cut_sdi,cut_sdo;

  reg x;
  wire w_x;
  assign w_x = x;

  scan_cut circuit(bistmode,cut_scanmode,cut_sdi,cut_sdo,clk,rst,
         pi[0],pi[1],pi[2],pi[3],pi[4],pi[5],pi[6],pi[7],pi[8],pi[9],
         pi[10],pi[11],pi[12],pi[13],pi[14],pi[15],pi[16],pi[17],pi[18],pi[19],
         pi[20],pi[21],pi[22],pi[23],pi[24],pi[25],pi[26],pi[27],pi[28],pi[29],
         pi[30],pi[31],pi[32],pi[33],pi[34],
         po[0],po[1],po[2],po[3],po[4],po[5],po[6],po[7],po[8],po[9],
         po[10],po[11],po[12],po[13],po[14],po[15],po[16],po[17],po[18],po[19],
         po[20],po[21],po[22],po[23],po[24],po[25],po[26],po[27],po[28],po[29],
         po[30],po[31],po[32],po[33],po[34],po[35],po[36],po[37],po[38],po[39],
         po[40],po[41],po[42],po[43],po[44],po[45],po[46],po[47],po[48]);
  bist_hardware bist( clk,rst,bistmode,bistdone,bistpass,cut_scanmode,
                     cut_sdi,cut_sdo);
  
endmodule
