library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity output is
Port ( 
    r_clk : in std_logic;
    start : in std_logic;
    transfer : in std_logic;
    ready : inout std_logic;
    finish : inout std_logic
);
   
end output;

architecture Behavioral of output is
signal  sig_q : std_logic;
signal r_d : std_logic;
component FF
    port ( 
        ff_clk : std_logic;
        set : in std_logic;
        reset : in std_logic:='0';
        q : inout std_logic
    );
end component;

begin
    FlipFlop: entity work.FF(Behavioral) port map (
          ff_clk => r_clk,
          set => start,
          reset => r_d,
          q => sig_q  
    );
    latch_D : entity work.FF(Behavioral) port map (
          ff_clk => r_clk,
          set => r_d,
          q => finish  
    );
    Input : process(start, transfer)
    begin 
        ready <= start or sig_q ;
        r_d <= ready and transfer;
            
    end process;
end Behavioral;
