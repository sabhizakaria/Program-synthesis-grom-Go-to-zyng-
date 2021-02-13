LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use Ieee.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity detection is
	generic (
    	nb_pixel : integer := 4 ; 
    	pixel_len : integer := 3 --  coder (5) en (3) bits

  	);
	port(
		gclk: in std_logic;
		pixel : in std_logic_vector (15 downto 0);
		coul_dom : out std_logic_vector (1 downto 0) := "11";
		p_red : out std_logic_vector (4 downto 0):= 
		  std_logic_vector (to_unsigned(0,5)); 
		p_green : out std_logic_vector (4 downto 0):=
		 std_logic_vector (to_unsigned(0,5)); 
		p_blue : out std_logic_vector (4 downto 0):= 
		 std_logic_vector (to_unsigned(0,5));
		cpt_pix : out std_logic_vector(pixel_len-1  downto 0);
		R: out std_logic_vector(13 downto 0);
        V: out std_logic_vector(13 downto 0);
        B: out std_logic_vector(13 downto 0)

	);
end detection ;

architecture Behavioral of detection is

--- valeurs des champs de couleurs (5 bits ) 
 signal valR: std_logic_vector(4 downto 0);
 signal valV: std_logic_vector(4 downto 0);
 signal valB: std_logic_vector(4 downto 0);

--- compteurs pours les couleurs (14 bits)

 signal cptR: std_logic_vector(13 downto 0);
 signal cptV: std_logic_vector(13 downto 0);
 signal cptB: std_logic_vector(13 downto 0);

---- compteurs de pixels
 signal cptP : std_logic_vector(pixel_len-1 downto 0); --:= 
    --std_logic_vector(to_unsigned(0,pixel_len));

-- resultat ( couleur dominante 2 bits )
 signal res: std_logic_vector(1 downto 0) := "11"; -- pas de dominance

-- Flags de fin  
 signal end_detection : std_logic;
 signal end_init : std_logic := '0';

 begin

	process(gclk)--,cptP,res,cptR,cptV,cptB)

    begin
      if end_init = '0' then 
           --- initialisations
           report ("INIT");
           cptB <= std_logic_vector(to_unsigned(0,14));
           cptV <= std_logic_vector(to_unsigned(0,14));
           cptR <= std_logic_vector(to_unsigned(0,14));
           cptP <= std_logic_vector(to_unsigned(0,pixel_len));
           end_detection <= '0';
           end_init <= '1';

      end if ;
         

      -- Recupération des valeurs et incrementation du resultat / nombre pix 
      if (gclk'event and gclk = '0') and pixel /= "00000000000000000" then
         -- recupération de signaux 
		    valB <= pixel (4 downto 0);
		    valV <= pixel (9 downto 5);
		    valR <= pixel (15 downto 11);

		    p_blue <= pixel (4 downto 0);
            p_green <= pixel (9 downto 5);
            p_red <=  pixel (15 downto 11);


		    --- mise a jour des compteur de couleur et du pixel
			if valR > valV and valR > valB then
			    cptR <= cptR + std_logic_vector(to_unsigned(1,14));
				cptP <= cptP + std_logic_vector(to_unsigned(1,pixel_len));
                report("CPT_RED");
			elsif valV > valB then
				cptV <= cptV + std_logic_vector(to_unsigned(1,14));
				cptP <= cptP + std_logic_vector(to_unsigned(1,pixel_len));
                report("CPT_GREEN");
			elsif valB > valV then    
				cptB <= cptB + std_logic_vector(to_unsigned(1,14));
				cptP <= cptP + std_logic_vector(to_unsigned(1,pixel_len));
                report("CPT_BLUE");
			end if;
			

			if cptR > cptV and cptR > cptB then
                	res <= "10"; --res = (2) ==> red
					end_init <= '0';
					report ("RED");
				elsif cptV > cptB then
			        report ("GREEN");
					res <= "01"; --res = (1) ==> green

				elsif cptB > cptV then
			        report ("BLUE"); 
					res <= "00"	; --res = (0) ==>blue
                else 
                    report ("SAME");
				end if ;
				-- dernier pixel 
			if cptP = nb_pixel*2 then
			    report ("DONE");
			    end_init <= '0';
			 end if ;
		end if;
--TODO renitialisation des compteurs
--cptB <= std_logic_vector(to_unsigned(0,14));
--cptV <= std_logic_vector(to_unsigned(0,14));
--cptR <= std_logic_vector(to_unsigned(0,14));
--cptP <= std_logic_vector (to_unsigned(1,pixel_len));
    end process;
 end_detection <= '1' ; 
 R <=   cptR;
 V <=   cptV;
 B <=   cptB;
 cpt_pix <= cptP;
 coul_dom <= res ;

end Behavioral;