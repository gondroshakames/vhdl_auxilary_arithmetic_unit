----------------------------------------------------------------------------------
-- Block: Fall_Edge_Detector
-- Desc:
-- Outputs 1/2 clk period pulse 
-- detects rising edge of sig_in 
-- it will not detect edge on clk rising edge
----------------------------------------------------------------------------------

-- Libs
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Ports
entity rising_edge_detect is
    Port ( sig_in : in STD_LOGIC;
           sig_out : out STD_LOGIC;
           clk : in STD_LOGIC);
end rising_edge_detect;




architecture Behavioral of rising_edge_detect is

-- Signals
signal dff_Q : std_logic;

begin

-- Sequential part of RTL design
d_ff: process(clk) begin
    if rising_edge(clk) then
        dff_Q <= sig_in;
    end if;
end process;

-- Combinational part of RTL design
sig_out <= (sig_in xor dff_Q) and sig_in;

end Behavioral;
