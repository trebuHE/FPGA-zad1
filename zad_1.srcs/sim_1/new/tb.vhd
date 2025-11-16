
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is
    component top is
        Port ( CLK100MHZ : in STD_LOGIC;
               LED : out STD_LOGIC_VECTOR (15 downto 0);
               AD_MCLK : out STD_LOGIC;
               AD_LRCK : out STD_LOGIC;
               AD_SCLK : out STD_LOGIC;
               AD_SDOUT : in STD_LOGIC;
               DA_MCLK : out STD_LOGIC;
               DA_LRCK : out STD_LOGIC;
               DA_SCLK : out STD_LOGIC;
               DA_SDIN : out STD_LOGIC);
    end component top;
    
    signal clk : std_logic := '0';
    signal led : std_logic_vector(15 downto 0) := (others => '0');
    signal ad_mclk : std_logic := '0';
    signal ad_lrck : std_logic := '0';
    signal ad_sclk : std_logic := '0';
    signal ad_sdout : std_logic := '0';
    signal da_mclk : std_logic := '0';
    signal da_lrck : std_logic := '0';
    signal da_sclk : std_logic := '0';
    signal da_sdin : std_logic := '0';
begin

dut: top port map(CLK100MHZ => clk, LED => led, AD_MCLK => ad_mclk, AD_LRCK => ad_lrck, AD_SCLK => ad_sclk, AD_SDOUT => ad_sdout, DA_MCLK => da_mclk, DA_LRCK => da_lrck, DA_SCLK => da_sclk, DA_SDIN => da_sdin);

clock : process
    constant clk_T : time := 10ns;
begin
    clk <= '1';
    wait for clk_T/2;
    clk <= '0';
    wait for clk_T/2;
end process;

stim : process
    constant sclk_T : time := 320ns;
begin
    ad_sdout <= '1';
    wait for sclk_T;
    ad_sdout <= '0';
    wait for sclk_T;
    ad_sdout <= '1';
    wait for sclk_T;
    ad_sdout <= '0';
    wait for sclk_T;
    ad_sdout <= '1';
    wait for sclk_T;
    ad_sdout <= '1';
    wait for sclk_T;
    ad_sdout <= '1';
    wait for sclk_T;
    ad_sdout <= '0';
    wait for sclk_T;
    ad_sdout <= '0';
    wait for sclk_T;
    ad_sdout <= '0';
    wait for sclk_T;
    ad_sdout <= '0';
    wait for sclk_T;
    ad_sdout <= '1';
    wait for sclk_T;
    ad_sdout <= '1';
    wait for sclk_T;
    ad_sdout <= '1';
    wait for sclk_T;
    ad_sdout <= '1';
    wait for sclk_T;
    ad_sdout <= '0';
    wait for sclk_T;
    ad_sdout <= '1';
    wait for sclk_T;
    ad_sdout <= '0';
    wait for sclk_T;
    ad_sdout <= '0';
    wait for sclk_T;
    ad_sdout <= '0';
    wait for sclk_T;
    ad_sdout <= '0';
    wait for sclk_T;
    ad_sdout <= '1';
    wait for sclk_T;
    ad_sdout <= '0';
    wait for sclk_T;
    ad_sdout <= '1';
    wait for sclk_T;
    ad_sdout <= '0';
    wait for sclk_T;
end process;
end Behavioral;
