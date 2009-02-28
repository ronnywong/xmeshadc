/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: HPLRF230.h,v 1.1.2.2 2007/04/27 05:00:41 njain Exp $
 */

#include <util/crc16.h>  //provides _crc_ccitt_update() functions
#include "AM.h"	//hack?

/* === Initialization functions ============================================ */

/**
 *	Enable SPI.  Set it as master.  Double speed.  Set pin directions
 *  We do not disable the spi, ever.  (note for power management)
 */
inline void initSPIMaster() {
	TOSH_MAKE_MISO_INPUT();		
	TOSH_MAKE_MOSI_OUTPUT();
	TOSH_MAKE_SPI_SCK_OUTPUT();	
	TOSH_MAKE_SPI_CS_OUTPUT();
	TOSH_SET_SPI_CS_PIN();			//active low
	
	SPSR = (_BV(SPI2X));				//double speed	
	SPCR = (_BV(SPE) | _BV(MSTR));		//spi enable, master
}

/**
 *	Set pin directions.  Set pin levels
 */
inline void initRadioGPIO() {		
	TOSH_MAKE_RF230_SLP_TR_OUTPUT();
	TOSH_MAKE_RF230_RSTN_OUTPUT();
	TOSH_MAKE_RF230_IRQ_INPUT();	//used for input capture
	TOSH_MAKE_RF230_CLKM_INPUT();
	
	TOSH_SET_RF230_RSTN_PIN();
	TOSH_CLR_RF230_SLP_TR_PIN();
	TOSH_CLR_RF230_IRQ_PIN();
	TOSH_CLR_RF230_CLKM_PIN();
}

/* === RF230 Register Access =============================================== */

/**
 *	@brief Convenience macro for waiting for SPI completion
 *
 */

#define SPI_WAITFOR() do { while ((SPSR & (1 << SPIF)) == 0) ; } while(0)

/**
 * @brief Write Register
 *
 * This function write to a transceiver register.
 * @param addr Address of the Register in the Transceiver (Offset) that should be written
 * @param val Byte that will be written into the Register
 */

inline void bios_reg_write(uint8_t addr, uint8_t val)
{
    addr=TRX_CMD_RW | (TRX_CMD_RADDRM & addr);

    // Select transceiver
    TOSH_CLR_SPI_CS_PIN();

    SPDR = addr;
    SPI_WAITFOR();
    SPDR = val;
    SPI_WAITFOR();

    TOSH_SET_SPI_CS_PIN();
}


/**
 * @brief Read Register
 *
 * This function reads a transceiver register.
 * @param addr Address of the Register in the Transceiver (Offset) that should be read
 * @return Contents of the Register
 */
inline uint8_t bios_reg_read(uint8_t addr)
{

    uint8_t val;

    addr=TRX_CMD_RR | (TRX_CMD_RADDRM & addr);

    // Select transceiver
    TOSH_CLR_SPI_CS_PIN();


    SPDR = addr;
    SPI_WAITFOR();
    SPDR = addr;        /* dummy out */
    SPI_WAITFOR();
    val = SPDR;

    TOSH_SET_SPI_CS_PIN();

    return val;
}


/* === RF230 Register Bits Access ========================================== */

/**
 * @brief subregister read
 *
 * @param   addr  offset of the register
 * @param   mask  bit mask of the subregister
 * @param   pos   bit position of the subregister
 * @retval  data  pointer where the read and demuxed value is stored
 *
 * @code
 *   pos = 4, mask = 0xf0
 *   register value = 0xA5
 *   *data = 0x0A
 * @endcode
 */

inline void bios_bit_read(uint8_t addr, uint8_t mask, uint8_t pos, uint8_t *data)
{
    *data = bios_reg_read(addr);
    *data &= mask;
    *data >>= pos;
    return;
}

/**
 * @brief subregister write
 *
 * @param   addr  offset of the register
 * @param   mask  bit mask of the subregister
 * @param   pos   bit position of the subregister
 * @retval  value  data, which is muxed into the register
 *
 * @code
 *   pos = 4, mask = 0xf0
 *   register value = 0xA5 (before operation)
 *   value = 0x05
 *   register value = 0x55 (after operation)
 * @endcode
 *
 */
