library ieee;
use ieee.std_logic_1164.all;

entity fourBitAdderSubtractor is
    port (
        i_X, i_Y: in std_logic_vector(3 downto 0);
        i_SUB: in std_logic;
        o_S: out std_logic_vector(3 downto 0);
        o_Cout: out std_logic;
        o_V, o_Z: out std_logic
    );
end;

architecture Structural of fourBitAdderSubtractor is
    component fourBitAdder
        port (
            i_X, i_Y: in std_logic_vector(3 downto 0);
            i_Cin: in std_logic;
            o_S: out std_logic_vector(3 downto 0);
            o_Cout: out std_logic;
            o_P, o_G: out std_logic;--lookahead
            o_V, o_Z: out std_logic--overflow flag(V); zero flag(Z)
        );
    end component;
    
    signal signalY: std_logic_vector(3 downto 0);
begin
    generateSignalY:
        for i in 3 downto 0 generate
            signalY(i) <= i_Y(i) xor i_SUB;
        end generate;
    
    adder4Inst: fourBitAdder
        port map (
            i_X => i_X,
            i_Y => signalY,
            i_Cin => i_SUB,
            o_S => o_S,
            o_Cout => o_Cout,
            o_V => o_V,
            o_Z => o_Z
        );
end;
