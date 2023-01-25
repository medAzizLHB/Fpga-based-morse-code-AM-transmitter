library ieee; 
use ieee.std_logic_1164.all; 

entity pdatahold is 
 port ( clk, reset : in std_logic; 
   letterin : in std_logic_vector (6 downto 0); 
   letterout : out std_logic_vector (6 downto 0) ); 
end pdatahold; 

architecture hold of pdatahold is 
begin 
 process (clk) 
 begin 
  if clk 'EVENT and clk = '1' then 
   if reset = '1' then 
    letterout <= (others => '0'); 
   else 
    pass : for i in 0 to 6 loop 
     letterout(i) <= letterin(i); 
    end loop; 
   end if; 
  end if; 
 end process; 
end hold; 