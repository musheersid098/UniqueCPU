LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

ENTITY ALU IS
    PORT (
        clk, res : IN STD_LOGIC;
        A, B     : IN UNSIGNED(7 DOWNTO 0);
        opcode   : IN UNSIGNED(15 DOWNTO 0);
        Neg1, Neg2 : OUT STD_LOGIC;
        R1, R2   : OUT UNSIGNED(3 DOWNTO 0)
    );
END ALU;

ARCHITECTURE Behavior OF ALU IS
    SIGNAL Reg1, Reg2, Result : UNSIGNED(7 DOWNTO 0) := (OTHERS => '0');
BEGIN
    -- Continuous assignment of A and B to registers
    Reg1 <= A;
    Reg2 <= B;

    PROCESS (clk, res)
    BEGIN
        --IF res = '0' THEN
        --    Result <= (OTHERS => '0');  -- Clear result
        IF (clk'EVENT AND clk = '1') THEN
            -- Perform operations based on opcode
            CASE opcode IS
                WHEN "0000000000000001" => -- 1: SUM
                    Result <= Reg2 + Reg1;
                WHEN "0000000000000010" => -- 2: DIFFERENCE
                    IF Reg1 < Reg2 THEN
                        Result <= (Reg2 - Reg1);
                    ELSE
                        Result <= (Reg1 - Reg2);
                    END IF;
                WHEN "0000000000000100" => -- 3: NOT A
                    Result <= NOT(Reg1);
                WHEN "0000000000001000" => -- 4: A NAND B
                    Result <= NOT(Reg1 AND Reg2);
                WHEN "0000000000010000" => -- 5: A NOR B
                    Result <= NOT(Reg1 OR Reg2);
                WHEN "0000000000100000" => -- 6: A AND B
                    Result <= (Reg1 AND Reg2);
                WHEN "0000000001000000" => -- 7: A XOR B
                    Result <= (Reg1 XOR Reg2);
                WHEN "0000000010000000" => -- 8: A OR B
                    Result <= (Reg1 OR Reg2);
                WHEN OTHERS => -- Default case
                    Result <= (OTHERS => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- Assign outputs
    R1 <= Result(3 DOWNTO 0);       -- Lower 4 bits
    R2 <= Result(7 DOWNTO 4);       -- Upper 4 bits
    Neg1 <= Result(7);              -- Most significant bit
    Neg2 <= Result(3);              -- 4th bit
END Behavior;
