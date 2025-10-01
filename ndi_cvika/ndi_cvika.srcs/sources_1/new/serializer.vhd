----------------------------------------------------------------------------------------------
-- Block: PISO register for serialization of data loaded from parallel bus
-- Desc: 
-- Has synchronous reset and respective inputs for enabling shift and loading of data
-- Priorities: 1. S. Reset, 2. Load En, 3. Shift En
-- Load EN: Loads data from parallel bus to PISO when '1'.
-- Shift EN: Will enable shifting data as long as it equals '1'.
-- The shift direction can be configured by user. See lines 46 through 50 and 60 trough 64. 
-- Make sure that correct lines are uncommented, otherwise it may lead to unexpeced behavior. 
----------------------------------------------------------------------------------------------

-- Libs
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Ports
entity serializer is
    generic( n_bits : natural := 3);

    Port ( data : in STD_LOGIC_VECTOR (n_bits-1 downto 0);
           load_en : in STD_LOGIC;
           shift_en : in STD_LOGIC;
           rst_s : in STD_LOGIC;
           clk : in STD_LOGIC;
           stream : out STD_LOGIC);
end serializer;

architecture Behavioral of serializer is

-- Placeholder signal to load data from parallel bus
signal data_reg : std_logic_vector(n_bits-1 downto 0);

begin

-- Sequential part of RTL design
-- PISO Register
shift_data: process (clk) begin
    if rising_edge(clk) then
        if (rst_s = '1') then
            data_reg <= (others => '0');
        else
            if (load_en = '1') then 
                data_reg <= data;
            elsif (shift_en = '1') then 
            
            --Uncomment line below to shift from MSB to LSB
                data_reg <= '0' & data_reg(n_bits-1 downto 1);
            
            --Uncomment line below to shift from LSB to MSB  
                --data_reg <= data_reg(n_bits-2 downto 0) & '0';
                
            end if;
        end if;
    end if;
end process;

-- Combinational part of RTL design
-- Write signal "data_reg" to stream

    --Uncomment line below to shift from MSB to LSB
    stream <= data_reg(0);
    
    --Uncomment line below to shift from LSB to MSB
    --stream <= data_reg(n_bits-1);


end Behavioral;
