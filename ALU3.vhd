LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY ALU3 IS
    PORT (
        clk       : IN  STD_LOGIC;
        A, B        : IN  UNSIGNED(7 DOWNTO 0);
        Student_id  : IN  UNSIGNED(3 DOWNTO 0);
        OP          : IN  UNSIGNED(15 DOWNTO 0); 
        Result      : OUT UNSIGNED(3 DOWNTO 0)  -- Result: Binary representation of 'y' or 'n'
    );
END ALU3;

ARCHITECTURE Behavior OF ALU3 IS
    SIGNAL Parity: STD_LOGIC;
BEGIN

    -- Process to calculate parity of Student_id (8 bits)
    PROCESS (Student_id)
    BEGIN
        -- XOR all bits of Student_id to determine parity
        Parity <= Student_id(0) XOR Student_id(1) XOR Student_id(2) XOR Student_id(3);
		  END PROCESS;

    -- Main process for opcode evaluation
    PROCESS (clk, OP)
    BEGIN
        IF rising_edge(clk) THEN
            CASE OP IS
                WHEN "0000000000000001" =>
                    -- For OP = "0000000000000001"
                    IF Parity = '0' THEN  -- Even parity
                        Result <= "0011";  -- Binary for 'y'
                    ELSE
                        Result <= "1110";  -- Binary for 'n'
                    END IF;

                WHEN "0000000000000010" =>
                    -- For OP = "0000000000000010"
                    IF Parity = '0' THEN  -- Even parity
                        Result <= "0011";  -- Binary for 'y'
                    ELSE
                        Result <= "1110";  -- Binary for 'n'
                    END IF;

                WHEN "0000000000000100" =>
                    -- For OP = "0000000000000100"
                    IF Parity = '0' THEN  -- Even parity
                        Result <= "0011";  -- Binary for 'y'
                    ELSE
                        Result <= "1110";  -- Binary for 'n'
                    END IF;

                WHEN "0000000000001000" =>
                    -- For OP = "0000000000001000"
                    IF Parity = '0' THEN  -- Even parity
                        Result <= "0011";  -- Binary for 'y'
                    ELSE
                        Result <= "1110";  -- Binary for 'n'
                    END IF;

                WHEN "0000000000010000" =>
                    -- For OP = "0000000000010000"
                    IF Parity = '0' THEN  -- Even parity
                        Result <= "0011";  -- Binary for 'y'
                    ELSE
                        Result <= "1110";  -- Binary for 'n'
                    END IF;

                WHEN "0000000000100000" =>
                    -- For OP = "0000000000100000"
                    IF Parity = '0' THEN  -- Even parity
                        Result <= "0011";  -- Binary for 'y'
                    ELSE
                        Result <= "1110";  -- Binary for 'n'
                    END IF;

                WHEN "0000000001000000" =>
                    -- For OP = "0000000001000000"
                    IF Parity = '0' THEN  -- Even parity
                        Result <= "0011";  -- Binary for 'y'
                    ELSE
                        Result <= "1110";  -- Binary for 'n'
                    END IF;

                WHEN "0000000010000000" =>
                    -- For OP = "0000000010000000"
                    IF Parity = '0' THEN  -- Even parity
                        Result <= "0011";  -- Binary for 'y'
                    ELSE
                        Result <= "1110";  -- Binary for 'n'
                    END IF;

                WHEN OTHERS =>
                    -- Default case: For all other values of OP
                    Result <= "0000";  -- Default result (can be changed to something else)
            END CASE;
        END IF;
    END PROCESS;

END Behavior;
