library ieee;
use ieee.std_logic_1164.all;

entity fourBitAdder is
    port (
        i_X, i_Y: in std_logic_vector(3 downto 0);
        i_Cin: in std_logic;
        o_S: out std_logic_vector(3 downto 0);
        o_Cout: out std_logic;
        o_P, o_G: out std_logic;
        o_V, o_Z: out std_logic
    );
end;

architecture Structural of fourBitAdder is
    component oneBitFullAdder
        port (
            i_X, i_Y: in std_logic;
            i_Cin: in std_logic;
            o_S: out std_logic;
            o_Cout: out std_logic;
            o_P, o_G: out std_logic
        );
    end component;
    
    component LookaheadCarryUnit
        port (
            i_P, i_G: in std_logic_vector(3 downto 0);
            i_Cin: in std_logic;
            o_PG, o_GG: out std_logic;
            o_C: out std_logic_vector(4 downto 0)
        );
    end component;
    
    signal signalFullAdderCarry: std_logic_vector(4 downto 0);
    signal signalFullAdderG, signalFullAdderP: std_logic_vector(3 downto 0);
    signal signalS: std_logic_vector(3 downto 0);
begin
    generateFullAdder:
        for i in 3 downto 0 generate
            fullAdderInst: oneBitFullAdder
                port map (
                    i_X => i_X(i),
                    i_Y => i_Y(i),
                    i_Cin => signalFullAdderCarry(i),
                    o_S => signalS(i),
                    o_P => signalFullAdderP(i),
                    o_G => signalFullAdderG(i)
                );
        end generate;
    
    lookaheadCarryUnitInst: LookaheadCarryUnit
        port map (
            i_P => signalFullAdderP,
            i_G => signalFullAdderG,
            i_Cin => i_Cin,
            o_C => signalFullAdderCarry,
            o_PG => o_P,
            o_GG => o_G
        );
    
    o_S <= signalS;
    o_Cout <= signalFullAdderCarry(4);
    o_V <= signalFullAdderCarry(4) xor signalFullAdderCarry(3);
    o_Z <= not (signalS(3) or signalS(2) or signalS(1) or signalS(0));
end;
