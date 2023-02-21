
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tx_rtl is
    Port ( clk : in  STD_LOGIC;
           start : in  STD_LOGIC;
           busy : out  STD_LOGIC;
           data : in  STD_LOGIC_VECTOR (7 downto 0);
           tx_line : out  STD_LOGIC);
end tx_rtl;

architecture main of tx_rtl is

signal prscl   : integer range 0 to 5208:=0;
signal index   : integer range 0 to 9 :=0;
signal datafll : std_logic_vector (9 downto 0);
signal tx_flg  : std_logic :='0';
	
begin
	
process(clk)
	begin
		if rising_edge (clk) then
			if (tx_flg='0') and (start='1') then
				tx_flg <= '1';
				busy <= '1';
				datafll(0) <= '0';
				datafll(9) <= '1';
				datafll(8 downto 1) <= data;
			end if;
			if tx_flg='1' then 
				if (prscl<5207) then
					prscl <= prscl+1;
				else
					prscl <= 0;
				end if;
				if (prscl=2603) then
					tx_line <= datafll(index);
					if (index<9) then
						index <= index+1;
					else
						tx_flg <= '0'; 
						busy <= '0';
						index <= 0;
					end if;
				end if;
			end if;
		end if;
	end process;
end main;