inline void bios_bit_write(uint8_t addr, uint8_t mask, uint8_t pos, uint8_t value)
{

	uint8_t tmp;
    tmp = bios_reg_read(addr);
    tmp &= ~mask;
    value <<= pos;
    value &=mask;
    value |= tmp;
    bios_reg_write(addr, value);
    return;
}

/* === RF230 Frame Access ================================================== */

/**
 * @brief Frame Write
 *
 * This function writes a frame to the transceiver.
 *
 * @param length Length of the frame that should be written into the frame buffer
 * @param data Pointer to an array of (Payload-) bytes that should be sent
 * @note SLP_TR! (RADIO_TYPE == AT86RF230)
 */

inline void bios_frame_write(uint8_t length, uint8_t *data)
{

	//NOTE:
	// do not put the length byte into frame
	// length does not include the length byte
	
    // Select transceiver
    TOSH_CLR_SPI_CS_PIN();

    SPDR = TRX_CMD_FW;
    SPI_WAITFOR();
    SPDR = length;

    do
    {
        SPI_WAITFOR();
        SPDR = *data++;
    }
    while (--length > 0);

    SPI_WAITFOR(); /* wait here until last byte is out -
                    * otherwise underrun irq */

    // Deselect Slave
    TOSH_SET_SPI_CS_PIN();
}

/**
 * @brief Frame Read
 *
 * This function reads a frame from the transceiver.
 *
 * @retval data Pointer to an array of (Payload-) bytes that should be sent
 * @return length of the downloaded frame (including the LQI byte [RADIO_TYPE == AT86RF230])
 */

inline uint8_t bios_frame_read(uint8_t *data)
{
	//NOTE:
	//buffer contains payload + lqi
	//length byte returned not included in payload
	
    uint8_t length = 0;
    uint8_t i = 0;

    // Select transceiver
    TOSH_CLR_SPI_CS_PIN();

    SPDR = TRX_CMD_FR;
    SPI_WAITFOR();
    SPDR = 0;       /* dummy out */
    SPI_WAITFOR();
    *data++ = length = i = SPDR + 1; /* read length */
    do
    {
        SPDR = 0;   /* dummy out */
        SPI_WAITFOR();
        *data++ = SPDR;
    }
    while (--i > 0);

    // Deselect Slave
    TOSH_SET_SPI_CS_PIN();
    // Return "OK"
    return length;	//length includes lqi byte
}

/**
 * @brief Frame Read and check CRC-16
 *
 * This function reads a frame from the transceiver, and checks the
 * CRC-16 of the received frame.  For failed CRC checks, the length
 * indication of the returned frame will be set to 0.
 *
 * @retval data Pointer to an array of (Payload-) bytes that should be sent
 * @return length of the downloaded frame (including the LQI byte [RADIO_TYPE == AT86RF230])
 */

inline uint8_t bios_frame_crc_read(uint8_t *d)
{
    uint8_t *data = d;
    uint8_t length = 0;
    uint8_t i = 0;
    uint16_t crc = 0;

    // Select transceiver
    TOSH_CLR_SPI_CS_PIN();

    SPDR = TRX_CMD_FR;
    SPI_WAITFOR();
    SPDR = 0;       /* dummy out */
    SPI_WAITFOR();
    *data = length = SPDR + 1; /* read length */
    i = length - 1;

    //wraps to negative when < 3
    //overflows buffer when > data length
    if (length > 3 && length <= MSG_HEADER_SIZE +TOSH_DATA_LENGTH + MSG_FOOTER_SIZE +1)
    {

        data++;
        SPDR = 0;   /* dummy out */
        SPI_WAITFOR();
        *data = SPDR;   /* read the first byte */
        i--;
        do
        {
            SPDR = 0;   /* dummy out */
            crc = CRC_CCITT_UPDATE(crc, *data);
            data++;
            SPI_WAITFOR();
            *data = SPDR;
        }
        while (--i > 0);
        SPDR = 0;   /* dummy out */
        crc = CRC_CCITT_UPDATE(crc, *data);
        data++;
        SPI_WAITFOR();
        *data = SPDR; /* read LQI value */
        if (crc != 0)
        {
	        length = 0;
            *d = 0;
        }
    }
    else
    {
		length = 0;
        *d = 0;
    }

    // Deselect Slave
    TOSH_SET_SPI_CS_PIN();
    // Return "OK"
    return length;
}

