-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Wed, 24 Sep 2025 22:30:43 GMT
-- Request id : cfwk-fed377c2-68d47113b5b4b

library ieee;
use ieee.std_logic_1164.all;

entity tb_serializer is
generic(n_bits : natural := 3);
end tb_serializer;

architecture tb of tb_serializer is

    component serializer
        generic(n_bits : natural := 3);
        
        port (data     : in std_logic_vector (n_bits-1 downto 0);
              load_en  : in std_logic;
              shift_en : in std_logic;
              rst_s    : in std_logic;
              clk      : in std_logic;
              stream   : out std_logic);
    end component;

    signal data     : std_logic_vector (n_bits-1 downto 0);
    signal load_en  : std_logic;
    signal shift_en : std_logic;
    signal rst_s    : std_logic;
    signal clk      : std_logic;
    signal stream   : std_logic;

    constant TbPeriod : time := 100 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : serializer
    generic map (
        n_bits => n_bits
                )
    port map (data     => data,
              load_en  => load_en,
              shift_en => shift_en,
              rst_s    => rst_s,
              clk      => clk,
              stream   => stream);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        data <= "110";
        load_en <= '0';
        shift_en <= '0';


        -- Reset generation
        -- ***EDIT*** Check that rst_s is really your reset signal
        rst_s <= '1';
        wait for 100 ns;
        rst_s <= '0';
        wait for 150 ns;
        load_en <= '1';
        wait for 100 ns;
        load_en <= '0';
        wait for 100 ns;
        shift_en <= '1';
        wait for 300 ns;
        shift_en <= '0';
        load_en <= '0';
        wait for 100 ns;
        

        -- ***EDIT*** Add stimuli here
        wait for 100 * TbPeriod;
        

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_serializer of tb_serializer is
    for tb
    end for;
end cfg_tb_serializer;