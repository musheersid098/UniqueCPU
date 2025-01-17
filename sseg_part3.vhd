LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY sseg_part3 IS
PORT (bcd : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		neg : IN STD_LOGIC;
		leds, leds_sign : OUT STD_LOGIC_VECTOR(0 TO 6));
END sseg_part3;

ARCHITECTURE Behavior OF sseg_part3 IS
	BEGIN
		PROCESS (bcd, neg)
		BEGIN
			if (neg = '0') then
				leds_sign <= ("0000000");
			end if;
			if (neg = '1') then
				leds_sign <= ("0000001");
			end if;

	CASE bcd IS -- abcdefg
		WHEN "0000" =>leds <= NOT("0010101"); -- odd (n)
		WHEN "0001" =>leds <= NOT("0111011"); -- even (y)
		WHEN OTHERS =>leds <= ("-------");
	END CASE;
END PROCESS;
END Behavior;