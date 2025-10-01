----------------------------------------------------------------------------------
-- Block: SIPO register for parallization of data loaded from serial bus
-- Desc: 
-- Has synchronous reset and respective inputs for enabling shift of D flip-flop
-- Priorities: 1. Synchr. Reset, 2. Shift En
-- Load EN: Loads data from parallel bus to PISO when '1'.
-- Shift EN: Will enable shifting data as long as it equals '1'.
-- Shift direction to parallel bus can configured by uncommenting specificic line in code
----------------------------------------------------------------------------------

-- Libs
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Ports
entity deserializer is
    generic(
        n_bits : natural := 4
    );
    Port ( clk : in STD_LOGIC;
           rst_s : in STD_LOGIC;
           stream : in STD_LOGIC;
           shift_en : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (n_bits-1 downto 0));
end deserializer;

architecture Behavioral of deserializer is

signal par_data_reg : std_logic_vector(n_bits-1 downto 0);

begin

process(clk) begin

-- Sequential part of RTL design
-- SIPO Register
    if (rising_edge(clk)) then 
        if (rst_s  = '1') then
            par_data_reg <= (others => '0');
        elsif (shift_en = '1') then
        
            --Uncomment line below for shifting from MSB to LSB 
            par_data_reg <= stream & par_data_reg(n_bits-1 downto 1);
            
            --Uncomment line below for shifting from LSB to MSB     
            --par_data_reg <= par_data_reg(n_bits-2 downto 0) & stream;
              
        end if;
    end if;

end process;

-- Combinational part of RTL design
-- Write data to output parallel bus
data_out <= par_data_reg;

end Behavioral;
