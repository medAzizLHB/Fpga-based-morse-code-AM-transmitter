--medazizlhb
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all; 

entity soundout is 
 port (  clk, reset : in std_logic; 
   count : in std_logic_vector (4 downto 0); 
   sound, letterclk : out std_logic ); 
end soundout; 

architecture timer of soundout is 
 type state_type is (idle, determine, pause, short, long); 
 signal noise : state_type; 
 signal timedelay : std_logic_vector (1 downto 0); 
 signal cnt : std_logic_vector (4 downto 0); 
begin 
 process (clk) 
 begin 
  if clk 'EVENT and clk = '1' then 
   if reset = '1' then 
    sound <= '0'; 
    noise <= idle; 
    cnt <= (others => '0'); 
    letterclk <= '0'; 
    timedelay <= (others => '0'); 
   else 
    case noise is 
     when idle => 
      sound <= '0'; 
      cnt <= count; 
      letterclk <= '0'; 
      noise <= pause; 
      timedelay <= (others => '0'); 
     when pause => 
      if timedelay = "11" then 
       sound <= '0'; 
       letterclk <= '0'; 
       noise <= determine; 
       timedelay <= (others => '0'); 
      else 
       timedelay <= timedelay + 1; 
       noise <= pause; 
      end if; 
     when determine => 
      if cnt >= 8 then 
       letterclk <= '0'; 
       noise <= short; 
      elsif cnt < 8 and cnt > 0 then 
       letterclk <= '0'; 
       noise <= long; 
      else 
       noise <= idle; 
       sound <= '0'; 
       letterclk <= '1'; 
       cnt <= (others => '0'); 
      end if; 
     when short => 
      if cnt > 0 then 
       letterclk <= '0'; 
       sound <= '1'; 
       cnt <= cnt + 1; 
       noise <= short; 
      else 
       noise <= idle; 
       letterclk <= '1'; 
       sound <= '0'; 
       cnt <= (others => '0'); 
      end if; 
     when long => 
      if cnt > 0 then 
       sound <= '1'; 
       letterclk <= '0'; 
       cnt <= cnt + 1; 
       noise <= long; 
      else 
       noise <= idle; 
       sound <= '0'; 
       letterclk <= '1'; 
       cnt <= (others => '0'); 
      end if; 
    end case; 
   end if; 
  end if; 
 end process; 
end timer;