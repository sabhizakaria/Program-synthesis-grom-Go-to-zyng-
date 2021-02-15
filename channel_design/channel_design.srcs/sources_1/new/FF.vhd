library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity FF is

Port ( 
    ff_clk : in std_logic;
    set : in std_logic:= '0';
    reset : in std_logic := '0';
    q : inout std_logic
);
end FF;

architecture Behavioral of FF is
begin
FF : process(set, reset, ff_clk)
begin
    if ff_clk ='1' then 
        if (set = '1') and (reset = '0') then
            q <= '1' ;
        elsif (set = '0') and (reset = '1') then
            q <= '0';
        else 
            q <= q;
        end if ;
    end if ; 
end process;

end Behavioral;
