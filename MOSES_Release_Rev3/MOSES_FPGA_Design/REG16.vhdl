----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:56:35 08/22/2014 
-- Design Name: 
-- Module Name:    REG16 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity REG16 is
    Port ( clk : in  STD_LOGIC;
           rst_n : in  STD_LOGIC;
           D : in  STD_LOGIC_VECTOR (15 downto 0);
           Q : out  STD_LOGIC_VECTOR (15 downto 0));
end REG16;

architecture Behavioral of REG16 is

begin
	process(clk,rst_n) is
	begin
		if (rst_n = '0') then
			Q <= (others => '0');
		elsif (clk'event and clk = '1') then
			Q <= D;
		end if;
	end process;

end Behavioral;

