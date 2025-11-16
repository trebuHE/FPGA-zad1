library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top is
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
end top;

architecture Behavioral of top is
    signal clk_counter : unsigned(10 downto 0) := (others => '0');
    
    signal sclk_prev : std_logic := '0';
    signal lrck_prev : std_logic := '0';
    
    signal in_left : std_logic_vector(23 downto 0) := (others => '0');
    signal in_right : std_logic_vector(23 downto 0) := (others => '0');
    signal out_left : std_logic_vector(23 downto 0) := (others => '0');
    signal out_right : std_logic_vector(23 downto 0) := (others => '0');
    
    signal strobe : std_logic := '0';
    
    signal led_abs : unsigned(15 downto 0) := (others => '0');
    signal shift_counter : unsigned(7 downto 0) := (others => '0');
begin

    process(CLK100MHZ)
    begin
        if rising_edge(CLK100MHZ) then
            clk_counter <= clk_counter + 1;
        end if;     
    end process;
    
    process(CLK100MHZ)

    begin
        if rising_edge(CLK100MHZ) then
            strobe <= '0';
            sclk_prev <= clk_counter(4);
            lrck_prev <= clk_counter(10);
            
            if clk_counter(10) = '0' then
                if sclk_prev = '0' and clk_counter(4) = '1' then
                    if shift_counter > 0 and shift_counter < 25 then
                        in_left <= in_left(22 downto 0) & AD_SDOUT;
                    end if;
                    shift_counter <= shift_counter + 1;
                elsif sclk_prev = '1' and clk_counter(4) = '0' and shift_counter > 1 then
                    DA_SDIN <= out_left(23);
                    out_left <= out_left(22 downto 0) & '0';
                end if;
            elsif clk_counter(10) = '1' then
                if sclk_prev = '0' and clk_counter(4) = '1' then
                    if shift_counter > 0 and shift_counter < 25 then
                        in_right <= in_right(22 downto 0) & AD_SDOUT;
                    end if;
                    shift_counter <= shift_counter + 1;
                elsif sclk_prev = '1' and clk_counter(4) = '0' then
                    DA_SDIN <= out_right(23);
                    out_right <= out_right(22 downto 0) & '0';
                end if;
            end if;
            
            if lrck_prev = '1' and clk_counter(10) = '0' then
                out_left <= in_left;
                out_right <= in_right;
                in_left <= (others => '0');
                in_right <= (others => '0');
                strobe <= '1';
                shift_counter <= (others => '0');
            end if;
            
            if lrck_prev = '0' and clk_counter(10) = '1' then
                shift_counter <= (others => '0');
            end if;
            
        end if;
    end process;
    
    process(strobe)
    begin
        if falling_edge(strobe) then
            led_abs <= unsigned(abs(signed(out_right(23 downto 8))));
            LED <= (others => '1');
            
            for i in 0 to 15 loop
                if led_abs > (i * 4096) then
                    LED(i) <= '0';
                end if;
            end loop;              
        end if;
    end process;

--    DA_SDIN <= AD_SDOUT;

    AD_MCLK <= clk_counter(2);
    DA_MCLK <= clk_counter(2);
    
    AD_SCLK <= clk_counter(4);
    DA_SCLK <= clk_counter(4);
    
    AD_LRCK <= clk_counter(10);
    DA_LRCK <= clk_counter(10);
end Behavioral;
