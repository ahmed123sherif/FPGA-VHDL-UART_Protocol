
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity split_rtl is
	Port 	( clk : in  STD_LOGIC;
           in_put : in  STD_LOGIC_VECTOR (7 downto 0);
           out_put : out  STD_LOGIC_VECTOR (7 downto 0));
end split_rtl;

architecture Behavioral of split_rtl is
	type memory is array (0 to 2) of std_logic_vector(7 downto 0);
	signal ram : memory;
	signal count_r : integer range 0 to 3 :=0;
	signal flag : std_logic_vector (1 downto 0) :="00";
begin

	process(clk,in_put)
		--variable count_r : integer range 0 to 42:=0;
		--variable flag : std_logic_vector :="00";
		begin
			if rising_edge(clk) then
				--if in_put = x"24" and flag="00" then
				if flag="00" then
					flag <= "01";
				end if;
				if flag = "01" then
					if count_r< 3 then
						ram(count_r)<=in_put;
						count_r<=count_r+1;
						if count_r=3 then
							count_r<=0;
							--if (ram(0)=x"24") and (ram(1)=x"47") and (ram(2)=x"50") and (ram(3)=x"47") and (ram(4)=x"47") and (ram(5)=x"41") then
							flag<="10";
--							else
--								flag<="00";
--							end if;
						end if;
					end if;
				end if;
				if flag="10" then
					--if (count_r = 18) or (count_r = 19) or (count_r = 20)or (count_r = 21)or (count_r = 22)or (count_r = 23)or (count_r = 24)or (count_r = 25)or (count_r = 26)or (count_r = 28)or (count_r = 30)or (count_r = 31)or (count_r = 32)or (count_r = 33)or (count_r = 34)or (count_r = 35)or (count_r = 36)or (count_r = 37)or (count_r = 38)or (count_r = 39)or  (count_r = 41) then
					out_put<=ram(count_r);
					count_r<=count_r+1;

					--end if;
					if count_r=3 then
						count_r<=0;
						flag<="00";
					end if;
				end if;				
			end if;
		end process;
end Behavioral;

