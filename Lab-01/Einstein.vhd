library IEEE;
use IEEE.std_logic_1164.all;


entity Einstein is

  port(iCLK             : in std_logic;
       mass 		        : in integer;
       energy 		      : out integer);

end Einstein;

architecture structure of Einstein is
  
  -- Describe the component entities as defined in Adder.vhd 
  -- and Multiplier.vhd (not strictly necessary).

  component Multiplier
    port(iCLK           : in std_logic;
         iA             : in integer;
         iB             : in integer;
         oC             : out integer);
  end component;

  -- Constant of C squared for E= Mc^2, using c = 9487 so c squared is 90003169
  constant C2 : integer := 90003169;


begin

  
  ---------------------------------------------------------------------------
  -- Level 1: Calculate C2 * mass
  ---------------------------------------------------------------------------
  g_Mult1: Multiplier
    port MAP(iCLK             => iCLK,
             iA               => C2,
             iB               => mass,
             oC               => energy);

     
  
end structure;
