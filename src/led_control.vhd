----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Muhammad Shofuwan Anwar 
-- 
-- Create Date: 05/20/2024 10:21:36 AM
-- Design Name: 
-- Module Name: led_control - Behavioral
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

entity led_control is
    port (
        clk         : in std_logic;
        rst         : in std_logic;
        en          : in std_logic;
        sel         : in std_logic;
        brightness  : in std_logic_vector(3 downto 0);
        led         : out std_logic
    );
end led_control;

architecture Behavioral of led_control is
    component jkff is
        port (
            j       : in std_logic;
            k       : in std_logic;
            clk     : in std_logic;
            rst     : in std_logic;
            q       : out std_logic
        );
    end component;

    signal en_brightness    : std_logic; -- enabling control the brightness
    signal brightness_buff  : unsigned(3 downto 0) := x"0";
    signal pwm_count        : unsigned(3 downto 0);
begin
    jkff0 : jkff port map (
        j   => '1',
        k   => '1',
        clk => en,
        rst => rst,
        q   => en_brightness
    );

    control_process : process (clk, rst) begin
        if rst = '1' then
            pwm_count <= x"0";
            led <= '0';
            brightness_buff <= x"0";
        elsif rising_edge(clk) then
            if en_brightness = '1' and sel = '1' then
                brightness_buff <= unsigned(brightness);
            end if;
            
            if brightness_buff > pwm_count then
                led <= '1';
            else
                led <= '0';
            end if;
            
            pwm_count <= pwm_count + 1;
        end if;
    end process;
end Behavioral;
