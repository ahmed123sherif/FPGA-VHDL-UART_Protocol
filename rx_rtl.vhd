library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity rx_rtl is
    Port ( clk : in  STD_LOGIC;
           rx_line : in  STD_LOGIC;
           data : out  STD_LOGIC_VECTOR (7 downto 0);
           busy : out  STD_LOGIC);
end rx_rtl;

architecture main of rx_rtl is

signal prscl   : integer range 0 to 5208:=0;
signal index   : integer range 0 to 9 :=0;
signal datafll : std_logic_vector (9 downto 0);
signal rx_flg  : std_logic :='0';

begin
process
	begin
		if rising_edge(clk) then
			if (rx_flg='0') and (rx_line='0') then
				index <= 0;
				prscl <= 0;
				busy <= '1';
				rx_flg <= '1';
			end if;
			if (rx_flg='1') then
				datafll(index) <= rx_line;
				if (prscl<5207) then
					prscl<=prscl+1;
				else
					prscl<=0;
				end if;
				if (prscl=2603) then
					if (index<9) then
					 index <= index+1;
					else
						if (datafll(0)='0') and (datafll(9)='1') then
							data <= datafll(8 downto 1);
						else
							data <= (others=>'0');
						end if;
					rx_flg <= '0';
					busy <= '0';
					end if;
				end if;
			end if;
		end if;
	end process;
end main;

