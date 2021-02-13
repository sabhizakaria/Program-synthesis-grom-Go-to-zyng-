----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.02.2021 11:53:10
-- Design Name: 
-- Module Name: input - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity input is
Port ( 
    start : in std_logic;
    transfer : in std_logic;
    ready : inout std_logic;
    finish : inout std_logic;
    reg_load : inout std_logic
);
   
end input;

architecture Behavioral of input is
signal  sig_q : std_logic;
signal r_d : std_logic;
component FF
    port ( 
        set : in std_logic;
        reset : in std_logic:='0';
        q : inout std_logic
    );
end component;

begin
    FlipFlop: entity work.FF(Behavioral) port map (
          set => start,
          reset => r_d,
          q => sig_q  
    );
    latch_D : entity work.FF(Behavioral) port map (
          set => r_d,
          q => finish  
    );
    Input : process(start, transfer)
    begin 
        ready <= start or sig_q ;
        r_d <= ready and transfer;
        reg_load <= ready and transfer;
            
    end process;
end Behavioral;
