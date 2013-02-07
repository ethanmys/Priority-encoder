--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:07:31 09/22/2011
-- Design Name:   
-- Module Name:   C:/fpgaclass/project2/project3_tb.vhd
-- Project Name:  project2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: project3
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY project3_tb IS
END project3_tb;
 
ARCHITECTURE behavior OF project3_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT project3
    PORT(
         clk : IN  std_logic;
         data : IN  std_logic;
         capture : IN  std_logic;
         reset : IN  std_logic;
         odd : IN  std_logic;
         valid : OUT  std_logic;
         out_byte : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal data : std_logic := '0';
   signal capture : std_logic := '0';
   signal reset : std_logic := '0';
   signal odd : std_logic := '0';

 	--Outputs
   signal valid : std_logic;
   signal out_byte : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: project3 PORT MAP (
          clk => clk,
          data => data,
          capture => capture,
          reset => reset,
          odd => odd,
          valid => valid,
          out_byte => out_byte
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.

		wait for 100 ns;	
	--	Odd<='0';
	--	reset<='0';
	--	capture<='0';
		capture<='1';
		data<='1';
      wait for 10 ns;
		data<='0';
		wait for 10 ns;
		data<='1';
		wait for 10 ns;
		data<='0';
		wait for 10 ns;
		data<='1';
		wait for 10 ns;
		data<='0';
		wait for 10 ns;
		data<='1';
		assert outbyte="01010101"
			report "Error on outbyte, MSB should be 0"
			severity error;
		--end of my stimulus and checking
		assert false
			report "End of testbench, no error"
			severity failure;
		
   end process;

END;
