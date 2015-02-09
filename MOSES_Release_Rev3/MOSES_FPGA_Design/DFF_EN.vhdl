----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:49:23 08/22/2014 
-- Design Name: 
-- Module Name:    DFF - Behavioral 
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

entity DFF_EN is
    Port ( clk : in  STD_LOGIC;
           rst_n : in  STD_LOGIC;
           D : in  STD_LOGIC;
           Q : out  STD_LOGIC;
			  en : in	std_logic);
end DFF_EN;

architecture Behavioral of DFF_EN is

begin
	process(clk,rst_n) is
	begin
		if (rst_n = '0') then
			Q <= '0';
		elsif (clk'event and clk = '1') then
			if (en = '1') then
				Q <= D;
			end if;
		end if;
	end process;

end Behavioral;
