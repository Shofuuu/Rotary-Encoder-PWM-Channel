----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Muhammad Shofuwan Anwar 
-- 
-- Create Date: 05/19/2024 11:08:58 PM
-- Design Name: 
-- Module Name: encoder - Behavioral
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

entity encoder is
    port (
        clk     : in std_logic;
        rst     : in std_logic;
        a       : in std_logic;
        b       : in std_logic;
        count   : out std_logic_vector(3 downto 0)
    );
end encoder;

architecture Behavioral of encoder is
    constant INDEX_1 : std_logic_vector(3 downto 0) := x"8";
    constant INDEX_2 : std_logic_vector(3 downto 0) := x"7";
    constant INDEX_3 : std_logic_vector(3 downto 0) := x"2";
    constant INDEX_4 : std_logic_vector(3 downto 0) := x"d";
    
    signal state_a : std_logic_vector(1 downto 0);
    signal state_b : std_logic_vector(1 downto 0);
    signal curr_state : std_logic_vector(3 downto 0);
    
    signal value : unsigned(3 downto 0) := (others => '0');
begin
    curr_state <= state_a(0) & state_a(1) & state_b(0) & state_b(1);
    count <= std_logic_vector(value);
    
    encoder_process : process (rst, clk) begin
        if rst = '1' then
            state_a <= "00";
            state_b <= "00";
            value <= (others => '0');
        elsif rising_edge(clk) then
            state_a <= state_a(0) & a;
            state_b <= state_b(0) & b;
            
            case curr_state is
            when INDEX_1 | INDEX_2 => value <= value + 1;
            when INDEX_3 | INDEX_4 => value <= value - 1;
            
            when others => value <= value;
            end case;
        end if;
    end process;
end Behavioral;
