 LIBRARY ieee;
 USE ieee.std_logic_1164.ALL;
 USE ieee.numeric_std.ALL;
 ENTITY fourBitMUX2to1 IS
 PORT(
 i_0, i_1 : IN STD_LOGIC_VECTOR(3 downto 0);
 OUTPUT: OUT STD_LOGIC_VECTOR(3 downto 0);
 C : IN STD_LOGIC);
 END fourBitMUX2to1;
 ARCHITECTURE rtl OF fourBitMUX2to1 IS
	
	
	BEGIN
		
		OUTPUT(0) <= (not(C) AND i_0(0)) OR (C AND 	i_1(0));
		OUTPUT(1) <= (not(C) AND i_0(1)) OR (C AND 	i_1(1));
		OUTPUT(2) <= (not(C) AND i_0(2)) OR (C AND 	i_1(2));
		OUTPUT(3) <= (not(C) AND i_0(3)) OR (C AND 	i_1(3));
	
	END rtl;
 