----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/06/2021 12:25:56 PM
-- Design Name: 
-- Module Name: Si5338_init_program - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
    use IEEE.NUMERIC_STD.ALL;


entity Si5338_init_bram is
  Port (
    
    
    clk : in STD_LOGIC; -- Clk in
    reset : in STD_LOGIC; -- reset in
    bram_addr : in STD_LOGIC_VECTOR(8 downto 0); -- address in
    
    regData : out STD_LOGIC_VECTOR(7 downto 0); -- register data for Si5338
    regMask : out STD_LOGIC_VECTOR(7 downto 0); -- register mask for Si5338
    regAddr : out STD_LOGIC_VECTOR(7 downto 0); -- register address for SI5338
    --
    bram_entries : out STD_LOGIC_VECTOR(9 downto 0) -- Number of entries in BRAM for transaction counter
  );
end Si5338_init_bram;

architecture Behavioral of Si5338_init_bram is

attribute mark_debug : string; 


constant max_entries_bram : integer range 0 to 350 := 348;


type i2c_bram is array (0 to 348) of STD_LOGIC_VECTOR(7 downto 0); 
type i2c_addr is array (0 to 348) of integer range 0 to 255;
type i2c_mask is array (0 to 348) of STD_LOGIC_VECTOR(7 downto 0); 

signal regData_i : STD_LOGIC_VECTOR(7 downto 0);
attribute mark_debug of regData_i : signal is "true";

signal regMask_i : STD_LOGIC_VECTOR(7 downto 0);
attribute mark_debug of regMask_i : signal is "true";

signal regAddr_i : STD_LOGIC_VECTOR(7 downto 0);
attribute mark_debug of regAddr_i : signal is "true";

signal bram_addr_i : STD_LOGIC_VECTOR(8 downto 0);
attribute mark_debug of bram_addr_i : signal is "true";





CONSTANT si5338_init_data : i2c_bram := ( 
x"00",x"00",x"00",x"00",x"00",x"00",x"08",x"00",
x"70",x"0F",x"00",x"00",x"00",x"00",x"00",x"00",
x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
x"00",x"00",x"00",x"70",x"16",x"90",x"B0",x"C0",
x"C0",x"C0",x"C0",x"A2",x"03",x"06",x"06",x"03",
x"77",x"10",x"37",x"00",x"00",x"00",x"00",x"14",
x"35",x"00",x"C3",x"07",x"10",x"00",x"0B",x"00",
x"00",x"00",x"00",x"01",x"00",x"00",x"00",x"10",
x"00",x"18",x"00",x"00",x"00",x"00",x"01",x"00",
x"00",x"00",x"10",x"00",x"0B",x"00",x"00",x"00",
x"00",x"01",x"00",x"00",x"00",x"10",x"00",x"18",
x"00",x"00",x"00",x"00",x"01",x"00",x"00",x"00",
x"10",x"00",x"32",x"00",x"00",x"00",x"00",x"01",
x"00",x"00",x"80",x"00",x"00",x"00",x"40",x"00",
x"00",x"00",x"40",x"00",x"80",x"00",x"40",x"00",
x"00",x"00",x"40",x"00",x"00",x"00",x"00",x"00",
x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
x"00",x"00",x"FF",x"00",x"00",x"00",x"00",x"00",
x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
x"00",x"00",x"00",x"00",x"00",x"0D",x"00",x"00",
x"F4",x"F0",x"00",x"00",x"00",x"00",x"00",x"00",
x"00",x"00",x"00",x"00",x"00",x"14",x"00",x"00",
x"02",x"F0",x"00",x"00",x"00",x"00",x"A8",x"00",
x"84",x"00",x"00",x"00",x"01",x"00",x"00",x"00",
x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
x"00",x"00",x"00",x"00",x"00",x"00",x"01",x"00",
x"00",x"90",x"31",x"00",x"00",x"01",x"00",x"00",
x"00",x"00",x"00",x"00",x"00",x"00",x"01",x"00",
x"00",x"90",x"31",x"00",x"00",x"01",x"00",x"00",
x"00",x"00",x"00",x"00",x"00",x"00",x"01",x"00",
x"00",x"90",x"31",x"00",x"00",x"01",x"00",x"00",
x"00",x"00",x"00",x"00",x"00",x"00",x"01",x"00",
x"00",x"90",x"31",x"00",x"00",x"01",x"00",x"00",
x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
x"00",x"90",x"31",x"00",x"00",x"01",x"00",x"00",
x"00",x"00",x"00",x"00",x"00");

