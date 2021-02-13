library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;


entity tb_channel is
generic (
    data : std_logic_vector(7 downto 0) := conv_std_logic_vector(1,8)
);

end tb_channel;

architecture Behavioral of tb_channel is

signal tb_gclk : std_logic := '1';
signal tb_start_read :  std_logic;
signal tb_start_write :  std_logic;
signal tb_finish_read :  std_logic;
signal tb_finish_write :  std_logic;
signal tb_g_data :  std_logic_vector(7 downto 0);
component channel
Port ( 
    gclk : in std_logic;
    start_read : in std_logic;
    start_write : in std_logic;
    finish_read : inout std_logic;
    finish_write : inout std_logic;
    g_data : in std_logic_vector(7 downto 0)
);
end component;
begin
tb_channel: entity work.channel(Behavioral) port map (
          
          gclk => tb_gclk,
          start_read => tb_start_read,
          start_write => tb_start_write,
          finish_read => tb_finish_read,
          finish_write => tb_finish_write,
          g_data => tb_g_data 
 );
 
 process
     begin 
        tb_gclk <= '1' ;
        wait for 5 us ;
        tb_gclk <= '0' ;
        tb_start_read <= '1';
        tb_start_write <= '1';
        tb_g_data <= data;
        wait for 10 us; 
        
        
        --tb_start_read <= '1';
        --tb_start_write <= '1';
        --tb_g_data <= data;
 end process;
end Behavioral;
