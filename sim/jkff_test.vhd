----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/20/2024 07:58:38 AM
-- Design Name: 
-- Module Name: jkff_test - Behavioral
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

entity jkff_test is
--  Port ( );
end jkff_test;

architecture Behavioral of jkff_test is
    component jkff is
        port (
            j       : in std_logic;
            k       : in std_logic;
            clk     : in std_logic;
            rst     : in std_logic;
            q       : out std_logic
        );
    end component;
    
    signal sig_j    : std_logic;
    signal sig_k    : std_logic;
    signal sig_clk  : std_logic;
    signal sig_rst  : std_logic;
    signal sig_q    : std_logic;
begin
    jkff0 : jkff port map (
        j   => sig_j,
        k   => sig_k,
        clk => sig_clk,
        rst => sig_rst,
        q   => sig_q
    );
    
    -- generate 100 MHz clk
    system_clk : process begin
        sig_clk <= '1';
        wait for 10 ns;
        sig_clk <= '0';
        wait for 10 ns;
    end process;
    
    jkff_test0 : process begin
        sig_j <= '0';
        sig_k <= '0';
        sig_rst <= '1';
        wait for 20 ns;
        sig_rst <= '0';
        
        sig_j <= '0';
        sig_k <= '0';
        wait for 20 ns;
        
        sig_j <= '1';
        sig_k <= '0';
        wait for 20 ns;
        
        sig_j <= '0';
        sig_k <= '1';
        wait for 20 ns;
        
        sig_j <= '1';
        sig_k <= '1';
        wait for 20 ns;
        
        sig_j <= '1';
        sig_k <= '1';
        wait for 20 ns;
        
        sig_j <= '0';
        sig_k <= '0';
        wait for 20 ns;
        
        sig_j <= '1';
        sig_k <= '0';
        wait for 20 ns;
        
        sig_j <= '0';
        sig_k <= '1';
        wait for 20 ns;
        
        wait;
    end process;
end Behavioral;
