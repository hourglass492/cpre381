library IEEE;
use IEEE.std_logic_1164.all;


entity reverse is
Port (  s : in STD_LOGIC;
		i : in STD_LOGIC_VECTOR (31 downto 0);
		o : out STD_LOGIC_VECTOR (31 downto 0));
end reverse;

architecture Behavioral of reverse is
begin

	o <= i(0)&i(1)&i(2)&i(3)&i(4)&i(5)&i(6)&i(7)&i(8)&i(9)&i(10)&i(11)&i(12)&i(13)&i(14)&i(15)&i(16)&i(17)&i(18)&i(19)&i(20)&i(21)&i(22)&i(23)&i(24)&i(25)&i(26)&i(27)&i(28)&i(29)&i(30)&i(31) when s = '1' else i;

end Behavioral;