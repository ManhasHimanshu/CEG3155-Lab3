LIBRARY ieee;
 USE ieee.std_logic_1164.ALL;
 USE ieee.numeric_std.ALL;
 ENTITY SSTloader IS
 PORT(
	OUTPUT: OUT STD_LOGIC_VECTOR(3 downto 0)
	);
 END SSTloader;
  ARCHITECTURE rtl OF SSTloader IS
  BEGIN
	OUTPUT <= "1111";
  END;