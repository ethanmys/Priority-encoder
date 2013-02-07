----------------------------------------------------------------------------------
--Name: Chuan Lim Kho
--Design overview:Hierachial design that implements a priority encoder based 
-- on the four input buttons that controls a 2x2 switch that will light the leds
-- and/or the 7 segment decoder based on two sets of 3 inputs from the switches.
-- Outputs a valid signal on Led 7 when the priority encoder is valid.
-- All outputs are registered.
--Design name: project2 
-----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity project2 is
	port(
	clk: in std_logic; 						-- 50 mHz clock 
	s7: in std_logic; 						--reset switch
	x1: in std_logic_vector(2 downto 0); --switch x1
	x2: in std_logic_vector(2 downto 0); -- swith x2
	en: in std_logic_vector(3 downto 0); --reg_vec(button)
	an: out std_logic_vector(3 downto 0); --anode output 
	led7: out std_logic;							--valid bit
	leds: out std_logic_vector(6 downto 0);-- 7 segment display
	y1led: out std_logic_vector(2 downto 0)); --y1 led
	
	
end project2;

architecture Behavioral of project2 is
 signal enout: std_logic_vector(1 downto 0);	--reg_vec out
 signal y1: std_logic_vector(2 downto 0);
 signal y2: std_logic_vector(2 downto 0);
 signal hex: std_logic_vector(2 downto 0); --input segment encoder
 
begin

--priority encoder
process(clk,en)
begin
      if en(3)='1' then
			enout<="11";
		elsif en(2)='1' then
			enout<="10";
		elsif en(1)='1' then 
			enout<="01";
		elsif en(0)='1' then
			enout<="00";
		else
         enout <= "00";
		end if;
end process;

--valid bit
	
process (clk,s7,en)
begin
   if clk'event and clk='1' then  
      if s7='1' or en = "0000" then   
         led7 <= '0';
      else
         led7 <= '1';
      end if;
   end if;
end process;

--output for switch y1 and y2
switch: process(enout,x1,x2)
begin
	case enout is 
		when "00" =>
			y1<=x1;
			y2<=x2;
		when "01" =>
			y1<=x2;	
			y2<=x1;
		when "10" =>
			y1<=x1;
			y2<=x1;
		when "11" =>
			y1<=x2;
			y2<=x2;
		when others =>
			y1<=x1;
			y2<=x2;
	end case;
end process switch;

--y1 led process
process (clk,s7)
begin
   if clk'event and clk='1' then  
      if s7='1' then   
         y1led <= "000";
      else
         y1led <= y1;
      end if;
   end if;
end process;

--y2 led process
process (clk,s7)
begin
   if clk'event and clk='1' then  
      if s7='1' then   
         HEX <= "000";
      else
			HEX <=y2;
		end if;
   end if;
end process;

        --6 segment display functionality
		  an<="1110";
			with HEX SELect
				leds<= "1111001" when "001",   --1
						"0100100" when "010",   --2	
						"0110000" when "011",   --3
						"0011001" when "100",   --4
						"0010010" when "101",   --5
						"0000010" when "110",   --6
						"1111000" when "111",   --7
						"1000000" when others;   --0      
end Behavioral;

