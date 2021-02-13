----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.02.2021 14:14:23
-- Design Name: 
-- Module Name: FF - Behavioral
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

entity FF is

Port ( 
    set : in std_logic:= '0';
    reset : in std_logic := '0';
    q : inout std_logic
);
end FF;

architecture Behavioral of FF is
begin
FF : process(set, reset)
begin
    if (set = '1') and (reset = '0') then
        q <= '1' ;
    elsif (set = '0') and (reset = '1') then
        q <= '0';
    else 
        q <= q;
    end if ; 
end process;

end Behavioral;
