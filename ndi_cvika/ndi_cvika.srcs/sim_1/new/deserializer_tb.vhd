-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Sat, 27 Sep 2025 14:19:08 GMT
-- Request id : cfwk-fed377c2-68d7f25cbbcbb

library ieee;
use ieee.std_logic_1164.all;

entity tb_deserializer is
generic(n_bits : natural := 4);
end tb_deserializer;

architecture tb of tb_deserializer is

    component deserializer
        generic(n_bits : natural := 4);
        
        port (clk      : in std_logic;
              rst_s    : in std_logic;
              stream   : in std_logic;
              shift_en : in std_logic;
              data_out : out std_logic_vector (n_bits-1 downto 0));
    end component;

    signal clk      : std_logic;
    signal rst_s    : std_logic;
    signal stream   : std_logic;
    signal shift_en : std_logic;
    signal data_out : std_logic_vector (n_bits-1 downto 0);

    constant TbPeriod : time := 100 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : deserializer
    generic map (n_bits => n_bits)
                
    port map (clk      => clk,
              rst_s    => rst_s,
              stream   => stream,
              shift_en => shift_en,
              data_out => data_out);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        stream <= '0';
        shift_en <= '0';

        -- Reset generation
        -- ***EDIT*** Check that rst_s is really your reset signal
        rst_s <= '1';
        wait for 100 ns;
        rst_s <= '0';
        wait for 150 ns;
        
        shift_en <= '1';
        
        for i in 0 to 1 loop
            stream <= '1'; 
            wait for 100 ns;
            stream <= '0';
            wait for 100 ns;
        end loop;
        shift_en <= '0';
 
--        wait for 100 ns;
--        stream <= '1';
--        wait for 100 ns;
--        stream <= '0';
--        wait for 100 ns;
--        stream <= '0';
--        shift_en <= '0';
--        wait for 100 ns;
--        stream <= '0';
--        wait for 100 ns;
--        stream <= '1';
--        wait for 100 ns;
        
        
        
        

        -- ***EDIT*** Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_deserializer of tb_deserializer is
    for tb
    end for;
end cfg_tb_deserializer;