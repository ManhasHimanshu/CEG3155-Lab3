 LIBRARY ieee;
 USE ieee.std_logic_1164.ALL;
 USE ieee.numeric_std.ALL;
 
ENTITY trafficLightController IS
	PORT(
		SSCS, select_cnt, GClock, GResetBar, GEnable			: IN	STD_LOGIC;
		Timer          : IN STD_LOGIC_VECTOR(3 downto 0);
		MSTL, SSTL		: OUT	STD_LOGIC_VECTOR(2 downto 0);
		BCD1, BCD2		: OUT	STD_LOGIC_VECTOR(3 downto 0));
	
END trafficLightController;

ARCHITECTURE rtl OF trafficLightController IS
	SIGNAL Y2	: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL SUB	: STD_LOGIC;
	SIGNAL zero_flag : STD_LOGIC;
	SIGNAL current_time: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL next_time: STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	COMPONENT fourBitAdderSubtractor
	PORT(
		  i_X, i_Y: in STD_LOGIC_VECTOR(3 downto 0);
        i_SUB: in STD_LOGIC;
        o_S: out STD_LOGIC_VECTOR(3 downto 0);
        o_Cout: out STD_LOGIC;
        o_V, o_Z: out STD_LOGIC
	);
	END COMPONENT;

	COMPONENT enARdFF_2
		PORT(
			i_resetBar	: IN	STD_LOGIC;
			i_d		: IN	STD_LOGIC;
			i_enable	: IN	STD_LOGIC;
			i_clock		: IN	STD_LOGIC;
			o_q, o_qBar	: OUT	STD_LOGIC);
	END COMPONENT;
	
	BEGIN
	SUB <= '1'; --i_sub=1 to do subtract

	Y2 <= "0001"; --minus one

	current_time <= Timer;
	MSB: enARdFF_2
		PORT MAP(
			i_resetBar => GResetBar,
			i_d => current_time(3),
			i_enable => GEnable,
			i_clock => GClock,
			o_q => next_time(3),
			o_qBar => OPEN);
	RSB: enARdFF_2
		PORT MAP(
			i_resetBar => GResetBar,
			i_d => current_time(2),
			i_enable => GEnable,
			i_clock => GClock,
			o_q => next_time(2),
			o_qBar => OPEN);
	SSB: enARdFF_2
		PORT MAP(
			i_resetBar => GResetBar,
			i_d => current_time(1),
			i_enable => GEnable,
			i_clock => GClock,
			o_q => next_time(1),
			o_qBar => OPEN);
	LSB: enARdFF_2
		PORT MAP(
			i_resetBar => GResetBar,
			i_d => current_time(0),
			i_enable => GEnable,
			i_clock => GClock,
			o_q => next_time(0),
			o_qBar => OPEN);
	
	MINS: fourBitAdderSubtractor
		PORT MAP(
			i_X => next_time, 
			i_Y => Y2,
			i_SUB => SUB,
			o_S => current_time,
			o_Cout => OPEN,
			o_V => OPEN,
			o_Z => zero_flag);
			
	END rtl;
			