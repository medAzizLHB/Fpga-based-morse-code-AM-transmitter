   library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all; 

entity stop is 
 port ( clk, reset : in std_logic; 
   sdata : in std_logic; 
   pdata : out std_logic_vector (6 downto 0) ); 
end stop; 

architecture serpar of stop is 
 signal count : std_logic_vector (3 downto 0); 
    signal preg : std_logic_vector (7 downto 0); 
 signal loaddata_l : std_logic; 

begin 
 process (clk) 
begin 
 if clk 'EVENT and clk = '0' then 
  if reset = '1' then 
   count <= (others => '0'); 
   preg(0) <= sdata; -- start bit 
   pzero : for i in 1 to 6 loop 
    preg(i) <= '0'; 
   end loop; 
   pzero0 : for i in 0 to 6 loop 
    pdata(i) <= '0'; 
   end loop; 
   loaddata_l <= '0'; 
  elsif loaddata_l = '0' then 
   count <= (others => '0'); 
   loaddata_l <= '1'; 
   genbits : for i in 0 to 6 loop 
    pdata(i) <= preg(i+1); 
   end loop; 
   preg(0) <= sdata; -- start bit 
  else 
   if count(3) = '0' and count(2) = '0' and count(1) = '0' and count(0) = '0' then 
    preg(0) <= sdata; -- begin data?? start bit 
   elsif count(3) = '0' and count(2) = '0' and count(1) = '0' and count(0) = '1' then 
    preg(1) <= sdata; -- begin data 
   elsif count(3) = '0' and count(2) = '0' and count(1) = '1' and count(0) = '0' then 
    preg(2) <= sdata; 
   elsif count(3) = '0' and count(2) = '0' and count(1) = '1' and count(0) = '1' then 
    preg(3) <= sdata; 
   elsif count(3) = '0' and count(2) = '1' and count(1) = '0' and count(0) = '0' then 
    preg(4) <= sdata; 
   elsif count(3) = '0' and count(2) = '1' and count(1) = '0' and count(0) = '1' then 
    preg(5) <= sdata; 
   elsif count(3) = '0' and count(2) = '1' and count(1) = '1' and count(0) = '0' then 
    preg(6) <= sdata; -- end data?? 
   elsif count(3) = '0' and count(2) = '1' and count(1) = '1' and count(0) = '1' then 
    preg(7) <= sdata; -- end of data for letter 
   elsif count(3) = '1' and count(2) = '0' and count(1) = '0' and count(0) = '1' then 
    -- parity 
   else 
    -- end bit 
   end if; 
   count <= count + 1; 
   loaddata_l <= not( count(3) and (not count(2)) and count(1) and (not count(0)) ); 
  end if; 
 end if; 
end process; 

end serpar;