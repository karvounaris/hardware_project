# UART Sender-Receiver System with 7-Segment Display

## 📖 Project Overview
This project implements a UART-based communication system using Verilog. It consists of a sender (transmitter), a receiver, and a 7-segment LED display system. The aim is to demonstrate data transmission, decoding, and visualization of alphanumeric and special characters on a 4-digit 7-segment display.

## 🛠️ Features
- **UART Communication**: A robust sender-receiver system designed with the UART protocol for efficient data transfer.
- **7-Segment Display Driver**: Displays alphanumeric characters sent via the UART protocol on four 7-segment LED displays.
- **FSM Design**: State machines used for synchronized operation of the transmitter, receiver, and display driver.
- **Error Detection**: Incorporates mechanisms for identifying framing and parity errors during data reception.
- **Data Encoding/Decoding**: Supports encoding of data before transmission and decoding at the receiver end for display purposes.

## 📂 Repository Contents
- **`Project.pdf`**: Detailed documentation of the project (in greek) , including schematics, state machines, and test waveforms.
- Contains Verilog code for all modules, including:
  - `uart_transmitter.v`
  - `uart_receiver.v`
  - `7SegmentDisplayDriver.v`
  - Other supporting modules (e.g., `encoder`, `decoder`, `baud_controller`).
- Testbenches for verifying the functionality of individual modules and the integrated system.

## 📐 System Architecture
### Transmitter
- **Functionality**: Converts parallel data into a serial bitstream with start, stop, and parity bits.
- **Modules**:
  - `baud_controller`: Controls the timing of data transmission.
  - `data_insertion`: Inserts start, stop, and parity bits.
  - `output_bit_sequence`: Manages the serialized output.

### Receiver
- **Functionality**: Decodes the serial bitstream received from the transmitter and validates the data.
- **Modules**:
  - `baud_controller`: Synchronizes data reception.
  - `reception`: Decodes received bits into parallel data.
  - `error_detection`: Checks for framing and parity errors.

### 7-Segment Display Driver
- **Functionality**: Displays received alphanumeric characters on four 7-segment LEDs.
- **Modules**:
  - `which_digit`: Selects the active digit.
  - `led_decoder`: Converts binary data to 7-segment display format.
  - `driver`: Manages display updates.

### Encoding and Decoding
- **Encoding**: Reverses the bit order for secure transmission.
- **Decoding**: Restores the original bit order and prepares data for display.

## 🚀 How to Run
1. Clone the repository: 
   ```bash
   git clone https://github.com/your-username/your-repository.git
   ```
2. Open the Verilog files in a simulation environment (e.g., ModelSim, EDA Playground).
3. Run the testbenches.
4. Observe the waveforms and verify the correctness of data transmission and display output.

## 📊 Results
- Successful transmission of alphanumeric and special characters.
- Accurate error detection and handling.
- Correct display synchronization across all 7-segment LEDs.

## 📝 Notes
- Clock frequency: 20ns period.
- Synchronization issues resolved using delay registers.
- Future Work: Extend the system for additional displays and implement advanced error correction techniques.

## 🤝 Contributors
- [Panagiotis Karvounaris](https://github.com/karvounaris)
- [Konstantina Bosinaki](https://github.com/Nantina)

## 📬 Contact
For questions or collaboration, feel free to reach out via GitHub.

---

Thank you for checking out this project! 😊
