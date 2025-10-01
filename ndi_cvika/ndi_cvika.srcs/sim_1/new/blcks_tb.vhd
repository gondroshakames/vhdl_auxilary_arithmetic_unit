

library ieee;
use ieee.std_logic_1164.all;

entity tb_fall_edge_detect is
end tb_fall_edge_detect;

architecture tb of tb_fall_edge_detect is

    component fall_edge_detect
        port (sig_in  : in std_logic;
              sig_out : out std_logic;
              clk     : in std_logic);
    end component;

    signal sig_in  : std_logic;
    signal sig_out : std_logic;
    signal clk     : std_logic;

    constant TbPeriod : time := 100 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : fall_edge_detect
    port map (sig_in  => sig_in,
              sig_out => sig_out,
              clk     => clk);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        
        -- Stimuli
        
        sig_in <= '0';
        wait for 375 ns;
        sig_in <= '1';
        wait for 100 ns;
        sig_in <= '0';
        wait for 200 ns;
        sig_in <= '1';
        wait for 200 ns;
        sig_in <= '0';
        wait for 200 ns;

        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_fall_edge_detect of tb_fall_edge_detect is
    for tb
    end for;
end cfg_tb_fall_edge_detect;