CONSTANT si5338_init_addr : i2c_addr := ( 
  0,  1,  2,  3,  4,  5,  6,  7,
  8,  9, 10, 11, 12, 13, 14, 15,
 16, 17, 18, 19, 20, 21, 22, 23,
 24, 25, 26, 27, 28, 29, 30, 31,
 32, 33, 34, 35, 36, 37, 38, 39,
 40, 41, 42, 43, 44, 45, 46, 47,
 48, 49, 50, 51, 52, 53, 54, 55,
 56, 57, 58, 59, 60, 61, 62, 63,
 64, 65, 66, 67, 68, 69, 70, 71,
 72, 73, 74, 75, 76, 77, 78, 79,
 80, 81, 82, 83, 84, 85, 86, 87,
 88, 89, 90, 91, 92, 93, 94, 95,
 96, 97, 98, 99,100,101,102,103,
104,105,106,107,108,109,110,111,
112,113,114,115,116,117,118,119,
120,121,122,123,124,125,126,127,
128,129,130,131,132,133,134,135,
136,137,138,139,140,141,142,143,
144,145,146,147,148,149,150,151,
152,153,154,155,156,157,158,159,
160,161,162,163,164,165,166,167,
168,169,170,171,172,173,174,175,
176,177,178,179,180,181,182,183,
184,185,186,187,188,189,190,191,
192,193,194,195,196,197,198,199,
200,201,202,203,204,205,206,207,
208,209,210,211,212,213,214,215,
216,217,218,219,220,221,222,223,
224,225,226,227,228,229,231,232,
233,234,235,236,237,238,239,240,
242,243,244,245,247,248,249,250,
251,252,253,254,255,  0,  1,  2,
  3,  4,  5,  6,  7,  8,  9, 10,
 11, 12, 13, 14, 15, 16, 17, 18,
 19, 20, 21, 22, 23, 24, 25, 26,
 27, 28, 29, 30, 31, 32, 33, 34,
 35, 36, 37, 38, 39, 40, 41, 42,
 43, 44, 45, 46, 47, 48, 49, 50,
 51, 52, 53, 54, 55, 56, 57, 58,
 59, 60, 61, 62, 63, 64, 65, 66,
 67, 68, 69, 70, 71, 72, 73, 74,
 75, 76, 77, 78, 79, 80, 81, 82,
 83, 84, 85, 86, 87, 88, 89, 90,
 91, 92, 93, 94,255);

CONSTANT si5338_init_regMask : i2c_mask := ( 
x"00",x"00",x"00",x"00",x"00",x"00",x"1D",x"00",
x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
x"00",x"00",x"00",x"80",x"FF",x"FF",x"FF",x"FF",
x"FF",x"FF",x"FF",x"FF",x"1F",x"1F",x"1F",x"1F",
x"FF",x"7F",x"3F",x"00",x"00",x"FF",x"FF",x"3F",
x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"3F",x"FF",
x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
x"FF",x"3F",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
x"FF",x"FF",x"FF",x"FF",x"3F",x"FF",x"FF",x"FF",
x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"3F",
x"00",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
x"FF",x"FF",x"BF",x"FF",x"FF",x"FF",x"FF",x"FF",
x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
x"FF",x"0F",x"0F",x"FF",x"FF",x"FF",x"FF",x"FF",
x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
x"FF",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"0F",x"0F",
x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
x"FF",x"FF",x"FF",x"FF",x"FF",x"0F",x"FF",x"FF",
x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
x"FF",x"FF",x"FF",x"0F",x"FF",x"FF",x"FF",x"FF",
x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
x"FF",x"FF",x"00",x"00",x"00",x"00",x"00",x"00",
x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
x"02",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
x"00",x"00",x"00",x"00",x"FF",x"00",x"00",x"00",
x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",
x"00",x"00",x"00",x"00",x"FF",x"FF",x"FF",x"FF",
x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
x"0F",x"00",x"00",x"00",x"FF",x"FF",x"FF",x"FF",
x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
x"0F",x"00",x"00",x"00",x"FF",x"FF",x"FF",x"FF",
x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
x"0F",x"00",x"00",x"00",x"FF",x"FF",x"FF",x"FF",
x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",x"FF",
x"0F",x"00",x"00",x"00",x"FF");

Begin

bram_entries <= STD_LOGIC_VECTOR(to_unsigned(max_entries_bram, 10));
bram_addr_i <= bram_addr;

PROCESS(CLK, RESET)
BEGIN

    IF RISING_EDGE(CLK) THEN
    
        IF RESET = '1' THEN
            regData_i <= (others=>'0');
            regMask_i <= (others=>'0');
            regAddr_i <= (others=>'0');
        ELSE
            if(to_integer(unsigned(bram_addr)) <= max_entries_bram) then
                regData_i <= si5338_init_data(to_integer(unsigned(bram_addr)));
                regMask_i <= si5338_init_regMask(to_integer(unsigned(bram_addr)));
                regAddr_i <= STD_LOGIC_VECTOR(to_unsigned(si5338_init_addr(to_integer(unsigned(bram_addr))), 8));        
            else
                regData_i <= (others=>'0');
                regMask_i <= (others=>'1');
                regAddr_i <= (others=>'0');
            end if;                
        END IF;    
    END IF;

END PROCESS;

regData <= regData_i;
regMask <= regMask_i;
regAddr <= regAddr_i;


end Behavioral;
