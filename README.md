# LabExercise3_Top

## Description

This VHDL code describes the top-level module for a lab exercise project named `LabExercise3_Top`. The module is designed to debounce input signals, encode them, and control the brightness of multiple LEDs based on the encoded values and switch positions.

## Entity Declaration

The `LabExercise3_Top` entity has the following ports:

- `clk`: Input clock signal.
- `rst`: Input reset signal.
- `a`, `b`: Input signals to be debounced and encoded.
- `sw`: 2-bit input switch signal for selecting which LED to control.
- `en`: Input enable signal.
- `led`: 4-bit output signal for controlling the LEDs.

## Architecture

The architecture `Behavioral` includes the following components and signals:

### Components

1. **debounce**: Debounces an input signal.
    - Ports:
        - `button`: Input signal to debounce.
        - `clk`: Clock signal.
        - `rst`: Reset signal.
        - `debounced`: Debounced output signal.

2. **encoder**: Encodes the debounced signals into a count.
    - Ports:
        - `clk`: Clock signal.
        - `rst`: Reset signal.
        - `a`: Debounced input signal `a`.
        - `b`: Debounced input signal `b`.
        - `count`: Encoded output signal.

3. **led_control**: Controls the brightness of an LED.
    - Ports:
        - `clk`: Clock signal.
        - `rst`: Reset signal.
        - `en`: Enable signal.
        - `sel`: Selection signal for the LED.
        - `brightness`: Input signal to control brightness.
        - `led`: LED output signal.

### Signals

- `clk_buff`: Buffer for clock division.
- `clk_div`: Divided clock signal.
- `debounced_a`, `debounced_b`, `debounced_en`: Debounced input signals.
- `adjust_pwm`: Signal to adjust PWM for LED brightness.
- `led_en_state`: Intermediate enable state for LEDs.

### Processes and Mapping

1. **Clock Division**: A process to divide the input clock signal to a lower frequency.
    - If reset is active, reset the clock division.
    - On the rising edge of the input clock, toggle the divided clock signal at a specific count.

2. **LED Enable State**: The enable state for each LED is determined by the switch positions using a `with select` statement.
    - `led_en_state` is set based on the value of `sw`.

3. **Debounce and Encoder**:
    - Debounce the input signals `a` and `b`.
    - Encode the debounced signals to produce the `adjust_pwm` signal.

4. **LED Control**:
    - Debounce the enable signal `en`.
    - Control each LED based on the debounced enable signal, the switch positions, and the encoded brightness value.

## Dependencies

This code requires the components `debounce`, `encoder`, and `led_control` to be defined elsewhere in the project.

## Revision History

- **0.01**: Initial file creation on 05/19/2024 by Muhammad Shofuwan Anwar.

## Additional Comments

- The design assumes a 50 MHz input clock and divides it to a lower frequency for internal operations.
- Adjust the clock division and debounce logic parameters as needed for different input clock frequencies or application requirements.

## Usage

To use this module, instantiate it in a higher-level design and connect the appropriate signals as defined in the entity declaration.
