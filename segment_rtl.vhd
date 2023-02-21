
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity segment_rtl is
    Port ( z : in std_logic_vector (7 downto 0);
			  k : out std_logic;
			  segs : out std_logic_vector (7 downto 0));
end segment_rtl;

architecture Behavioral of segment_rtl is
	--signal k : std_logic;
begin
	k<='0';
	process(z)
		begin
			case z is
				when x"30" => segs <= "00000011"; --0
				when x"31" => segs <= "10011111"; --0
				when x"32" => segs <= "00100101"; --0
				when x"33" => segs <= "00001101"; --0
				when x"34" => segs <= "10011001"; --0
				when x"35" => segs <= "01001001"; --0
				when x"36" => segs <= "01000001"; --0
				when x"37" => segs <= "00011111"; --0
				when x"38" => segs <= "00000001"; --0
				when x"39" => segs <= "00001001"; --0
				when x"41" => segs <= "00010001"; --0
				when x"42" => segs <= "11000001"; --
				when x"43" => segs <= "01100011"; --0
				when x"44" => segs <= "10000101"; --0
				when x"45" => segs <= "01100001"; --0
				when x"46" => segs <= "01110001"; --0
				when others => segs <= "11111111";
			end case;
		end process;
		
end Behavioral;

