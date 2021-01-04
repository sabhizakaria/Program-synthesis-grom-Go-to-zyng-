LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY testbench IS
    --GENERIC (
        --nb_pix : integer := 3 -- en bit (5) 
    --);
END testbench;

ARCHITECTURE test OF testbench IS
    
    COMPONENT detection
        port(
            gclk: in std_logic;
            pixel : in std_logic_vector (15 downto 0);
            coul_dom : out std_logic_vector (1 downto 0);
            p_red : out std_logic_vector (4 downto 0);
            p_green : out std_logic_vector (4 downto 0);
            p_blue : out std_logic_vector (4 downto 0);
            cpt_pix : out std_logic_vector(2 downto 0)

        );
    END COMPONENT;

    SIGNAL clk : STD_LOGIC :='1';
    SIGNAL spixel : std_logic_vector (15 downto 0);
    SIGNAL res : std_logic_vector (1 downto 0);
    SIGNAL sp_red : STD_LOGIC_VECTOR (4 DOWNTO 0) := std_logic_vector (to_unsigned(0,5)) ;
    SIGNAL sp_green : STD_LOGIC_VECTOR (4 DOWNTO 0):= std_logic_vector (to_unsigned(0,5));
    SIGNAL sp_blue : STD_LOGIC_VECTOR (4 DOWNTO 0):= std_logic_vector (to_unsigned(0,5)) ;
    SIGNAL scpt_pix : STD_LOGIC_VECTOR (2 DOWNTO 0);
    
BEGIN
    detect : ENTITY work.detection(Behavioral) PORT MAP(gclk => clk, pixel => spixel, coul_dom => res, p_red => sp_red, 
            p_green => sp_green, p_blue => sp_blue, cpt_pix =>scpt_pix);
    PROCESS BEGIN
        
        spixel <= std_logic_vector(to_unsigned(63488,16)); -- RED 
        clk <= '0';
        WAIT FOR 10 ns;
        clk <= '1';        
        WAIT FOR 10 ns;
        
        spixel <= std_logic_vector(to_unsigned(31,16)); -- BLUE
        clk <= '0';
        WAIT FOR 10 ns;
        clk <= '1';
        WAIT FOR 10 ns;
        
        spixel <= std_logic_vector(to_unsigned(2016,16)); -- GREEN
        clk <= '0';
        WAIT FOR 10 ns;
        clk <= '1';
        WAIT FOR 10 ns;
        
        spixel <= std_logic_vector(to_unsigned(31,16)); -- BLUE
        clk <= '0';
        WAIT FOR 10 ns;
        clk <= '1';
        WAIT FOR 10 ns;
       
    END PROCESS;
END test;