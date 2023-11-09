LIBRARY ieee;
 USE ieee.std_logic_1164.ALL;
 USE ieee.numeric_std.ALL;
 ENTITY MSTloader IS
 PORT(
	OUTPUT: OUT STD_LOGIC_VECTOR(3 downto 0)
	);
 END MSTloader;
  ARCHITECTURE rtl OF MSTloader IS
  BEGIN
	OUTPUT <= "1111";
  END;