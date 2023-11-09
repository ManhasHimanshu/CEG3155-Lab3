--------------------------------------------------------------------------------
-- Title         : 2-bit fourBitCounter
-- Project       : VHDL Synthesis Overview
-------------------------------------------------------------------------------
-- File          : fourBitCounter.vhd
-- Author        : Rami Abielmona  <rabielmo@site.uottawa.ca>
-- Created       : 2003/05/17
-- Last modified : 2007/09/25
-------------------------------------------------------------------------------
-- Description : This file creates a 2-bit binary up fourBitCounter as defined in the VHDL
-- Synthesis lecture.  The architecture is done at the RTL
-- abstraction level and the implementation is done in structural
-- VHDL.
-------------------------------------------------------------------------------
-- Modification history :
-- 2003.05.17 R. Abielmona Creation
-- 2004.09.22 R. Abielmona Ported for CEG 3550
-- 2007.09.25 R. Abielmona Modified copyright notice
-------------------------------------------------------------------------------
-- This file is copyright material of Rami Abielmona, Ph.D., P.Eng., Chief Research
-- Scientist at Larus Technologies.  Permission to make digital or hard copies of part
-- or all of this work for personal or classroom use is granted without fee
-- provided that copies are not made or distributed for profit or commercial
-- advantage and that copies bear this notice and the full citation of this work.
-- Prior permission is required to copy, republish, redistribute or post this work.
-- This notice is adapted from the ACM copyright notice.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY fourBitCounter IS
	PORT(
		i_resetBar, i_load : IN STD_LOGIC;
		i_clock : IN STD_LOGIC;
		o_Value : OUT STD_LOGIC_VECTOR(3 downto 0));
END fourBitCounter;

ARCHITECTURE rtl OF fourBitCounter IS
	SIGNAL int_a, int_na, int_b, int_nb, int_c, int_nc, int_d, int_nd : STD_LOGIC;
	SIGNAL int_notA, int_notB, int_notC, int_notD : STD_LOGIC;

	COMPONENT enARdFF_2
		PORT(
			i_resetBar	: IN	STD_LOGIC;
			i_d		: IN	STD_LOGIC;
			i_enable	: IN	STD_LOGIC;
			i_clock		: IN	STD_LOGIC;
			o_q, o_qBar	: OUT	STD_LOGIC);
	END COMPONENT;
BEGIN

-- Concurrent Signal Assignment
	int_na <= (int_a and (not(int_b) or not(int_d) or not(int_c))) or (not(int_a) and int_b and int_c and int_d);
	int_nb <= (not(int_b) and int_c and int_d) or (int_b and (not(int_d) or not(int_c)));
	int_nc <= int_c xor int_d;
	int_nd <= not(int_d);

msb: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
		 i_d => int_na,
		 i_enable => i_load,
		 i_clock => i_clock,
		 o_q => int_a,
		 o_qBar => int_notA);

sb2: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
		i_d => int_nb,
		i_enable => i_load,
		i_clock => i_clock,
		o_q => int_b,
		o_qBar => int_notB);

sb1: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
		i_d => int_nc,
		i_enable => i_load,
		i_clock => i_clock,
		o_q => int_c,
		o_qBar => int_notC);

lsb: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
		 i_d => int_nd,
		 i_enable => i_load,
		 i_clock => i_clock,
		 o_q => int_d,
		 o_qBar => int_notD);

-- Output Driver
o_Value <= int_a & int_b & int_c & int_d;

END rtl;