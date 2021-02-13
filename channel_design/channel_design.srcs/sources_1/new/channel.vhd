library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity channel is
Port ( 
    gclk : std_logic;
    start_read : in std_logic;
    start_write : in std_logic;
    finish_read : inout std_logic;
    finish_write : inout std_logic;
    g_data : in std_logic_vector(7 downto 0)
);
end channel;

architecture Behavioral of channel is
signal inter_transfer : std_logic;
signal inter_ready_rd : std_logic;
signal inter_ready_wr : std_logic;
signal inter_reg_load : std_logic ;
signal data : std_logic;

component input
    port ( 
        start : in std_logic;
        transfer : in std_logic;
        ready : inout std_logic;
        finish : inout std_logic;
        reg_load : inout std_logic
    );
end component;

component output
    port ( 
        start : in std_logic;
        transfer : in std_logic;
        ready : inout std_logic;
        finish : inout std_logic;
        reg_load : inout std_logic
    );
end component;

component register_8
    port ( 
        clk : in std_logic;
        res : in std_logic;
        data : in std_logic_vector(7 downto 0);
        load : in std_logic 
    );
end component;
begin
write: entity work.input(Behavioral) port map (
            start => start_write,
            transfer => inter_transfer,
            ready  => inter_ready_wr,
            reg_load => inter_reg_load,
            finish => finish_write
        );
read: entity work.output(Behavioral) port map (
            start => start_read,
            transfer => inter_transfer,
            ready  => inter_ready_rd,
            finish => finish_read
       );
        
reg:  entity work.register_8(Behavioral) port map (
             data => g_data,
             load => inter_reg_load  
       ); 
channel : process(gclk)
   begin 
        if gclk = '1' then
            inter_transfer <= inter_ready_rd and  inter_ready_wr ;
        end if ;
end process;
end Behavioral;
