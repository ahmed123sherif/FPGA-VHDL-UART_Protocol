
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uart_rtl is
    Port ( clk_100 : in  STD_LOGIC;
			  clk_12 : in  STD_LOGIC;
           sw : in  STD_LOGIC_VECTOR (7 downto 0);
           key : in  STD_LOGIC_VECTOR (3 downto 0);
           --ledr : out  STD_LOGIC_VECTOR (9 downto 0);
           ledg : out  STD_LOGIC_VECTOR (7 downto 0);
			  k : out std_logic;
			  segs : out std_logic_vector (7 downto 0);
           uart_txd : out  STD_LOGIC;
           uart_rxd : in  STD_LOGIC);
end uart_rtl;

architecture main of uart_rtl is
signal tx_data  : std_logic_vector (7 downto 0);
signal tx_start : std_logic:='0';
signal tx_busy  : std_logic;
signal rx_data  : std_logic_vector (7 downto 0);
signal rx_busy  : std_logic;
signal start_trans : std_logic:='0';
signal delay1 : std_logic :='0';
signal delay2 : std_logic :='0';
signal delay3 : std_logic :='0';
signal split_data : std_logic_vector (7 downto 0);	
-----------------------------------------------------------
component tx_rtl 
	Port ( clk : in  STD_LOGIC;
				  start : in  STD_LOGIC;
				  busy : out  STD_LOGIC;
				  data : in  STD_LOGIC_VECTOR (7 downto 0);
				  tx_line : out  STD_LOGIC);
end component tx_rtl;
------------------------------------------------------------
component rx_rtl
    Port ( clk : in  STD_LOGIC;
           rx_line : in  STD_LOGIC;
           data : out  STD_LOGIC_VECTOR (7 downto 0);
           busy : out  STD_LOGIC);
end component rx_rtl;
------------------------------------------------------------
component segment_rtl
    Port ( z : in std_logic_vector (7 downto 0);
			  k : out std_logic;
			  segs : out std_logic_vector (7 downto 0));
end component segment_rtl;
------------------------------------------------------------
component debouncer_rtl is
    Port ( i_clk : in  STD_LOGIC;
           i_switch : in  STD_LOGIC;
           o_switch : out  STD_LOGIC);
end component;
------------------------------------------------------------
component split_rtl is
	Port 	( clk : in  STD_LOGIC;
           in_put : in  STD_LOGIC_VECTOR (7 downto 0);
           out_put : out  STD_LOGIC_VECTOR (7 downto 0));
end component;
------------------------------------------------------------
begin
c1 : tx_rtl port map(clk_100,tx_start,tx_busy,tx_data,uart_txd);
c2 : rx_rtl port map(clk_100,uart_rxd,rx_data,rx_busy);
c3 : segment_rtl port map(rx_data,k,segs);
c4 : debouncer_rtl port map (clk_100,key(0),start_trans);
c5 : split_rtl port map (clk_100,rx_data,split_data);
-------------------------------------------------------------
k <= '0';

process(rx_busy)
begin
	if falling_edge(rx_busy) then
		ledg <= rx_data;
	end if;
end process;
-------------------------------------------------------------
process(clk_100)
begin
	if rising_edge(clk_100) then
		--if (key(0)='0') and (tx_busy='0') then
		if tx_busy='0' then
			tx_data <= split_data;
			tx_start <= '1';
--			ledg <= tx_data;
		else 
			tx_start <= '0';
		end if;
	end if;
end process;

--	-- edge detection circuitry
--	start_trans <= delay1 and delay2 and delay3;
--	
--	-- Process to begin transmitting data
--	-- This process fires off the State Machine
--	begin_trans_proc: process(clk_100)
--	begin
--		if(rising_edge(clk_100)) then
--				delay1 <= key(0);
--				delay2 <= delay1;
--				delay3 <= delay2;
--		end if;
--	end process begin_trans_proc;

end main;
