library ieee;
use ieee.std_logic_1164.all;

entity oneBitFullAdder is
    port (
        i_X, i_Y: in std_logic;
        i_Cin: in std_logic;
        o_S: out std_logic;
        o_Cout: out std_logic;
        o_P, o_G: out std_logic
    );
end oneBitFullAdder;

architecture Structural of oneBitFullAdder is
begin
    o_S <= i_X xor i_Y xor i_Cin;
    o_Cout <= (i_X and i_Y) or (i_Cin and i_X) or (i_Cin and i_Y);
    o_P <= i_X or i_Y;
    o_G <= i_X and i_Y;
end;
