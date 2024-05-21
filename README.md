# LabExercise3_Top

## Description

This VHDL code defines the top-level module for a lab exercise project. The module, named `LabExercise3_Top`, integrates components for debouncing input signals, encoding input values, and controlling LED outputs based on these values. The design includes clock division, signal debouncing, and LED control logic.

## Entity Declaration

The `LabExercise3_Top` entity has the following ports:

- `clk`: Input clock signal.
- `rst`: Input reset signal.
- `a`, `b`: Input signals to be debounced and encoded.
- `sw`: 2-bit input switch signal to select which LED to control.
- `en`: Input enable signal.
- `led`: 4-bit output signal to drive the LEDs.

## Architecture

The architecture `Behavioral` contains the following components and signals:

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
        - `brightness`: Input signal to control brightness.
        - `en`: Enable signal.
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
    - On rising edge of the input clock, toggle the divided clock signal at a specific count.

2. **Debounce and Encoder**:
    - Debounce the input signals `a` and `b`.
    - Encode the debounced signals to produce the `adjust_pwm` signal.

3. **LED Control**:
    - Debounce the enable signal `en`.
    - Control the LEDs based on the debounced enable signal and switch positions.

### LED Enable State Logic

- The enable state for each LED is determined by the debounced enable signal and the switch positions:
    - `led_en_state(0)`: Enabled when both switches are off.
    - `led_en_state(1)`: Enabled when switch 0 is off and switch 1 is on.
    - `led_en_state(2)`: Enabled when switch 0 is on and switch 1 is off.
    - `led_en_state(3)`: Enabled when both switches are on.

## Dependencies

This code requires the components `debounce`, `encoder`, and `led_control` to be defined elsewhere in the project.

## Revision History

- **0.01**: Initial file creation on 05/19/2024 by Muhammad Shofuwan Anwar.

## Additional Comments

- This design assumes a 50 MHz input clock and divides it to a lower frequency for internal operations.
- Adjust the clock division and debounce logic parameters as needed for different input clock frequencies or application requirements.

## Usage

To use this module, instantiate it in a higher-level design and connect the appropriate signals as defined in the entity declaration.

