----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/19/2024 10:06:40 PM
-- Design Name: 
-- Module Name: debounce_test - Behavioral
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

entity debounce_test is
--  Port ( );
end debounce_test;

architecture Behavioral of debounce_test is
    component debounce is
        port (
            button      : in std_logic;
            clk         : in std_logic;
            rst         : in std_logic;
            debounced   : out std_logic
        );
    end component;
    
    signal sig_button       : std_logic;
    signal sig_clk          : std_logic;
    signal sig_rst          : std_logic;
    signal sig_debounced    : std_logic;
begin
    debounce0 : debounce port map (
        button      => sig_button,
        clk         => sig_clk,
        rst         => sig_rst,
        debounced   => sig_debounced
    );
    
    -- generate 1 kHz clock signals
    clk_system : process begin
        while true loop
            sig_clk <= '1';
            wait for 0.5 ms;
            sig_clk <= '0';
            wait for 0.5 ms;
        end loop;
    end process;
    
    debounce_test : process begin
        -- init
        report "initialize";
        sig_rst <= '1';
        wait for 0.8 ms;
        sig_rst <= '0';
    
        -- bounce test (0)
        report "test bounce LOW [1]";
        sig_button <= '0';
        wait for 0.5 ms;
        sig_button <= '1';
        wait for 0.12 ms;
        sig_button <= '0';
        wait for 0.2 ms;
        sig_button <= '1';
        wait for 0.2 ms;
        sig_button <= '0';
        wait for 10 ms;
       
        -- bounce test (1)
        report "test bounce LOW [2]";
        sig_button <= '1';
        wait for 0.5 ms;
        sig_button <= '0';
        wait for 0.8 ms;
        sig_button <= '1';
        wait for 0.5 ms;
        sig_button <= '0';
        wait for 0.6 ms;
        sig_button <= '1';
        wait for 10 ms;
        
        -- bounce test (0)
        report "test bounce LOW [3]";
        sig_button <= '0';
        wait for 0.2 ms;
        sig_button <= '1';
        wait for 0.10 ms;
        sig_button <= '0';
        wait for 0.12 ms;
        sig_button <= '1';
        wait for 0.3 ms;
        sig_button <= '0';
        wait for 10 ms;
       
        -- bounce test (1)
        report "test bounce LOW [4]";
        sig_button <= '1';
        wait for 0.4 ms;
        sig_button <= '0';
        wait for 0.16 ms;
        sig_button <= '1';
        wait for 0.1 ms;
        sig_button <= '0';
        wait for 0.4 ms;
        sig_button <= '1';
        wait for 10 ms;
        
        report "test finish";
        wait; -- end
    end process;
end Behavioral;
