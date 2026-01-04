--####################################################################

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;
USE ieee.std_logic_arith.all;
--USE work.comp_somadores.all;

ENTITY SUM_GEN IS
GENERIC (N: INTEGER:=32; K : integer  :=2);
PORT ( A,B : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
       Y   : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
      );
END SUM_GEN;
ARCHITECTURE COMP OF SUM_GEN IS
BEGIN
Y<= A + B;

END COMP;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;
USE ieee.std_logic_arith.all;
--USE work.comp_somadores.all;

ENTITY SUM_GEN_2 IS
GENERIC (N: INTEGER:=32);
PORT ( A,B : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
       Y   : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
      );
END SUM_GEN_2;
ARCHITECTURE COMP OF SUM_GEN_2 IS
BEGIN
Y<= A + B;
END COMP;

-----------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_arith.all;
USE IEEE.STD_LOGIC_SIGNED.ALL;

ENTITY REG_GEN IS
GENERIC (N: INTEGER);
PORT(clock,LD, CL: IN STD_LOGIC;
     A: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
     S: OUT STD_LOGIC_VECTOR (N-1 DOWNTO 0));
END REG_GEN;

ARCHITECTURE COMP OF REG_GEN IS
SIGNAL MS: STD_LOGIC_VECTOR(N -1 DOWNTO 0);
BEGIN
PROCESS(clock,CL)
BEGIN
IF CL = '1' THEN
MS  <= (others => '0');
ELSIF (clock'event and clock='1')then
if LD ='1' then
MS <= A;
else
MS<=MS;
end if;
end if;
S<=MS;
END PROCESS;
END COMP;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;
USE ieee.std_logic_arith.all;

ENTITY MULT_GEN IS
GENERIC (N: INTEGER);
PORT ( A,B : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
       Y   : OUT STD_LOGIC_VECTOR(2*N-1 DOWNTO 0)
      );
END MULT_GEN;
ARCHITECTURE COMP OF MULT_GEN IS
BEGIN
Y <= A * B;

END COMP;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_arith.all;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY TRUN_GEN_C IS
GENERIC (N: INTEGER);
PORT	(A: IN STD_LOGIC_VECTOR(4*N-1 DOWNTO 0);
	 Y: OUT STD_LOGIC_VECTOR(2*N-1 DOWNTO 0));
END TRUN_GEN_C;

ARCHITECTURE COMP7 OF TRUN_GEN_C IS
BEGIN
--Y <= A(4*N-1)&A(3*N-4 DOWNTO N+6);--7
--Y <= A(4*N-1)&A(3*N-2 DOWNTO N);--8 funciona 1,50,25
--Y <= A(4*N-1)&A(3*N-1 DOWNTO N+1);--9
--Y <= A(4*N-1)&A(3*N DOWNTO N+2);--10
--Y <= A(4*N-1)&A(3*N+1 DOWNTO N+3); --11
Y <= A(4*N-1)&A(3*N+2 DOWNTO N+4);--12  *
--Y <= A(4*N-1)&A(3*N+3 DOWNTO N+5);--13
--Y <= A(4*N-1)&A(3*N+4 DOWNTO N+6);--14
END COMP7;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity div32 is
    generic (N : integer := 16);
    port (
        A : in std_logic_vector(N-1 downto 0);
        Y : out std_logic_vector(N-1 downto 0)
    );
end entity;

architecture behavior of div32 is
    signal A_signed : std_logic_vector(N-1 downto 0);
    signal temp     : std_logic_vector(N-1 downto 0);
begin
    process(A)
        variable temp_var : std_logic_vector(N-1 downto 0);
    begin
        A_signed <= A;

        -- Fazendo shift aritmético manual (preservando o bit de sinal):
        -- Shift Right Arithmetic por 5 (dividir por 32)
        temp_var := (others => A(N-1));  -- Preenche com o bit de sinal
        temp_var(N-6 downto 0) := A(N-1 downto 5);
        temp <= temp_var;

        Y <= temp;
    end process;
end architecture;

--------------------------------------------------------------
library ieee;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_arith.all;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY twoscompliment is
generic (N:integer:=32);
PORT ( 
           --Inputs
           A : in std_logic_vector (N-1 downto 0);
           --Outputs
           Y : out std_logic_vector (N-1 downto 0)
);
end twoscompliment;

architecture COMP of twoscompliment is
signal A_aux: STD_LOGIC_VECTOR(N-1 DOWNTO 0);
 begin
  A_aux<=(not A);
  Y <= A_aux + '1';
 end COMP;


 -------------------- File comp_gen.vhd: ----------------------
 LIBRARY ieee;
 USE ieee.std_logic_1164.all;

PACKAGE comp_gen IS

COMPONENT SUM_GEN IS
GENERIC (N: INTEGER:=32; K : integer  :=2);
--GENERIC (N: INTEGER);
PORT ( A,B : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
       Y   : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
      );
END COMPONENT;

COMPONENT REG_GEN IS
GENERIC (N: INTEGER);
PORT(clock,LD, CL: IN STD_LOGIC;
     A: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
     S: OUT STD_LOGIC_VECTOR (N-1 DOWNTO 0));
END COMPONENT;

COMPONENT MULT_GEN IS
GENERIC (N: INTEGER);
PORT ( A,B : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
       Y   : OUT STD_LOGIC_VECTOR(2*N-1 DOWNTO 0)
      );
END COMPONENT;

COMPONENT TRUN_GEN_C IS
GENERIC (N: INTEGER);
PORT	(A: IN STD_LOGIC_VECTOR(4*N-1 DOWNTO 0);
	 Y: OUT STD_LOGIC_VECTOR(2*N-1 DOWNTO 0));
END COMPONENT;

COMPONENT twoscompliment is
	GENERIC (N: INTEGER:= 32);
	PORT ( 
			   --Inputs
			   A : in std_logic_vector (N-1 downto 0);
			   --Outputs
			   Y : out std_logic_vector (N-1 downto 0)
	);
END COMPONENT;

COMPONENT div32 is
    generic (N : integer := 16);
    port (
        A : in std_logic_vector(N-1 downto 0);
        Y : out std_logic_vector(N-1 downto 0)
    );
end COMPONENT;

END comp_gen;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_signed.all;
--use ieee.numeric_std.all;
USE work.comp_gen.all;

ENTITY HPF_biowear IS
GENERIC (N: integer := 16); -- Q7.9 format
PORT (
    reset, clk, ld_l: IN STD_LOGIC;
    X: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
    S_HPF: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
);
END HPF_biowear;

ARCHITECTURE comportamento OF HPF_biowear IS
    SIGNAL X0, X1, X2, X3, X4, X5, X6, X7, X8, X9, X10, X11, X12, X13, X14, X15: STD_LOGIC_VECTOR(N-1 DOWNTO 0);
    SIGNAL X16, X17, X18, X19, X20, X21, X22, X23, X24, X25, X26, X27, X28, X29, X30, X31, X32: STD_LOGIC_VECTOR(N-1 DOWNTO 0);
    SIGNAL X_B0, X_B0_inv, X_B16, X_B17_inv, X_B32: STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL Y0, Y1: STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL Sum00, Sum01, FIR_part: STD_LOGIC_VECTOR(15 DOWNTO 0);
    --SIGNAL Y_A1, Y_A2_inv: STD_LOGIC_VECTOR(15 DOWNTO 0);
    --signal temp1 : STD_LOGIC;
	 signal sum_result : std_logic_vector(15 downto 0);
	 signal cnt : integer range 0 to 64 := 0;
	 signal data_valid, reset_2, temp1 : std_logic := '0';
    -- Sinais auxiliares para -2x[n-6]
    --SIGNAL X6_ext, X6_shifted: STD_LOGIC_VECTOR(15 DOWNTO 0);
    -- Sinal para substituir FIR_part durante teste
    --SIGNAL FIR_part_test : STD_LOGIC_VECTOR(15 DOWNTO 0) := (others => '0');
BEGIN
    -- Pipeline de entrada
    R0_l: REG_GEN generic map(N) port map(clk,ld_l,reset, X,X0);    
    R1_l: REG_GEN generic map(N) port map(clk,ld_l,reset,X0,X1);    
    R2_l: REG_GEN generic map(N) port map(clk,ld_l,reset,X1,X2);    
    R3_l: REG_GEN generic map(N) port map(clk,ld_l,reset,X2,X3);    
    R4_l: REG_GEN generic map(N) port map(clk,ld_l,reset,X3,X4);    
    R5_l: REG_GEN generic map(N) port map(clk,ld_l,reset,X4,X5);    
    R6_l: REG_GEN generic map(N) port map(clk,ld_l,reset,X5,X6);    
    R7_l: REG_GEN generic map(N) port map(clk,ld_l,reset,X6,X7);    
    R8_l: REG_GEN generic map(N) port map(clk,ld_l,reset,X7,X8);
    R9_l: REG_GEN generic map(N) port map(clk,ld_l,reset,X8,X9);
    R10_l: REG_GEN generic map(N) port map(clk,ld_l,reset,X9,X10);    
    R11_l: REG_GEN generic map(N) port map(clk,ld_l,reset,X10,X11);    
    R12_l: REG_GEN generic map(N) port map(clk,ld_l,reset,X11,X12);
    R13_l: REG_GEN generic map(N) port map(clk,ld_l,reset,X12,X13);
    R14_l: REG_GEN generic map(N) port map(clk,ld_l,reset,X13,X14);
    R15_l: REG_GEN generic map(N) port map(clk,ld_l,reset,X14,X15);
    R16_l: REG_GEN generic map(N) port map(clk,ld_l,reset,X15,X16);
    R17_l: REG_GEN generic map(N) port map(clk,ld_l,reset,X16,X17);
    R18_l: REG_GEN generic map(N) port map(clk,ld_l,reset,X17,X18);
    R19_l: REG_GEN generic map(N) port map(clk,ld_l,reset,X18,X19);    
    R20_l: REG_GEN generic map(N) port map(clk,ld_l,reset,X19,X20);    
    R21_l: REG_GEN generic map(N) port map(clk,ld_l,reset,X20,X21);    
    R22_l: REG_GEN generic map(N) port map(clk,ld_l,reset,X21,X22);    
    R23_l: REG_GEN generic map(N) port map(clk,ld_l,reset,X22,X23);    
    R24_l: REG_GEN generic map(N) port map(clk,ld_l,reset,X23,X24);    
    R25_l: REG_GEN generic map(N) port map(clk,ld_l,reset,X24,X25);    
    R26_l: REG_GEN generic map(N) port map(clk,ld_l,reset,X25,X26);    
    R27_l: REG_GEN generic map(N) port map(clk,ld_l,reset,X26,X27);    
    R28_l: REG_GEN generic map(N) port map(clk,ld_l,reset,X27,X28);    
    R29_l: REG_GEN generic map(N) port map(clk,ld_l,reset,X28,X29);    
    R30_l: REG_GEN generic map(N) port map(clk,ld_l,reset,X29,X30);    
    R31_l: REG_GEN generic map(N) port map(clk,ld_l,reset,X30,X31);    
    R32_l: REG_GEN generic map(N) port map(clk,ld_l,reset,X31,X32);    
    
    -- y[n] = y[n-1] - \frac{x[n]}{32} + x[n-16]-x[n-17]+\frac{x[n-32]}{32}

    -- Extensão de sinal correta para 16 bits
    --X_B0 <= X0(N-1) & "0000" & X0(N-1 downto 5);
    --X_B0 <= "00000" & X0(N-1 downto 5);
    U_DIV_XB0: div32 generic map(16) port map(X0, X_B0);
	 inv_B0: twoscompliment generic map(16) port map(X_B0, X_B0_inv);
    --X_B16 <= X16;
    
    -- Cálculo de -2x[n-6]:
    inv_B17: twoscompliment generic map(16) port map(X17, X_B17_inv);
    --X_B32 <= X32(N-1) & "0000" & X32(N-1 downto 5);          
    --X_B32 <= "00000" & X32(N-1 downto 5);
    U_DIV_XB32: div32 generic map(16) port map(X32, X_B32);          
    

    -- Parte FIR: x[n]/32 + x[n-16] - x[n-17] + x[n-32]/32
    SUM_0: SUM_GEN generic map(N) port map(X_B0_inv, X16, Sum00);
    SUM_1: SUM_GEN generic map(N) port map(Sum00, X_B17_inv, Sum01);
    SUM_2: SUM_GEN generic map(N) port map(Sum01, X_B32, FIR_part);
    

    -- Parte IIR: y[n-1] 
    
    --S_HPF <= FIR_part;
    --SUM_3: SUM_GEN generic map(16) port map(FIR_part, Y1, Y0); sum_result
	 SUM_3: SUM_GEN generic map(16) port map(FIR_part, Y1, sum_result); 
	 -- SUM_3: SUM_GEN generic map(16) port map(FIR_part, IIR_part, S_HPF);
    -- >>> TESTE DA PARTE IIR: Substitua FIR_part por FIR_part_test <<<
    --FIR_part_test <= (others => '0');  -- Força entrada FIR para zero
    -- Teste: FIR 0.5 + IIR 0.5 = 1.0
    --FIR_part_test <= X_B0; -- 0.5
    --IIR_part <= "0000000000000000"; -- 0.5

--	 process (clk, reset)
--begin
--    if reset = '1' then
--        Y1 <= (others => '0');
--        Y0 <= (others => '0');
--       -- FIR_part <= (others => '0');
--    elsif rising_edge(clk) then
--        if ld_l = '1' then
--            Y1 <= Y0;
--        end if;
--    end if;
--end process;
    process(clk, reset)
begin
    if reset = '1' then
        cnt <= 0;
        data_valid <= '0';
    elsif rising_edge(clk) then
        if cnt < 33 then
            cnt <= cnt + 1;
				reset_2 <='1';
        else
            data_valid <= '1';
				--temp1<= data_valid and ld_l;
				reset_2 <='0';
        end if;
    end if;
end process;
    
    -- Registradores de saída e realimentação
    --R13_l: REG_GEN generic map(16) port map(clk, ld_l, reset, Sum03, Y0);
    --R33_l: REG_GEN generic map(16) port map(clk, ld_l, reset, sum_result, Y1);
	 R33_l: REG_GEN generic map(16) port map(clk, data_valid, reset_2, sum_result, Y1);	 
    --R15_l: REG_GEN generic map(16) port map(clk, ld_l, reset, Y1, Y2);
    --S_HPF <= FIR_part;
   -- Saída final
Y0 <= sum_result;
S_HPF <= Y0;
END comportamento;

-----------------------------------------------------