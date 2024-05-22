----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Muhammad Shofuwan Anwar
-- 
-- Create Date: 05/19/2024 10:45:58 PM
-- Design Name: 
-- Module Name: LabExercise3_Top - Behavioral
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

entity LabExercise3_Top is
    port (
        clk         : in std_logic;
        rst         : in std_logic;
        a, b        : in std_logic;
        sw          : in std_logic_vector(1 downto 0);
        en          : in std_logic;
        led         : out std_logic_vector(3 downto 0)
    );
end LabExercise3_Top;

architecture Behavioral of LabExercise3_Top is
    component debounce is
        port (
            button      : in std_logic;
            clk         : in std_logic;
            rst         : in std_logic;
            debounced   : out std_logic
        );
    end component;
    
    component encoder is
        port (
            clk     : in std_logic;
            rst     : in std_logic;
            a       : in std_logic;
            b       : in std_logic;
            count   : out std_logic_vector(3 downto 0)
        );
    end component;
    
    component led_control is
        port (
            clk         : in std_logic;
            rst         : in std_logic;
            en          : in std_logic;
            sel         : in std_logic;
            brightness  : in std_logic_vector(3 downto 0);
            led         : out std_logic
        );
    end component;
    
    signal clk_buff     : unsigned(15 downto 0) := x"0000";
    signal clk_div      : std_logic; -- 50 MHz clk source
    
    signal debounced_a  : std_logic;
    signal debounced_b  : std_logic;
    signal debounced_en : std_logic;
    
    signal adjust_pwm   : std_logic_vector(3 downto 0);
    signal led_en_state : std_logic_vector(3 downto 0);
begin

    main_process : process (clk, rst) begin
        if rst = '1' then
            clk_div <= '0';
            clk_buff <= x"0000";
        elsif rising_edge(clk) then
            if clk_buff = 0 then -- 763 Hz
                clk_div <= not clk_div;
            end if;
            
            clk_buff <= clk_buff + 1;
        end if;
    end process;
    
    with sw select led_en_state <=
        "0001"  when "00",
        "0010"  when "01",
        "0100"  when "10",
        "1000"  when "11";

    -- ENCODER
    db_a0 : debounce port map (
        button      => a,
        clk         => clk_div,
        rst         => rst,
        debounced   => debounced_a
    );
    
    db_b0 : debounce port map (
        button      => b,
        clk         => clk_div,
        rst         => rst,
        debounced   => debounced_b
    );
    
    encoder0 : encoder port map (
        clk     => clk_div,
        rst     => rst,
        a       => debounced_a,
        b       => debounced_b,
        count   => adjust_pwm
    );
    
    -- LED CONTROL
    db_en0 : debounce port map (
        clk         => clk_div,
        rst         => rst,
        button      => en,
        debounced   => debounced_en
    );
    
    led0 : led_control port map (
        clk         => clk_div,
        rst         => rst,
        sel         => led_en_state(0),
        en          => debounced_en,
        brightness  => adjust_pwm,
        led         => led(0)
    );
    
    led1 : led_control port map (
        clk         => clk_div,
        rst         => rst,
        sel         => led_en_state(1),
        en          => debounced_en,
        brightness  => adjust_pwm,
        led         => led(1)
    );
    
    led2 : led_control port map (
        clk         => clk_div,
        rst         => rst,
        sel         => led_en_state(2),
        en          => debounced_en,
        brightness  => adjust_pwm,
        led         => led(2)
    );
    
    led3 : led_control port map (
        clk         => clk_div,
        rst         => rst,
        sel         => led_en_state(3),
        en          => debounced_en,
        brightness  => adjust_pwm,
        led         => led(3)
    );
    
end Behavioral;
