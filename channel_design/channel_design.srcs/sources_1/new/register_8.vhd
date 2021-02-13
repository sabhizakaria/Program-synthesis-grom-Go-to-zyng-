library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_arith.all;


entity register_8 is
Port ( 
    res : in  std_logic := '0';
    data : in std_logic_vector(7 downto 0);
    load : in std_logic   
   );
end register_8;

architecture Behavioral of register_8 is
signal mem : std_logic_vector(7 downto 0):= conv_std_logic_vector(0,8);
begin
reg : process(load)
    begin
    if res = '0' and load = '1' then 
           mem <= data ;
    end if ; 
end process; 

end Behavioral;
