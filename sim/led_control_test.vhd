----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/20/2024 10:55:59 AM
-- Design Name: 
-- Module Name: led_control_test - Behavioral
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

entity led_control_test is
--  Port ( );
end led_control_test;

architecture Behavioral of led_control_test is
    component led_control is
        port (
            clk         : in std_logic;
            rst         : in std_logic;
            brightness  : in std_logic_vector(3 downto 0);
            en          : in std_logic;
            led         : out std_logic
        );
    end component;
    
    signal sig_clk          : std_logic;
    signal sig_rst          : std_logic;
    signal sig_brightness    : std_logic_vector(3 downto 0);
    signal sig_en           : std_logic;
    signal sig_led          : std_logic;
begin
    led_control0 : led_control port map (
        clk         => sig_clk,
        rst         => sig_rst,
        brightness  => sig_brightness,
        en          => sig_en,
        led         => sig_led
    );
    
    system_clk : process begin
        sig_clk <= '1';
        wait for 40 ns;
        sig_clk <= '0';
        wait for 40 ns;
    end process;
    
    led_control_test : process begin
        sig_rst <= '1';
        sig_brightness <= x"0";
        sig_en <= '0';
        wait for 80 ns;
        sig_rst <= '0';
        wait for 80 ns;
    
        sig_en <= '1';
        sig_brightness <= x"2";
        wait for 100 ms;
        
        sig_brightness <= x"a";
        wait for 100 ms;
        
        sig_en <= '0';
        wait for 80 ns;
    
        wait;
    end process;
end Behavioral;
