----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Muhammad Shofuwan Anwar
-- 
-- Create Date: 05/19/2024 11:23:05 PM
-- Design Name: 
-- Module Name: jkff - Behavioral
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

entity jkff is
    port (
        j       : in std_logic;
        k       : in std_logic;
        clk     : in std_logic;
        rst     : in std_logic;
        q       : out std_logic
    );
end jkff;

architecture Behavioral of jkff is
    signal q_buff   : std_logic;
begin
    jkff_process : process (clk,rst) begin
        if rst = '1' then
            q_buff <= '0';
        elsif rising_edge(clk) then
            if j = '0' and k = '0' then
                q_buff <= q_buff;
            elsif j = '0' and k = '1' then
                q_buff <= '0';
            elsif j = '1' and k = '0' then
                q_buff <= '1';
            elsif j = '1' and k = '1' then
                q_buff <= not q_buff;
            end if;
        end if;
    end process;
    
    q <= q_buff;
end Behavioral;
