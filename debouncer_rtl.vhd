
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity debouncer_rtl is
    Port ( i_clk : in  STD_LOGIC;
           i_switch : in  STD_LOGIC;
           o_switch : out  STD_LOGIC);
end debouncer_rtl;

architecture Behavioral of debouncer_rtl is
	--10 ms at 100MHz
	constant c_debounce_limit :integer := 10000000;
	signal r_state : std_logic :='1'; -- filtered version of i_switch
	signal r_count : integer range 0 to c_debounce_limit :=0;
	
begin
	process(i_clk)
		begin
			if rising_edge(i_clk) then
				if (i_switch /= r_state and r_count < c_debounce_limit) then
					r_count <= r_count + 1;
				elsif r_count = c_debounce_limit then
					r_state <= i_switch;
					r_count <= 0;
				else
					r_count <= 0;
				end if;
			end if;	
		end process;
	o_switch <= r_state;
end Behavioral;

