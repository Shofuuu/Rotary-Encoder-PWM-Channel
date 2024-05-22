----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/20/2024 05:26:44 AM
-- Design Name: 
-- Module Name: encoder_test - Behavioral
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

entity encoder_test is
--  Port ( );
end encoder_test;

architecture Behavioral of encoder_test is
    component encoder is
        port (
            clk     : in std_logic;
            rst     : in std_logic;
            a       : in std_logic;
            b       : in std_logic;
            count   : out std_logic_vector(3 downto 0)
        );
    end component;
    
    signal sig_clk      : std_logic;
    signal sig_rst      : std_logic;
    signal sig_a, sig_b : std_logic;
    signal sig_count    : std_logic_vector(3 downto 0);
begin
    encoder0 : encoder port map (
        clk     => sig_clk,
        rst     => sig_rst,
        a       => sig_a,
        b       => sig_b,
        count   => sig_count
    );
    
    -- generate 1 khz clock
    system_clk : process begin
        while true loop
            sig_clk <= '1';
            wait for 0.5 ms;
            sig_clk <= '0';
            wait for 0.5 ms;
        end loop;
    end process;
    
    encoder_test : process begin
        sig_rst <= '1';
        sig_a <= '0';
        sig_b <= '0';
        wait for 2 ms;
        sig_rst <= '0';
    
        for x in 0 to 4 loop
            -- increment test
            sig_a <= '0';
            sig_b <= '0';
            wait for 3 ms;
            
            sig_a <= '1';
            sig_b <= '0';
            wait for 3 ms;
            
            sig_a <= '1';
            sig_b <= '1';
            wait for 3 ms;
            
            sig_a <= '0';
            sig_b <= '1';
            wait for 3 ms;
        end loop;
        
        for x in 0 to 4 loop
            -- decrement test
            sig_a <= '0';
            sig_b <= '0';
            wait for 3 ms;
            
            sig_a <= '0';
            sig_b <= '1';
            wait for 3 ms;
            
            sig_a <= '1';
            sig_b <= '1';
            wait for 3 ms;
            
            sig_a <= '1';
            sig_b <= '0';
            wait for 3 ms;
        end loop;
        
        wait;
    end process;
end Behavioral;
