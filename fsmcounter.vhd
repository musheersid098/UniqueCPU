LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity fsmcounter IS
	port (data_in, clk, reset : in std_logic;
			student_id : out std_logic_vector(3 DOWNTO 0);
			current_state : out std_logic_vector(3 DOWNTO 0));
end fsmcounter;

ARCHITECTURE fsmcounter OF fsmcounter IS
	type state_type IS (s0, s1, s2, s3, s4, s5, s6, s7);
	signal yfsmcounter : state_type;
BEGIN
	PROCESS (clk, reset)
	BEGIN	if reset = '0' THEN
		yfsmcounter <= s0;
	ELSIF (clk'EVENT AND clk = '1') THEN
		CASE yfsmcounter IS
			WHEN s0 =>
				IF data_in = '1' THEN
					yfsmcounter <= s1;
				END IF;
			WHEN s1 =>
				IF data_in = '1' THEN
					yfsmcounter <= s2;
				END IF;
			WHEN s2 =>
				IF data_in = '1' THEN
					yfsmcounter <= s3;
				END IF;
			WHEN s3 =>
				IF data_in = '1' THEN
					yfsmcounter <= s4;
				END IF;
			WHEN s4 =>
				IF data_in = '1' THEN
					yfsmcounter <= s5;
				END IF;
			WHEN s5 =>
				IF data_in = '1' THEN
					yfsmcounter <= s6;
				END IF;
			WHEN s6 =>
				IF data_in = '1' THEN
					yfsmcounter <= s7;
				END IF;
			WHEN s7 =>
				IF data_in = '1' THEN
					yfsmcounter <= s0;
				END IF;
		END CASE;
	END IF;
	END PROCESS;
	
	PROCESS (yfsmcounter)
	BEGIN
		CASE yfsmcounter IS
			WHEN s0 => current_state <= "0000";
				student_id <= "0000"; -- d2: 0
			WHEN s1 => current_state <= "0001";
				student_id <= "0001"; -- d3: 1
			WHEN s2 => current_state <= "0010";
				student_id <= "0010"; -- d4: 2
			WHEN s3 => current_state <= "0011";
				student_id <= "0011"; -- d5: 3
			WHEN s4 => current_state <= "0100";
				student_id <= "0000"; -- d6: 0
			WHEN s5 => current_state <= "0101";
				student_id <= "0010"; -- d7: 2
			WHEN s6 => current_state <= "0110";
				student_id <= "0110"; -- d8: 6
			WHEN s7 => current_state <= "0111";
				student_id <= "0110"; -- d9: 6
		END CASE;
	END PROCESS;
END fsmcounter;