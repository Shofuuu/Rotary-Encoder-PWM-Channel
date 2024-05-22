----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Muhammad Shofuwan Anwar
-- 
-- Create Date: 05/19/2024 09:03:23 PM
-- Design Name: 
-- Module Name: debounce - Behavioral
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

entity debounce is
    port (
        button      : in std_logic;
        clk         : in std_logic;
        rst         : in std_logic;
        debounced   : out std_logic
    );
end debounce;

architecture Behavioral of debounce is
    signal data : std_logic_vector(7 downto 0);
begin
    shifting_bit : process (rst, clk) begin
        if rst = '1' then
            data <= (others => '0');
            debounced <= '0';
        elsif rising_edge(clk) then
            data <= data(6 downto 0) & button;
            
            if data = x"ff" then
                debounced <= '1';
            elsif data = x"00" then
                debounced <= '0'; 
            end if;
        end if;
    end process;
end Behavioral;