/**
 * @brief generate CRC16
 *
 * generate FCS field according to IEEE 802.15.4-2003 7.2.18
 * generator polynomial is G(x) = x^16 + x^12 + x^5 + 1
 *
 * @param msg The octetstring which should be checked
 */
inline void bios_gen_crc16(uint8_t *msg)
{
    uint16_t taps;
    uint8_t  j, end;
    uint8_t  *octet = &msg[1];

    end = *msg;
    taps = 0x0000;

    if (end >= 2)  //length includes the FCS
    {
        end = end - 2;
        for (j = 0; j < end; j++)
        {
            taps = CRC_CCITT_UPDATE(taps, octet[j]);
        }
        /* write out remainder to last 2 octets */
        /* the LSB of the octet is transmitted first */
        octet[j] = (uint8_t) ((taps) & 0x00FF);
        j++;
        octet[j] = (uint8_t) (((taps) >> 8) & 0x00FF) ;
    }
}

/**
 * @brief Frame Length Read (RADIO_TYPE == AT86RF230)
 *
 * This function reads the length of a frame from the transceiver.
 *
 * @return length of the frame to download (including the LQI byte)
 */

inline uint8_t bios_frame_length_read()
{
	//NOTE:
	// length = payload + lqi = payload + 1
	
    uint8_t length = 0;

    // Select transceiver
    TOSH_CLR_SPI_CS_PIN();

    SPDR = TRX_CMD_FR;
    SPI_WAITFOR();
    SPDR = 0;       /* dummy out */
    SPI_WAITFOR();
    length = SPDR + 1; /* read length */
    // Deselect Slave
    TOSH_SET_SPI_CS_PIN();
    // Return "OK"
    return length;
}

/**
 * @brief Bytes Read
 *
 * This function reads a number of bytes specified by the len parameter.
 *
 */

inline void bios_bytes_read(uint8_t length, uint8_t *data)
{
    uint8_t i = length;

    // Select transceiver
    TOSH_CLR_SPI_CS_PIN();

    SPDR = TRX_CMD_FR;
    SPI_WAITFOR();
    
    do
    {
        SPDR = 0;   /* dummy out */
        SPI_WAITFOR();
        *data++ = SPDR;
    }
    while (--i > 0);

    // Deselect Slave
    TOSH_SET_SPI_CS_PIN();
}

/**
 * @brief Bytes Clear
 *
 * This function reads out a number of bytes specified by the len parameter.
 * It does not save these bytes
 *
 */

inline void bios_bytes_clear(uint8_t length)
{
    uint8_t i = length;

    // Select transceiver
    TOSH_CLR_SPI_CS_PIN();

    SPDR = TRX_CMD_FR;
    SPI_WAITFOR();
    
    do
    {
        SPDR = 0;   /* dummy out */
        SPI_WAITFOR();
    }
    while (--i > 0);

    // Deselect Slave
    TOSH_SET_SPI_CS_PIN();
}

/**
 * @brief Write SRAM
 *
 * This function writes into the SRAM of the transceiver.
 *
 * @param addr Address in the TRX's SRAM where the write burst should start
 * @param length Length of the write burst
 * @param data Pointer to an array of bytes that should be written
 */

inline void bios_sram_write(uint8_t addr, uint8_t length, uint8_t *data)
{

    // Select transceiver
    TOSH_CLR_SPI_CS_PIN();

    SPDR = TRX_CMD_SW;
    SPI_WAITFOR();
    SPDR = addr;
    SPI_WAITFOR();
    do
    {
        SPDR = *data++;
        SPI_WAITFOR();
    }
    while (--length > 0);

    // Deselect Slave
    TOSH_SET_SPI_CS_PIN();
}

/**
 * @brief Read SRAM
 *
 * @param addr Address in the TRX's SRAM where the read burst should start
 * @param length Length of the write burst
 * @retval data Pointer to an array of bytes that should be read
 */

inline void bios_sram_read(uint8_t addr, uint8_t length, uint8_t *data)
{

    // Select transceiver
    TOSH_CLR_SPI_CS_PIN();

    SPDR = TRX_CMD_SR;
    SPI_WAITFOR();
    SPDR = addr;
    SPI_WAITFOR();
    do
    {
        SPDR = 0;   /* dummy out */
        SPI_WAITFOR();
        *data++ = SPDR;
    }
    while (--length > 0);

    // Deselect Slave
    TOSH_SET_SPI_CS_PIN();
}
