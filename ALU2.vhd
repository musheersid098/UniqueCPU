LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

ENTITY ALU2 IS
    PORT (
        clk, res : IN STD_LOGIC;
        A, B     : IN UNSIGNED(7 DOWNTO 0);
        opcode   : IN UNSIGNED(15 DOWNTO 0);
        Neg1, Neg2 : OUT STD_LOGIC;
        R1, R2   : OUT UNSIGNED(3 DOWNTO 0)
    );
END ALU2;


architecture ModifiedBehavior of ALU2 is
    signal Reg1, Reg2, Result : unsigned(7 downto 0);
begin

    process(clk)
    begin
        if rising_edge(clk) then  -- Fixed the clock signal case
            Reg1 <= A;
            Reg2 <= B;
            case opcode is
                when "0000000000000001" =>  -- Shift right by 2 bits, pad with "11"
                    Result <= "11" & Reg1(7 downto 2);
                   
                when "0000000000000010" =>  -- Subtraction with conditional Neg
                    if Reg1 < Reg2 then
                        Result <= (Reg2 - Reg1);
								Neg1 <= '1';
								Neg2 <= '1';
                    else
                        Result <= (Reg1 - Reg2);
								Neg1 <= '0';
								Neg2 <= '0';
								
                    end if;

                when "0000000000000100" =>  -- Maximum value between Reg1 and Reg2
                    Neg1 <= '0';
						  Neg2 <= '0';
						 if Reg1 > Reg2 then
						  Result <= Reg1;
                    else
                        Result <= Reg2;
                    end if;
					Result <= Result + to_unsigned(4,8);
                when "0000000000001000" =>  -- Swap lower 4 bits of Reg1 and Reg2
						Neg1 <= '0';
						  Neg2 <= '0';
                  Result <= Reg2(3 downto 0) & Reg1(3 downto 0);
                    Reg1 <= Reg2(3 downto 0) & Reg1(3 downto 0);
                    Reg2 <= Reg2(7 downto 4) & Reg1(7 downto 4);

                when "0000000000010000" =>  -- Increment Reg1 by 1
					  Neg1 <= '0';
						  Neg2 <= '0';
                  Result <= Reg1 + to_unsigned(1, 8);

                when "0000000000100000" =>  -- Boolean AND
					  Neg1 <= '0';
						  Neg2 <= '0';
                 Result <= Reg1 AND Reg2;

                when "0000000001000000" =>  -- Invert upper 4 bits of Reg1
                 Neg1 <= '0';
						Neg2 <= '0';
					 Result <= NOT(Reg1(7 downto 4)) & Reg1(3 downto 0);

                when "0000000010000000" =>  -- Rotate Reg2 LEFT by 3 bits
					 Result <= Reg2(4 downto 0) & Reg2(7 downto 5);

                when others =>  -- Default case for unknown opcode values
                  Result <= "00000000";
            end case;
        end if;
    end process;



    
    R1 <= Result(3 DOWNTO 0);  -- lower 4 bits    
    R2 <= Result(7 DOWNTO 4);  -- upper 4 bits         
END ModifiedBehavior;
