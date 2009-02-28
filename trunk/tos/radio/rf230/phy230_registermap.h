/*
 * Copyright (c) 2004-2007 Crossbow Technology, Inc.
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: phy230_registermap.h,v 1.1.2.2 2007/04/27 05:03:20 njain Exp $
 */
 
#ifndef PHY230_REGISTERMAP_H
#define PHY230_REGISTERMAP_H
#define RG_TRX_STATUS                    (0x01)
#    define SR_CCA_DONE                  0x01, 0x80, 7
#    define SR_CCA_STATUS                0x01, 0x40, 6
#    define SR_TST_STATUS                0x01, 0x20, 5
#    define SR_TRX_STATUS                0x01, 0x1f, 0
#        define P_ON                     (0)
#        define BUSY_RX                  (1)
#        define BUSY_TX                  (2)
#        define RX_ON                    (6)
#        define TRX_OFF                  (8)
#        define PLL_ON                   (9)
#        define SLEEP                    (15)
#        define BUSY_RX_AACK             (17)
#        define BUSY_TX_ARET             (18)
#        define RX_AACK_ON               (22)
#        define TX_ARET_ON               (25)
#        define RX_ON_NOCLK              (28)
#        define RX_AACK_ON_NOCLK         (29)
#        define BUSY_RX_AACK_NOCLK       (30)
#define RG_TRX_STATE                     (0x02)
#    define SR_TRAC_STATUS               0x02, 0xe0, 5
#    define SR_TRX_CMD                   0x02, 0x1f, 0
#        define CMD_NOP                  (0)
#        define CMD_TX_START             (2)
#        define CMD_FORCE_TRX_OFF        (3)
#        define CMD_RX_ON                (6)
#        define CMD_TRX_OFF              (8)
#        define CMD_PLL_ON               (9)
#        define CMD_RX_AACK_ON           (22)
#        define CMD_TX_ARET_ON           (25)
#define RG_TRX_CTRL_0                    (0x03)
#    define SR_PAD_IO                    0x03, 0xc0, 6
#    define SR_PAD_IO_CLKM               0x03, 0x30, 4
#        define CLKM_2mA                 (0)
#        define CLKM_4mA                 (1)
#        define CLKM_6mA                 (2)
#        define CLKM_8mA                 (3)
#    define SR_CLKM_SHA_SEL              0x03, 0x08, 3
#    define SR_CLKM_CTRL                 0x03, 0x07, 0
#        define CLKM_noclock             (0)
#        define CLKM_1MHz                (1)
#        define CLKM_2MHz                (2)
#        define CLKM_4MHz                (3)
#        define CLKM_8MHz                (4)
#        define CLKM_16MHz               (5)
#define RG_PHY_TX_PWR                    (0x05)
#    define SR_TX_AUTO_CRC_ON            0x05, 0x80, 7
#    define SR_reserved_05_2             0x05, 0x70, 4
#    define SR_TX_PWR                    0x05, 0x0f, 0
#define RG_PHY_RSSI                      (0x06)
#    define SR_RX_CRC_VALID              0x06, 0x80, 7
#    define SR_reserved_06_2             0x06, 0x60, 5
#    define SR_RSSI                      0x06, 0x1f, 0
#define RG_PHY_ED_LEVEL                  (0x07)
#    define SR_ED_LEVEL                  0x07, 0xff, 0
#define RG_PHY_CC_CCA                    (0x08)
#    define SR_CCA_REQUEST               0x08, 0x80, 7
#    define SR_CCA_MODE                  0x08, 0x60, 5
#    define SR_CHANNEL                   0x08, 0x1f, 0
#define RG_CCA_THRES                     (0x09)
#    define SR_CCA_CS_THRES              0x09, 0xf0, 4
#    define SR_CCA_ED_THRES              0x09, 0x0f, 0
#define RG_RX_CTRL                       (0x0a)
#    define SR_SDM_MODE                  0x0a, 0xc0, 6
#        define X_selectSDM1_DCUON       (0)
#        define X_selectSDM2_DCUOFF      (1)
#        define X_selectSDM2_DCUON       (2)
#        define X_selectSDM3_DCUOFF      (3)
#    define SR_ACR_MODE                  0x0a, 0x20, 5
#    define SR_SOFT_MODE                 0x0a, 0x10, 4
#    define SR_PDT_THRES                 0x0a, 0x0f, 0
#define RG_SFD_VALUE                     (0x0b)
#    define SR_SFD_VALUE                 0x0b, 0xff, 0
#define RG_ALT_RATE                      (0x0c)
#    define SR_RX_RATE                   0x0c, 0xc0, 6
#        define RX_250kbs                (0)
#        define RX_500kbs                (1)
#        define RX_1mbs                  (2)
#        define RX_2mbs                  (3)
#    define SR_reserved_0c_2             0x0c, 0x3c, 2
#    define SR_CW_BLK_MODE               0x0c, 0x04, 2
#    define SR_DATA_RATE                 0x0c, 0x03, 0
#        define ALTRATE_250kbs           (0)
#        define ALTRATE_500kbs           (1)
#        define ALTRATE_1mbs             (2)
#        define ALTRATE_2mbs             (3)
#define RG_IRQ_MASK                      (0x0e)
#    define SR_IRQ_MASK                  0x0e, 0xff, 0
#define RG_IRQ_STATUS                    (0x0f)
#    define SR_IRQ_7_BAT_LOW             0x0f, 0x80, 7
#    define SR_IRQ_6_TRX_UR              0x0f, 0x40, 6
#    define SR_IRQ_5                     0x0f, 0x20, 5
#    define SR_IRQ_4                     0x0f, 0x10, 4
#    define SR_IRQ_3_TRX_END             0x0f, 0x08, 3
#    define SR_IRQ_2_RX_START            0x0f, 0x04, 2
#    define SR_IRQ_1_PLL_UNLOCK          0x0f, 0x02, 1
#    define SR_IRQ_0_PLL_LOCK            0x0f, 0x01, 0
#define RG_VREG_CTRL                     (0x10)
#    define SR_AVREG_EXT                 0x10, 0x80, 7
#    define SR_AVDD_OK                   0x10, 0x40, 6
#    define SR_AVREG_TRIM                0x10, 0x30, 4
#        define AVREG_1_80V              (0)
#        define AVREG_1_75V              (1)
#        define AVREG_1_84V              (2)
#        define AVREG_1_88V              (3)
#    define SR_DVREG_EXT                 0x10, 0x08, 3
#    define SR_DVDD_OK                   0x10, 0x04, 2
#    define SR_DVREG_TRIM                0x10, 0x03, 0
#        define DVREG_1_80V              (0)
#        define DVREG_1_75V              (1)
#        define DVREG_1_84V              (2)
#        define DVREG_1_88V              (3)
#define RG_BATMON                        (0x11)
#    define SR_reserved_11_1             0x11, 0xc0, 6
#    define SR_BATMON_OK                 0x11, 0x20, 5
#    define SR_BATMON_HR                 0x11, 0x10, 4
#    define SR_BATMON_VTH                0x11, 0x0f, 0
#define RG_XOSCO_CTRL                    (0x12)
#    define SR_XTAL_MODE                 0x12, 0xf0, 4
#    define SR_XTAL_TRIM                 0x12, 0x0f, 0
#define RG_FTN_CTRL                      (0x18)
#    define SR_FTN_START                 0x18, 0x80, 7
#    define SR_FTN_ROUND                 0x18, 0x40, 6
#    define SR_FTNV                      0x18, 0x3f, 0
#define RG_RF_CTRL                       (0x19)
#    define SR_PLL_VCOB_VF               0x19, 0xc0, 6
#    define SR_PA_BUF_VF                 0x19, 0x30, 4
#    define SR_LNA_VF2                   0x19, 0x0c, 2
#    define SR_LNA_VF1                   0x19, 0x03, 0
#define RG_PLL_CF                        (0x1a)
#    define SR_PLL_CF_START              0x1a, 0x80, 7
#    define SR_EN_PLL_CF                 0x1a, 0x40, 6
#    define SR_PLL_VMOD_TUNE             0x1a, 0x30, 4
#    define SR_PLL_CF                    0x1a, 0x0f, 0
#define RG_PLL_DCU                       (0x1b)
#    define SR_PLL_DCU_START             0x1b, 0x80, 7
#    define SR_reserved_1b_2             0x1b, 0x40, 6
#    define SR_PLL_DCUW                  0x1b, 0x3f, 0
#define RG_PART_NUM                      (0x1c)
#    define SR_PART_NUM                  0x1c, 0xff, 0
#        define RF210                    (0)
#        define RF220                    (1)
#        define RF230                    (2)
#define RG_VERSION_NUM                   (0x1d)
#    define SR_VERSION_NUM               0x1d, 0xff, 0
#define RG_MAN_ID_0                      (0x1e)
#    define SR_MAN_ID_0                  0x1e, 0xff, 0
#define RG_MAN_ID_1                      (0x1f)
#    define SR_MAN_ID_1                  0x1f, 0xff, 0
#define RG_SHORT_ADDR_0                  (0x20)
#    define SR_SHORT_ADDR_0              0x20, 0xff, 0
#define RG_SHORT_ADDR_1                  (0x21)
#    define SR_SHORT_ADDR_1              0x21, 0xff, 0
#define RG_PAN_ID_0                      (0x22)
#    define SR_PAN_ID_0                  0x22, 0xff, 0
#define RG_PAN_ID_1                      (0x23)
#    define SR_PAN_ID_1                  0x23, 0xff, 0
#define RG_IEEE_ADDR_0                   (0x24)
#    define SR_IEEE_ADDR_0               0x24, 0xff, 0
#define RG_IEEE_ADDR_1                   (0x25)
#    define SR_IEEE_ADDR_1               0x25, 0xff, 0
#define RG_IEEE_ADDR_2                   (0x26)
#    define SR_IEEE_ADDR_2               0x26, 0xff, 0
#define RG_IEEE_ADDR_3                   (0x27)
#    define SR_IEEE_ADDR_3               0x27, 0xff, 0
#define RG_IEEE_ADDR_4                   (0x28)
#    define SR_IEEE_ADDR_4               0x28, 0xff, 0
#define RG_IEEE_ADDR_5                   (0x29)
#    define SR_IEEE_ADDR_5               0x29, 0xff, 0
#define RG_IEEE_ADDR_6                   (0x2a)
#    define SR_IEEE_ADDR_6               0x2a, 0xff, 0
#define RG_IEEE_ADDR_7                   (0x2b)
#    define SR_IEEE_ADDR_7               0x2b, 0xff, 0
#define RG_XAH_CTRL                      (0x2c)
#    define SR_MAX_FRAME_RETRIES         0x2c, 0xf0, 4
#    define SR_MAX_CSMA_RETRIES          0x2c, 0x0e, 1
#    define SR_SLOTTED_OPERATION         0x2c, 0x01, 0
#define RG_CSMA_SEED_0                   (0x2d)
#    define SR_CSMA_SEED_0               0x2d, 0xff, 0
#define RG_CSMA_SEED_1                   (0x2e)
#    define SR_MIN_BE                    0x2e, 0xc0, 6
#    define SR_reserved_2e_2             0x2e, 0x30, 4
#    define SR_I_AM_COORD                0x2e, 0x08, 3
#    define SR_CSMA_SEED_1               0x2e, 0x07, 0
#endif /* PHY230_REGISTERMAP_H */
